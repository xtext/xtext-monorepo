/*******************************************************************************
 * Copyright (c) 2009, 2018 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.xtext.ui.contentassist;

import static com.google.common.collect.Iterables.*;
import static com.google.common.collect.Sets.*;
import static org.eclipse.xtext.util.Strings.*;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.IPath;
import org.eclipse.core.runtime.Path;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EAttribute;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EClassifier;
import org.eclipse.emf.ecore.EDataType;
import org.eclipse.emf.ecore.EEnum;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EReference;
import org.eclipse.emf.ecore.EStructuralFeature;
import org.eclipse.emf.ecore.EcoreFactory;
import org.eclipse.emf.ecore.EcorePackage;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.jdt.core.IJavaProject;
import org.eclipse.jdt.core.IPackageFragmentRoot;
import org.eclipse.jdt.core.JavaCore;
import org.eclipse.jdt.core.JavaModelException;
import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.Region;
import org.eclipse.jface.text.contentassist.ICompletionProposal;
import org.eclipse.jface.viewers.StyledString;
import org.eclipse.xtext.AbstractElement;
import org.eclipse.xtext.AbstractMetamodelDeclaration;
import org.eclipse.xtext.AbstractRule;
import org.eclipse.xtext.Action;
import org.eclipse.xtext.Assignment;
import org.eclipse.xtext.CrossReference;
import org.eclipse.xtext.EcoreUtil2;
import org.eclipse.xtext.EnumRule;
import org.eclipse.xtext.GeneratedMetamodel;
import org.eclipse.xtext.Grammar;
import org.eclipse.xtext.GrammarUtil;
import org.eclipse.xtext.Keyword;
import org.eclipse.xtext.Parameter;
import org.eclipse.xtext.ParserRule;
import org.eclipse.xtext.ReferencedMetamodel;
import org.eclipse.xtext.RuleCall;
import org.eclipse.xtext.TerminalRule;
import org.eclipse.xtext.TypeRef;
import org.eclipse.xtext.XtextFactory;
import org.eclipse.xtext.XtextPackage;
import org.eclipse.xtext.naming.IQualifiedNameConverter;
import org.eclipse.xtext.naming.QualifiedName;
import org.eclipse.xtext.nodemodel.ICompositeNode;
import org.eclipse.xtext.nodemodel.ILeafNode;
import org.eclipse.xtext.nodemodel.INode;
import org.eclipse.xtext.nodemodel.util.NodeModelUtils;
import org.eclipse.xtext.resource.EObjectDescription;
import org.eclipse.xtext.resource.ForwardingEObjectDescription;
import org.eclipse.xtext.resource.IEObjectDescription;
import org.eclipse.xtext.services.XtextGrammarAccess;
import org.eclipse.xtext.ui.editor.contentassist.ConfigurableCompletionProposal;
import org.eclipse.xtext.ui.editor.contentassist.ContentAssistContext;
import org.eclipse.xtext.ui.editor.contentassist.FQNPrefixMatcher;
import org.eclipse.xtext.ui.editor.contentassist.ICompletionProposalAcceptor;
import org.eclipse.xtext.ui.editor.contentassist.PrefixMatcher;
import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultHighlightingConfiguration;
import org.eclipse.xtext.ui.label.StylerFactory;
import org.eclipse.xtext.util.Strings;
import org.eclipse.xtext.xtext.AnnotationNames;
import org.eclipse.xtext.xtext.UsedRulesFinder;
import org.eclipse.xtext.xtext.ui.editor.syntaxcoloring.SemanticHighlightingCalculator;
import org.eclipse.xtext.xtext.ui.editor.syntaxcoloring.SemanticHighlightingConfiguration;

import com.google.common.base.Function;
import com.google.common.base.Predicate;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.google.inject.Inject;

public class XtextProposalProvider extends AbstractXtextProposalProvider {

	@Inject
	private DefaultHighlightingConfiguration defaultLexicalHighlightingConfiguration;

	@Inject
	private SemanticHighlightingConfiguration semanticHighlightingConfiguration;

	@Inject
	private StylerFactory stylerFactory;

	@Inject
	private XtextGrammarAccess grammarAccess;

	@Inject
	private ClassifierQualifiedNameConverter classifierQualifiedNameConverter;
	
	@Inject
	private FQNPrefixMatcher fqnPrefixMatcher;

	public static class ClassifierPrefixMatcher extends PrefixMatcher {
		private PrefixMatcher delegate;

		private IQualifiedNameConverter qualifiedNameConverter;

		public ClassifierPrefixMatcher(PrefixMatcher delegate, IQualifiedNameConverter qualifiedNameConverter) {
			this.delegate = delegate;
			this.qualifiedNameConverter = qualifiedNameConverter;
		}

		@Override
		public boolean isCandidateMatchingPrefix(String name, String prefix) {
			if (delegate.isCandidateMatchingPrefix(name, prefix))
				return true;
			QualifiedName qualifiedName = qualifiedNameConverter.toQualifiedName(name);
			QualifiedName qualifiedPrefix = qualifiedNameConverter.toQualifiedName(prefix);
			if (qualifiedName.getSegmentCount() > 1) {
				if (qualifiedPrefix.getSegmentCount() == 1)
					return delegate.isCandidateMatchingPrefix(qualifiedName.getSegment(1),
							qualifiedPrefix.getFirstSegment());
				if (!delegate.isCandidateMatchingPrefix(qualifiedName.getFirstSegment(),
						qualifiedPrefix.getFirstSegment()))
					return false;
				return delegate.isCandidateMatchingPrefix(qualifiedName.getSegment(1), qualifiedPrefix.getSegment(1));
			}
			return false;
		}
	}
	
	public static class ClassifierQualifiedNameConverter extends IQualifiedNameConverter.DefaultImpl {
		@Override
		public String getDelimiter() {
			return "::";
		}
	}

	@Override
	public void completeGrammar_Name(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		Resource resource = model.eResource();
		URI uri = resource.getURI();
		if (uri.isPlatformResource()) {
			IPath path = new Path(uri.toPlatformString(true));
			IFile file = ResourcesPlugin.getWorkspace().getRoot().getFile(path);
			IProject project = file.getProject();
			IJavaProject javaProject = JavaCore.create(project);
			if (javaProject != null) {
				try {
					for (IPackageFragmentRoot packageFragmentRoot : javaProject.getPackageFragmentRoots()) {
						IPath packageFragmentRootPath = packageFragmentRoot.getPath();
						if (packageFragmentRootPath.isPrefixOf(path)) {
							IPath relativePath = path.makeRelativeTo(packageFragmentRootPath);
							relativePath = relativePath.removeFileExtension();
							String result = relativePath.toString();
							result = result.replace('/', '.');
							acceptor.accept(createCompletionProposal(result, context));
							return;
						}
					}
				} catch (JavaModelException ex) {
					// nothing to do
				}
			}
		}
	}
	
	@Override
	public void completeKeyword(Keyword keyword, ContentAssistContext contentAssistContext,
			ICompletionProposalAcceptor acceptor) {
		if (keyword == grammarAccess.getGrammarAccess().getCommaKeyword_2_2_0()) {
			// don't propose the comma after the used grammar
			return;
			
		} else if (keyword == grammarAccess.getAnnotationAccess().getCommercialAtKeyword_0()) {
			// don't propose the annotation's '@' within grammar ids
			final Object ge = contentAssistContext.getCurrentNode().getGrammarElement();
			if (ge == grammarAccess.getGrammarAccess().getNameGrammarIDParserRuleCall_1_0()
					|| ge == grammarAccess.getGrammarAccess().getUsedGrammarsAssignment_2_1()
					|| ge == grammarAccess.getGrammarAccess().getUsedGrammarsGrammarCrossReference_2_1_0()) {
				return;
			}
		}
		super.completeKeyword(keyword, contentAssistContext, acceptor);
	}
	
	@Override
	public void completeGrammar_UsedGrammars(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		ContentAssistContext decorated = context.copy().setMatcher(fqnPrefixMatcher).toContext();
		super.completeGrammar_UsedGrammars(model, assignment, decorated, acceptor);
	}

	@Override
	public void completeReferencedMetamodel_EPackage(EObject model, Assignment assignment,
			final ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		super.completeReferencedMetamodel_EPackage(model, assignment, context.copy().setMatcher(new PrefixMatcher() {

			@Override
			public boolean isCandidateMatchingPrefix(String name, String prefix) {
				if (prefix.startsWith("\"")) {
					if (prefix.length() == 1)
						prefix = "";
					else {
						prefix = prefix.substring(1);
						if (prefix.endsWith("\"")) {
							prefix = prefix.substring(0, prefix.length() - 1);
						}
					}
				}
				name = getValueConverter().toValue(name, "STRING", null).toString();
				if (context.getMatcher().isCandidateMatchingPrefix(name, prefix))
					return true;
				try {
					URI uri = URI.createURI(name);
					if (context.getMatcher().isCandidateMatchingPrefix(uri.lastSegment(), prefix))
						return true;
				} catch (Exception e) {
					// ignore
				}
				return false;
			}

		}).toContext(), acceptor);
	}

	@Override
	public void completeGeneratedMetamodel_Alias(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		if (model instanceof GeneratedMetamodel) {
			EPackage ePackage = ((GeneratedMetamodel) model).getEPackage();
			String name = ((GeneratedMetamodel) model).getName();
			createAliasProposal(context, acceptor, ePackage, name);
		}
		super.completeGeneratedMetamodel_Alias(model, assignment, context, acceptor);
	}

	private void createAliasProposal(ContentAssistContext context, ICompletionProposalAcceptor acceptor,
			EPackage ePackage, String proposal) {
		if (!Strings.isEmpty(proposal)) {
			ConfigurableCompletionProposal completionProposal = (ConfigurableCompletionProposal) createCompletionProposal(
					proposal, proposal + " - alias", ePackage != null ? getImage(ePackage) : null, context);
			if (completionProposal != null) {
				completionProposal.setPriority(completionProposal.getPriority() * 2);
				acceptor.accept(completionProposal);
			}
		}
	}

	@Override
	public void completeReferencedMetamodel_Alias(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		if (model instanceof AbstractMetamodelDeclaration) {
			EPackage ePackage = ((AbstractMetamodelDeclaration) model).getEPackage();
			if (ePackage != null) {
				createAliasProposal(context, acceptor, ePackage, ePackage.getName());
				createAliasProposal(context, acceptor, ePackage, ePackage.getNsPrefix());
			}
		}
		super.completeReferencedMetamodel_Alias(model, assignment, context, acceptor);
	}

	@Override
	protected StyledString getKeywordDisplayString(Keyword keyword) {
		return stylerFactory.createFromXtextStyle(keyword.getValue(),
				defaultLexicalHighlightingConfiguration.keywordTextStyle());
	}

	@Override
	protected StyledString getStyledDisplayString(EObject element, String qualifiedName, String shortName) {
		if (element instanceof AbstractRule) {
			StyledString result;
			if (element instanceof ParserRule && GrammarUtil.isDatatypeRule((ParserRule) element)) {
				result = stylerFactory.createFromXtextStyle(shortName, semanticHighlightingConfiguration.dataTypeRule());
			} else {
				result = new StyledString(shortName);
			}
			if (qualifiedName != null) {
				result.append(" - ", StyledString.QUALIFIER_STYLER);
				result.append(qualifiedName, StyledString.QUALIFIER_STYLER);
			}
			return result;
		}
		return super.getStyledDisplayString(element, qualifiedName, shortName);
	}

	@Override
	protected StyledString getStyledDisplayString(IEObjectDescription description) {
		if (EcorePackage.Literals.EPACKAGE == description.getEClass()) {
			if ("true".equals(description.getUserData("nsURI"))) {
				String name = description.getUserData("name");
				if (name == null) {
					return new StyledString(description.getName().toString());
				}
				String string = name + " - " + description.getName();
				return new StyledString(string);
			}
		} else if(XtextPackage.Literals.GRAMMAR == description.getEClass()){
			QualifiedName qualifiedName = description.getQualifiedName();
			if(qualifiedName.getSegmentCount() >1) {
				return new StyledString(qualifiedName.getLastSegment() + " - " + qualifiedName.toString());
			}
			return new StyledString(qualifiedName.toString());
		} else if (XtextPackage.Literals.ABSTRACT_RULE.isSuperTypeOf(description.getEClass())) {
			EObject object = description.getEObjectOrProxy();
			if (!object.eIsProxy()) {
				AbstractRule rule = (AbstractRule) object;
				Grammar grammar = GrammarUtil.getGrammar(rule);
				if (description instanceof EnclosingGrammarAwareDescription) {
					if (grammar == ((EnclosingGrammarAwareDescription) description).getGrammar()) {
						return getStyledDisplayString(rule, null, rule.getName());
					}
				}
				return getStyledDisplayString(rule,
						grammar.getName() + "." + rule.getName(),
						description.getName().toString().replace(".", "::"));	
			}
			
		}
		return super.getStyledDisplayString(description);
	}

	@Override
	protected String getDisplayString(EObject element, String proposal, String shortName) {
		if (element instanceof AbstractMetamodelDeclaration) {
			AbstractMetamodelDeclaration decl = (AbstractMetamodelDeclaration) element;
			if (!Strings.isEmpty(decl.getAlias()))
				return decl.getAlias();
		} else if (element instanceof EPackage) {
			EPackage pack = (EPackage) element;
			return pack.getName() + " - " + pack.getNsURI();
		}
		return super.getDisplayString(element, proposal, shortName);
	}


	@Override
	public void complete_Annotation(EObject model, RuleCall ruleCall, ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		createAnnotationProposals(acceptor, context, true);
	}

	@Override
	public void completeAnnotation_Name(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		createAnnotationProposals(acceptor, context, false);
	}

	protected void createAnnotationProposals(ICompletionProposalAcceptor acceptor, ContentAssistContext context, boolean withPrefix) {
		final INode node = context.getCurrentNode();
		if (node == null) {
			return;
		}
		
		final Object o = context.getCurrentNode().getGrammarElement();
		if (o == grammarAccess.getGrammarAccess().getNameGrammarIDParserRuleCall_1_0()
				|| o == grammarAccess.getGrammarAccess().getUsedGrammarsGrammarCrossReference_2_1_0()
				|| o == grammarAccess.getGrammarAccess().getUsedGrammarsAssignment_2_1()) {
			// don't propose annotations within grammarIds
			return;
		}
		
		for (String name : AnnotationNames.VALID_ANNOTATIONS_NAMES) {
			final String proposal = withPrefix ? "@" + name : name;
			acceptor.accept(createCompletionProposal(proposal, "@" + name, null, context));
		}
	}


	/**
	 * Not a full featured solution for the computation of available structural features, but it is sufficient for some
	 * interesting 85%.
	 */
	@Override
	public void completeAssignment_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		AbstractRule rule = EcoreUtil2.getContainerOfType(model, AbstractRule.class);
		TypeRef typeRef = rule.getType();
		if (typeRef != null && typeRef.getClassifier() instanceof EClass) {
			Iterable<EStructuralFeature> features = ((EClass) typeRef.getClassifier()).getEAllStructuralFeatures();
			Function<IEObjectDescription, ICompletionProposal> factory = getProposalFactory(grammarAccess.getValidIDRule().getName(), context);
			Iterable<String> processedFeatures = completeStructuralFeatures(context, factory, acceptor, features);
			if(rule.getType().getMetamodel() instanceof GeneratedMetamodel) {
				if(notNull(rule.getName()).toLowerCase().startsWith("import")) {
					completeSpecialAttributeAssignment("importedNamespace", 2, processedFeatures, factory, context, acceptor); 
					completeSpecialAttributeAssignment("importURI", 1, processedFeatures, factory, context, acceptor); 
				} else {
					completeSpecialAttributeAssignment("name", 3, processedFeatures, factory, context, acceptor); 
				}
			}
		}
		super.completeAssignment_Feature(model, assignment, context, acceptor);
	}

	protected void completeSpecialAttributeAssignment(String specialAttribute, int priorityFactor, Iterable<String> processedFeatures,
			Function<IEObjectDescription, ICompletionProposal> factory, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		if(!contains(processedFeatures, specialAttribute)) {
			EAttribute dummyAttribute = EcoreFactory.eINSTANCE.createEAttribute();
			dummyAttribute.setName(specialAttribute);
			dummyAttribute.setEType(EcorePackage.Literals.ESTRING);
			acceptor.accept(createFeatureProposal(dummyAttribute, priorityFactor, factory, context));
		}
	}

	protected Set<String> completeStructuralFeatures(ContentAssistContext context, Function<IEObjectDescription, ICompletionProposal> factory,
			ICompletionProposalAcceptor acceptor,
			Iterable<? extends EStructuralFeature> features) {
		if (features != null) {
			Set<String> processedFeatures = newHashSet();
			for (EStructuralFeature feature : features) {
				acceptor.accept(createFeatureProposal(feature, 4, factory, context));
				processedFeatures.add(feature.getName());
			}
			return processedFeatures;
		}
		return null;
	}
	
	protected ICompletionProposal createFeatureProposal(EStructuralFeature feature, int priorityFactor, Function<IEObjectDescription, ICompletionProposal> factory, 
			ContentAssistContext context) {
		IEObjectDescription description = EObjectDescription.create(QualifiedName.create(feature.getName()),
				feature);
		ConfigurableCompletionProposal proposal = (ConfigurableCompletionProposal) factory.apply(description);
		if (proposal != null) {
			proposal.setPriority(proposal.getPriority() * priorityFactor);
			if(SemanticHighlightingCalculator.SPECIAL_ATTRIBUTES.contains(feature.getName())) {
				StyledString displayString = stylerFactory.createFromXtextStyle(feature.getName(),
						semanticHighlightingConfiguration.specialAttribute())
						.append(" - Assignment of special attribute ")
						.append(stylerFactory.createFromXtextStyle(feature.getName(), 
								semanticHighlightingConfiguration.specialAttribute()));
				proposal.setDisplayString(displayString);
			} else {
				proposal.setDisplayString(new StyledString(feature.getName() + " - Assignment of feature " + feature.getName()));
			}
			if(feature.isMany()) {
				proposal.setReplacementString(feature.getName() + "+=");
				proposal.setCursorPosition(proposal.getCursorPosition() + 2);
			} else if(feature.getEType() == EcorePackage.Literals.EBOOLEAN) {
				proposal.setReplacementString(feature.getName() + "?=");
				proposal.setCursorPosition(proposal.getCursorPosition() + 2);
			} else {
				proposal.setReplacementString(feature.getName() + "=");
				proposal.setCursorPosition(proposal.getCursorPosition() + 1);
			}
		}
		return proposal;
	}

	@Override
	public void completeAction_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		Action action = EcoreUtil2.getContainerOfType(model, Action.class);
		if (action != null && action.getType() != null) {
			EClassifier classifier = action.getType().getClassifier();
			if (classifier instanceof EClass) {
				List<EReference> containments = ((EClass) classifier).getEAllContainments();
				Function<IEObjectDescription, ICompletionProposal> factory = getProposalFactory(grammarAccess.getValidIDRule().getName(), context);
				completeStructuralFeatures(context, factory, acceptor, containments);
			}
		}
		super.completeAction_Feature(model, assignment, context, acceptor);
	}

	@Override
	public void completeTypeRef_Classifier(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		Grammar grammar = GrammarUtil.getGrammar(model);
		ContentAssistContext.Builder myContextBuilder = context.copy();
		myContextBuilder.setMatcher(new ClassifierPrefixMatcher(context.getMatcher(), classifierQualifiedNameConverter));
		if (model instanceof TypeRef) {
			ICompositeNode node = NodeModelUtils.getNode(model);
			if (node != null) {
				int offset = node.getOffset();
				Region replaceRegion = new Region(offset, context.getReplaceRegion().getLength()
						+ context.getReplaceRegion().getOffset() - offset);
				myContextBuilder.setReplaceRegion(replaceRegion);
				myContextBuilder.setLastCompleteNode(node);
				StringBuilder availablePrefix = new StringBuilder(4);
				for (ILeafNode leaf : node.getLeafNodes()) {
					if (leaf.getGrammarElement() != null && !leaf.isHidden()) {
						if ((leaf.getTotalLength() + leaf.getTotalOffset()) < context.getOffset())
							availablePrefix.append(leaf.getText());
						else
							availablePrefix.append(leaf.getText().substring(0,
									context.getOffset() - leaf.getTotalOffset()));
					}
					if (leaf.getTotalOffset() >= context.getOffset())
						break;
				}
				myContextBuilder.setPrefix(availablePrefix.toString());
			}
		}
		ContentAssistContext myContext = myContextBuilder.toContext();
		for (AbstractMetamodelDeclaration declaration : grammar.getMetamodelDeclarations()) {
			if (declaration.getEPackage() != null) {
				createClassifierProposals(declaration, model, myContext, acceptor);
			}
		}
	}

	private void createClassifierProposals(AbstractMetamodelDeclaration declaration, EObject model,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		String alias = declaration.getAlias();
		QualifiedName prefix = (!Strings.isEmpty(alias)) ? QualifiedName.create(getValueConverter().toString(alias,
				grammarAccess.getValidIDRule().getName())) : null;
		boolean createDatatypeProposals = !(model instanceof AbstractElement)
				&& modelOrContainerIs(model, AbstractRule.class);
		boolean createEnumProposals = !(model instanceof AbstractElement) && modelOrContainerIs(model, EnumRule.class);
		boolean createClassProposals = modelOrContainerIs(model, ParserRule.class, CrossReference.class, Action.class);
		Function<IEObjectDescription, ICompletionProposal> factory = new DefaultProposalCreator(context, null, classifierQualifiedNameConverter);
		for (EClassifier classifier : declaration.getEPackage().getEClassifiers()) {
			if (classifier instanceof EDataType && createDatatypeProposals || classifier instanceof EEnum
					&& createEnumProposals || classifier instanceof EClass && createClassProposals) {
				String classifierName = getValueConverter().toString(classifier.getName(), grammarAccess.getValidIDRule().getName());
				QualifiedName proposalQualifiedName = (prefix != null) ? prefix.append(classifierName) : QualifiedName
						.create(classifierName);
				IEObjectDescription description = EObjectDescription.create(proposalQualifiedName, classifier);
				ConfigurableCompletionProposal proposal = (ConfigurableCompletionProposal) factory.apply(description);
				if (proposal != null) {
					if (prefix != null)
						proposal.setDisplayString(classifier.getName() + " - " + alias);
					proposal.setPriority(proposal.getPriority() * 2);
				}
				acceptor.accept(proposal);
			}
		}
	}

	private boolean modelOrContainerIs(EObject model, Class<?>... types) {
		for (Class<?> type : types) {
			if (type.isInstance(model) || type.isInstance(model.eContainer()))
				return true;
		}
		return false;
	}

	@Override
	public void complete_ParserRule(EObject model, org.eclipse.xtext.RuleCall ruleCall, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeParserRule(model, context, acceptor);
		completeInheritedRules(model, context, acceptor);
		super.complete_ParserRule(model, ruleCall, context, acceptor);
	}

	private void completeInheritedRules(EObject model, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		final Grammar grammar = GrammarUtil.getGrammar(model);
		Set<AbstractRule> allRules = collectOverrideCandidates(grammar);
		Map<String, AbstractRule> existingRules = collectExistingRules(grammar);
		for (final AbstractRule newRule : allRules) {
			if (existingRules.put(newRule.getName(), newRule) == null) {
				createOverrideProposal(newRule, grammar, context, acceptor);
			}
		}
	}

	protected void createOverrideProposal(final AbstractRule overrideMe, final Grammar grammar,
			final ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		StringBuilder proposal = new StringBuilder();
		String ruleKind = "parser rule";
		if (overrideMe instanceof TerminalRule) {
			proposal.append("terminal ");
			if (((TerminalRule) overrideMe).isFragment()) {
				proposal.append("fragment ");
				ruleKind = "terminal fragment";
			} else {
				ruleKind = "terminal rule";
			}
		}
		if (overrideMe instanceof EnumRule) {
			proposal.append("enum ");
			ruleKind = "enum rule";
		}
		if (overrideMe instanceof ParserRule && ((ParserRule) overrideMe).isFragment()) {
			proposal.append("fragment ");
			ruleKind = "parser fragment";
		}
		proposal.append(overrideMe.getName());
		String paramList = getParamList(overrideMe);
		proposal.append(paramList);
		boolean foundPack = appendReturnType(overrideMe, grammar, proposal);
		proposal.append(":\n\t");
		final int selectionStart = proposal.length();
		proposal.append("super");
		proposal.append(paramList);
		final int selectionEnd = proposal.length();
		proposal.append("\n;");
		ConfigurableCompletionProposal completionProposal = (ConfigurableCompletionProposal) createCompletionProposal(
				proposal.toString(), overrideMe.getName() + " - override " + ruleKind + " " + overrideMe.getName() + paramList, 
				getImage(overrideMe), context.copy().setMatcher(new PrefixMatcher() {
					@Override
					public boolean isCandidateMatchingPrefix(String name, String prefix) {
						// match only against rulename - ignore rule type
						return context.getMatcher().isCandidateMatchingPrefix(overrideMe.getName(), prefix);
					}
				}).toContext());
		if (completionProposal != null) {
			completionProposal.setSelectionStart(selectionStart + completionProposal.getReplacementOffset());
			completionProposal.setSelectionLength(selectionEnd - selectionStart);
			completionProposal.setCursorPosition(selectionEnd);
			completionProposal.setSimpleLinkedMode(context.getViewer(), '\t', '\n', '\r');
			if (!foundPack) {
				// we need to add a new import statement to the grammar
				completionProposal.setTextApplier(new ConfigurableCompletionProposal.IReplacementTextApplier() {
					@Override
					public void apply(IDocument document, ConfigurableCompletionProposal proposal)
							throws BadLocationException {
						// compute import statement's offset
						int offset = 0;
						boolean startWithLB = true;
						if (grammar.getMetamodelDeclarations().isEmpty()) {
							startWithLB = false;
							if (grammar.getRules().isEmpty()) {
								offset = document.getLength();
							} else {
								ICompositeNode node = NodeModelUtils.getNode(grammar.getRules().get(0));
								if(node != null)
									offset = node.getOffset();
							}
						} else {
							ICompositeNode node = NodeModelUtils.getNode(grammar.getMetamodelDeclarations().get(
									grammar.getMetamodelDeclarations().size() - 1));
							if(node != null)
								offset = node.getEndOffset();
						}
						offset = Math.min(proposal.getReplacementOffset(), offset);

						// apply proposal
						String replacementString = proposal.getReplacementString();
						proposal.setCursorPosition(replacementString.length());
						document.replace(proposal.getReplacementOffset(), proposal.getReplacementLength(),
								replacementString);

						// add import statement
						EPackage classifierPackage = overrideMe.getType().getClassifier().getEPackage();
						StringBuilder insertMe = new StringBuilder("import ").append(getValueConverter().toString(
								classifierPackage.getNsURI(), grammarAccess.getSTRINGRule().getName()));
						if (startWithLB)
							insertMe.insert(0, '\n');
						insertMe.append(" as ").append(getValueConverter().toString(classifierPackage.getName(), grammarAccess.getValidIDRule().getName()));
						insertMe.append('\n');
						document.replace(offset, 0, insertMe.toString());
						proposal.setCursorPosition(proposal.getCursorPosition() + insertMe.length() - 3);
						proposal.setSelectionStart(selectionStart + proposal.getReplacementOffset() + insertMe.length());
						proposal.setCursorPosition(selectionEnd + insertMe.length());
					}
				});
			}
			acceptor.accept(completionProposal);
		}
	}

	private String getParamList(final AbstractRule overrideMe) {
		StringBuilder paramBuilder = new StringBuilder(); 
		if (overrideMe instanceof ParserRule && !((ParserRule) overrideMe).getParameters().isEmpty()) {
			List<Parameter> parameters = ((ParserRule) overrideMe).getParameters();
			paramBuilder.append("<");
			for(int i = 0; i < parameters.size(); i++) {
				if (i != 0) {
					paramBuilder.append(", ");
				}
				String name = getValueConverter().toString(parameters.get(i).getName(), grammarAccess.getIDRule().getName());
				paramBuilder.append(name);
			}
			paramBuilder.append(">");
		}
		return paramBuilder.toString();
	}

	protected boolean appendReturnType(final AbstractRule overrideMe, final Grammar grammar,
			StringBuilder newRuleFragment) {
		if (overrideMe instanceof ParserRule && ((ParserRule) overrideMe).isWildcard()) {
			newRuleFragment.append(" *");
			// no need to add an import to the grammar
			return true;
		} else {
			EClassifier classifier = overrideMe.getType().getClassifier();
			final EPackage classifierPackage = classifier.getEPackage();
			boolean foundPack = false;
			for (AbstractMetamodelDeclaration metamodel : grammar.getMetamodelDeclarations()) {
				EPackage available = metamodel.getEPackage();
				if (classifierPackage == available) {
					EDataType eString = GrammarUtil.findEString(grammar);
					if (eString == null)
						eString = EcorePackage.Literals.ESTRING;
					if (classifier != eString
							&& (!Strings.isEmpty(metamodel.getAlias()) || !classifier.getName()
									.equals(overrideMe.getName()))) {
						newRuleFragment.append(" returns ");
						if (!Strings.isEmpty(metamodel.getAlias())) {
							newRuleFragment.append(metamodel.getAlias()).append("::");
						}
						newRuleFragment.append(classifier.getName());
					}
					foundPack = true;
					break;
				}
			}
			if (!foundPack) {
				EDataType eString = GrammarUtil.findEString(grammar);
				if (eString == null)
					eString = EcorePackage.Literals.ESTRING;
				if (classifier == eString) {
					for (AbstractMetamodelDeclaration mm : GrammarUtil.allMetamodelDeclarations(grammar)) {
						if (mm.getEPackage() == classifierPackage) {
							foundPack = true;
							break;
						}
					}
				}
				if (!foundPack) {
					newRuleFragment.append(" returns ");
					newRuleFragment.append(classifierPackage.getName());
					newRuleFragment.append("::");
					newRuleFragment.append(classifier.getName());
				}
			}
			return foundPack;
		}
	}

	protected Set<AbstractRule> collectOverrideCandidates(final Grammar grammar) {
		Set<AbstractRule> allRules = Sets.newHashSet();
		List<Grammar> usedGrammars = GrammarUtil.allUsedGrammars(grammar);
		UsedRulesFinder usedRulesFinder = new UsedRulesFinder(allRules);
		for (Grammar usedGrammar : usedGrammars) {
			usedRulesFinder.compute(usedGrammar);
		}
		if (allRules.isEmpty()) { // super lang has only terminal rules
			for (Grammar usedGrammar : usedGrammars) {
				allRules.addAll(usedGrammar.getRules());
			}
		}
		return allRules;
	}

	protected Map<String, AbstractRule> collectExistingRules(final Grammar grammar) {
		Map<String, AbstractRule> existingRules = Maps.newHashMap();
		for (AbstractRule rule : grammar.getRules()) {
			existingRules.put(rule.getName(), rule);
		}
		return existingRules;
	}

	@Override
	public void completeRuleNameAndParams_Name(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeParserRule(model, context, acceptor);
		super.completeRuleNameAndParams_Name(model, assignment, context, acceptor);
	}

	private void completeParserRule(EObject model, final ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		final Grammar grammar = GrammarUtil.getGrammar(model);
		for (AbstractMetamodelDeclaration metamodelDeclaration : grammar.getMetamodelDeclarations()) {
			if (metamodelDeclaration instanceof ReferencedMetamodel) {
				ReferencedMetamodel referencedMetamodel = (ReferencedMetamodel) metamodelDeclaration;
				EPackage ePackage = referencedMetamodel.getEPackage();
				if (ePackage != null) {
					for (EClassifier eClassifier : ePackage.getEClassifiers()) {
						if (isProposeParserRule(eClassifier, grammar)) {
							String proposal = eClassifier.getName();
							String metamodelAlias = referencedMetamodel.getAlias();
							if (metamodelAlias != null) {
								proposal = proposal + " returns " + metamodelAlias + "::" + eClassifier.getName();
							}
							proposal = proposal + ": \n;\n";
							ConfigurableCompletionProposal completionProposal = (ConfigurableCompletionProposal) createCompletionProposal(
									proposal, eClassifier.getName() + " - parser rule",
									getImage(XtextFactory.eINSTANCE.createParserRule()), context);
							if (completionProposal != null) {
								completionProposal.setCursorPosition(proposal.length() - 3);
								acceptor.accept(completionProposal);
							}
						}
					}
				}
			}
		}
	}

	private boolean isProposeParserRule(EClassifier eClassifier, Grammar grammar) {
		if (eClassifier instanceof EDataType && !((EDataType) eClassifier).isSerializable()) {
			return false;
		}
		return GrammarUtil.allParserRules(grammar)
				.stream()
				.filter(r -> r.getType() != null)
				.map(r -> r.getType().getClassifier())
				.allMatch(c -> !Objects.equals(c, eClassifier));
	}

	@Override
	public void completeParserRule_HiddenTokens(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeHiddenTokens(assignment, context, acceptor);
	}

	@Override
	public void completeGrammar_HiddenTokens(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeHiddenTokens(assignment, context, acceptor);
	}
	
	@Override
	public void complete_ValidID(EObject model, RuleCall ruleCall, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		complete_ID(model, ruleCall, context, acceptor);
		super.complete_ValidID(model, ruleCall, context, acceptor);
	}
	
	/**
	 * Do not propose terminal fragments in hidden token sections.
	 */
	protected void completeHiddenTokens(Assignment assignment, final ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		CrossReference crossReference = (CrossReference) assignment.getTerminal();
		lookupCrossReference(crossReference, context, acceptor, new Predicate<IEObjectDescription>() {
			@Override
			public boolean apply(IEObjectDescription input) {
				if (input.getEClass() == XtextPackage.Literals.TERMINAL_RULE) {
					EObject object = resolve(input, context);
					if (object instanceof TerminalRule)
						return !((TerminalRule) object).isFragment();
				}
				return false;
			}
		});
	}
	
	/**
	 * Do not propose enum and parser rules inside of terminal rules.
	 */
	@Override
	public void completeTerminalRuleCall_Rule(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		CrossReference crossReference = (CrossReference) assignment.getTerminal();
		lookupCrossReference(crossReference, context, acceptor, new Predicate<IEObjectDescription>() {
			@Override
			public boolean apply(IEObjectDescription input) {
				return input.getEClass() == XtextPackage.Literals.TERMINAL_RULE;
			}
		});
	}

	/**
	 * Do not propose terminal fragments in parser rules.
	 */
	@Override
	public void completeRuleCall_Rule(EObject model, Assignment assignment, final ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeRuleCall(model, assignment, context, acceptor);
	}

	private void completeRuleCall(EObject model, Assignment assignment, final ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		final Assignment containingAssignment = GrammarUtil.containingAssignment(model);
		CrossReference crossReference = (CrossReference) assignment.getTerminal();
		lookupCrossReference(crossReference, context, acceptor, new Predicate<IEObjectDescription>() {
			@Override
			public boolean apply(IEObjectDescription input) {
				if (input.getEClass() == XtextPackage.Literals.TERMINAL_RULE) {
					EObject object = resolve(input, context);
					if (object instanceof TerminalRule) {
						return !((TerminalRule) object).isFragment();
					}
				}
				if (containingAssignment != null && input.getEClass() == XtextPackage.Literals.PARSER_RULE) {
					EObject object = resolve(input, context);
					if (object instanceof ParserRule) {
						return !((ParserRule) object).isFragment();
					}
				}
				return true;
			}
		});
	}
	
	@Override
	public void completePredicatedRuleCall_Rule(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeRuleCall(model, assignment, context, acceptor);
	}
	
	private static class EnclosingGrammarAwareDescription extends ForwardingEObjectDescription {

		private Grammar grammar;

		public EnclosingGrammarAwareDescription(IEObjectDescription delegate, Grammar grammar) {
			super(delegate);
			this.grammar = grammar;
		}
		
		public Grammar getGrammar() {
			return grammar;
		}
		
	}
	
	@Override
	protected Function<IEObjectDescription, ICompletionProposal> getProposalFactory(String ruleName, ContentAssistContext contentAssistContext) {
		final Grammar grammar = GrammarUtil.getGrammar(contentAssistContext.getCurrentModel());
		if (grammarAccess.getRuleIDRule().getName().equals(ruleName)) {
			return new DefaultProposalCreator(contentAssistContext, ruleName, getQualifiedNameConverter()) {
				private Set<URI> seenProposals = Sets.newHashSet();
				@Override
				public ICompletionProposal apply(IEObjectDescription candidate) {
					ICompletionProposal result = super.apply(new EnclosingGrammarAwareDescription(candidate, grammar));
					if (result != null) {
						if (!seenProposals.add(candidate.getEObjectURI())) {
							return null;
						}
					}
					return result;
				}
			};
		} else {
			return new DefaultProposalCreator(contentAssistContext, ruleName, getQualifiedNameConverter()) {
				@Override
				public ICompletionProposal apply(IEObjectDescription candidate) {
					return super.apply(new EnclosingGrammarAwareDescription(candidate, grammar));
				}
			};
		}
	}

	private EObject resolve(IEObjectDescription input, final ContentAssistContext context) {
		EObject object = input.getEObjectOrProxy();
		if (object.eIsProxy())
			object = context.getResource().getResourceSet().getEObject(input.getEObjectURI(), true);
		return object;
	}

}
