/*
* generated by Xtext
*/
package org.eclipse.xtext.ui.contentassist;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.ResourcesPlugin;
import org.eclipse.core.runtime.IPath;
import org.eclipse.core.runtime.Path;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EClassifier;
import org.eclipse.emf.ecore.EDataType;
import org.eclipse.emf.ecore.EEnum;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EReference;
import org.eclipse.emf.ecore.EStructuralFeature;
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
import org.eclipse.xtext.ParserRule;
import org.eclipse.xtext.ReferencedMetamodel;
import org.eclipse.xtext.TerminalRule;
import org.eclipse.xtext.TypeRef;
import org.eclipse.xtext.XtextFactory;
import org.eclipse.xtext.XtextPackage;
import org.eclipse.xtext.naming.IQualifiedNameConverter;
import org.eclipse.xtext.naming.QualifiedName;
import org.eclipse.xtext.nodemodel.ICompositeNode;
import org.eclipse.xtext.nodemodel.ILeafNode;
import org.eclipse.xtext.nodemodel.util.NodeModelUtils;
import org.eclipse.xtext.resource.EObjectDescription;
import org.eclipse.xtext.resource.IEObjectDescription;
import org.eclipse.xtext.ui.editor.contentassist.ConfigurableCompletionProposal;
import org.eclipse.xtext.ui.editor.contentassist.ContentAssistContext;
import org.eclipse.xtext.ui.editor.contentassist.ICompletionProposalAcceptor;
import org.eclipse.xtext.ui.editor.contentassist.PrefixMatcher;
import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultHighlightingConfiguration;
import org.eclipse.xtext.ui.label.StylerFactory;
import org.eclipse.xtext.util.Strings;
import org.eclipse.xtext.xtext.UsedRulesFinder;
import org.eclipse.xtext.xtext.ui.editor.syntaxcoloring.SemanticHighlightingConfiguration;

import com.google.common.base.Function;
import com.google.common.base.Predicate;
import com.google.common.collect.Iterables;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.google.inject.Inject;

/**
 * see http://www.eclipse.org/Xtext/documentation/latest/xtext.html#contentAssist on how to customize content assistant
 */
public class XtextProposalProvider extends AbstractXtextProposalProvider {

	@Inject
	private DefaultHighlightingConfiguration defaultLexicalHighlightingConfiguration;

	@Inject
	private SemanticHighlightingConfiguration semanticHighlightingConfiguration;

	@Inject
	private StylerFactory stylerFactory;

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
	public void completeReferencedMetamodel_EPackage(EObject model, Assignment assignment,
			final ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		super.completeReferencedMetamodel_EPackage(model, assignment, context.copy().setMatcher(new PrefixMatcher() {

			@Override
			public boolean isCandidateMatchingPrefix(String name, String prefix) {
				if (context.getMatcher().isCandidateMatchingPrefix(name, prefix))
					return true;
				try {
					URI uri = URI.createURI(name);
					if (context.getMatcher().isCandidateMatchingPrefix(uri.lastSegment(), prefix))
						return true;
				} catch(Exception e) {
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
		StyledString styledDisplayString = super.getStyledDisplayString(element, qualifiedName, shortName);
		if (element instanceof ParserRule && GrammarUtil.isDatatypeRule((ParserRule) element)) {
			styledDisplayString = stylerFactory.createFromXtextStyle(styledDisplayString.getString(),
					semanticHighlightingConfiguration.dataTypeRule());
		}
		return styledDisplayString;
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

	/**
	 * Not a full featured solution for the computation of available structural features, but it is sufficient for some
	 * interesting 80%.
	 */
	@Override
	public void completeAssignment_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		AbstractRule rule = EcoreUtil2.getContainerOfType(model, AbstractRule.class);
		EClassifier type = rule.getType().getClassifier();
		if (type instanceof EClass) {
			List<EStructuralFeature> features = ((EClass) type).getEAllStructuralFeatures();
			completeStructuralFeatures(context, acceptor, features);
		}
		super.completeAssignment_Feature(model, assignment, context, acceptor);
	}

	private void completeStructuralFeatures(ContentAssistContext context, ICompletionProposalAcceptor acceptor,
			Iterable<? extends EStructuralFeature> features) {
		if (features != null) {
			Function<IEObjectDescription, ICompletionProposal> factory = getProposalFactory("ID", context);
			for (EStructuralFeature feature : features) {
				IEObjectDescription description = EObjectDescription.create(QualifiedName.create(feature.getName()),
						feature);
				ConfigurableCompletionProposal proposal = (ConfigurableCompletionProposal) factory.apply(description);
				if (proposal != null)
					proposal.setPriority(proposal.getPriority() * 2);
				acceptor.accept(proposal);
			}
		}
	}

	@Override
	public void completeAction_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		Action action = EcoreUtil2.getContainerOfType(model, Action.class);
		if (action != null && action.getType() != null) {
			EClassifier classifier = action.getType().getClassifier();
			if (classifier instanceof EClass) {
				List<EReference> containments = ((EClass) classifier).getEAllContainments();
				completeStructuralFeatures(context, acceptor, containments);
			}
		}
		super.completeAction_Feature(model, assignment, context, acceptor);
	}

	@Override
	public void completeTypeRef_Classifier(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		Grammar grammar = GrammarUtil.getGrammar(model);
		ContentAssistContext.Builder myContextBuilder = context.copy();
		myContextBuilder.setMatcher(new ClassifierPrefixMatcher(context.getMatcher(), getQualifiedNameConverter()));
		if (model instanceof TypeRef) {
			ICompositeNode node = NodeModelUtils.getNode(model);
			int offset = node.getOffset();
			Region replaceRegion = new Region(offset, context.getReplaceRegion().getLength()
					+ context.getReplaceRegion().getOffset() - offset);
			myContextBuilder.setReplaceRegion(replaceRegion);
			myContextBuilder.setLastCompleteNode(node);
			StringBuilder availablePrefix = new StringBuilder(4);
			for(ILeafNode leaf: node.getLeafNodes()) {
				if (leaf.getGrammarElement() != null && !leaf.isHidden()) {
					if ((leaf.getTotalLength() + leaf.getTotalOffset()) < context.getOffset())
						availablePrefix.append(leaf.getText());
					else
						availablePrefix
								.append(leaf.getText().substring(0, context.getOffset() - leaf.getTotalOffset()));
				}
				if (leaf.getTotalOffset() >= context.getOffset())
					break;
			}
			myContextBuilder.setPrefix(availablePrefix.toString());
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
		QualifiedName prefix = (!Strings.isEmpty(alias)) 
			? QualifiedName.create(getValueConverter().toString(alias,"ID")) 
			: null;
		boolean createDatatypeProposals = !(model instanceof AbstractElement)
				&& modelOrContainerIs(model, AbstractRule.class);
		boolean createEnumProposals = !(model instanceof AbstractElement) && modelOrContainerIs(model, EnumRule.class);
		boolean createClassProposals = modelOrContainerIs(model, ParserRule.class, CrossReference.class, Action.class);
		Function<IEObjectDescription, ICompletionProposal> factory = getProposalFactory(null, context);
		for (EClassifier classifier : declaration.getEPackage().getEClassifiers()) {
			if (classifier instanceof EDataType && createDatatypeProposals || classifier instanceof EEnum
					&& createEnumProposals || classifier instanceof EClass && createClassProposals) {
				String classifierName = getValueConverter().toString(classifier.getName(), "ID");
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

	private void completeInheritedRules(EObject model, ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		final Grammar grammar = GrammarUtil.getGrammar(model);
		Set<AbstractRule> allRules = collectOverrideCandidates(grammar);
		Map<String, AbstractRule> existingRules = collectExistingRules(grammar);
		for(final AbstractRule newRule: allRules) {
			if (existingRules.put(newRule.getName(), newRule) == null) {
				createOverrideProposal(newRule, grammar, context, acceptor);
			}
		}
	}

	protected void createOverrideProposal(final AbstractRule overrideMe, final Grammar grammar,
			final ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		StringBuilder proposal = new StringBuilder();
		if (overrideMe instanceof TerminalRule) {
			proposal.append("terminal ");
			if (((TerminalRule) overrideMe).isFragment())
				proposal.append("fragment ");
		}
		if (overrideMe instanceof EnumRule)
			proposal.append("enum ");
		proposal.append(overrideMe.getName());
		boolean foundPack = appendReturnType(overrideMe, grammar, proposal);
		proposal = proposal.append(":\n\t\n;\n");
		ConfigurableCompletionProposal completionProposal = (ConfigurableCompletionProposal) createCompletionProposal(
				proposal.toString(), overrideMe.getName() + " - override rule " + overrideMe.getName(),
				getImage(overrideMe), context.copy().setMatcher(new PrefixMatcher() {
					@Override
					public boolean isCandidateMatchingPrefix(String name, String prefix) {
						// match only against rulename - ignore rule type
						return context.getMatcher().isCandidateMatchingPrefix(overrideMe.getName(), prefix);
					}
				}).toContext());
		if (completionProposal != null) {
			completionProposal.setCursorPosition(proposal.length() - 3);
			if (!foundPack) {
				// we need to add a new import statement to the grammar
				completionProposal.setTextApplier(new ConfigurableCompletionProposal.IReplacementTextApplier() {
					public void apply(IDocument document, ConfigurableCompletionProposal proposal) throws BadLocationException {
						// compute import statement's offset
						int offset = 0;
						boolean startWithLB = true;
						if (grammar.getMetamodelDeclarations().isEmpty()) {
							startWithLB = false;
							if (grammar.getRules().isEmpty()) {
								offset = document.getLength();
							} else {
								ICompositeNode node = NodeModelUtils.getNode(grammar.getRules().get(0));
								offset = node.getOffset();
							}
						} else {
							ICompositeNode node = NodeModelUtils.getNode(grammar.getMetamodelDeclarations().get(grammar.getMetamodelDeclarations().size() - 1));
							offset = node.getOffset() + node.getLength();
						}
						offset = Math.min(proposal.getReplacementOffset(), offset);
						
						// apply proposal
						String replacementString = proposal.getReplacementString();
						proposal.setCursorPosition(replacementString.length());
						document.replace(proposal.getReplacementOffset(), proposal.getReplacementLength(), replacementString);
						
						// add import statement
						EPackage classifierPackage = overrideMe.getType().getClassifier().getEPackage();
						StringBuilder insertMe = new StringBuilder("import ")
							.append(getValueConverter().toString(classifierPackage.getNsURI(), "STRING"));
						if (startWithLB)
							insertMe.insert(0, '\n');
						insertMe
							.append(" as ")
							.append(getValueConverter().toString(classifierPackage.getName(), "ID"));
						insertMe.append('\n');
						document.replace(offset, 0, insertMe.toString());
						proposal.setCursorPosition(proposal.getCursorPosition() + insertMe.length() - 3);
					}
				});
			}
			acceptor.accept(completionProposal);
		}
	}

	protected boolean appendReturnType(final AbstractRule overrideMe, final Grammar grammar,
			StringBuilder newRuleFragment) {
		EClassifier classifier = overrideMe.getType().getClassifier();
		final EPackage classifierPackage = classifier.getEPackage();
		boolean foundPack = false;
		for(AbstractMetamodelDeclaration metamodel: grammar.getMetamodelDeclarations()) {
			EPackage available = metamodel.getEPackage();
			if (classifierPackage == available) {
				if (classifier != EcorePackage.Literals.ESTRING && (!Strings.isEmpty(metamodel.getAlias()) || !classifier.getName().equals(overrideMe.getName()))) {
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
			if (classifier == EcorePackage.Literals.ESTRING) {
				for(AbstractMetamodelDeclaration mm: GrammarUtil.allMetamodelDeclarations(grammar)) {
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

	protected Set<AbstractRule> collectOverrideCandidates(final Grammar grammar) {
		Set<AbstractRule> allRules = Sets.newHashSet();
		List<Grammar> usedGrammars = GrammarUtil.allUsedGrammars(grammar);
		UsedRulesFinder usedRulesFinder = new UsedRulesFinder(allRules);
		for(Grammar usedGrammar: usedGrammars) {
			usedRulesFinder.compute(usedGrammar);
		}
		if (allRules.isEmpty()) { // inherit only terminal rules
			for(Grammar usedGrammar: usedGrammars) {
				allRules.addAll(usedGrammar.getRules());
			}	
		}
		return allRules;
	}

	protected Map<String, AbstractRule> collectExistingRules(final Grammar grammar) {
		Map<String, AbstractRule> existingRules = Maps.newHashMap();
		for(AbstractRule rule: grammar.getRules()) {
			existingRules.put(rule.getName(), rule);
		}
		return existingRules;
	}

	@Override
	public void completeParserRule_Name(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeParserRule(model, context, acceptor);
		super.completeParserRule_Name(model, assignment, context, acceptor);
	}

	private void completeParserRule(EObject model, final ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
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
		Iterable<EClassifier> allRuleNames = Iterables.transform(GrammarUtil.allParserRules(grammar),
				new Function<ParserRule, EClassifier>() {
					public EClassifier apply(ParserRule from) {
						return from.getType().getClassifier();
					}
				});
		return !Iterables.contains(allRuleNames, eClassifier);
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
	
	/**
	 * Do not propose terminal fragments in hidden token sections.
	 */
	protected void completeHiddenTokens(Assignment assignment, final ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		CrossReference crossReference = (CrossReference) assignment.getTerminal();
		lookupCrossReference(crossReference, context, acceptor, new Predicate<IEObjectDescription>() {
			public boolean apply(IEObjectDescription input) {
				if (input.getEClass() == XtextPackage.Literals.TERMINAL_RULE) {
					EObject object = input.getEObjectOrProxy();
					if (object.eIsProxy())
						object = context.getResource().getResourceSet().getEObject(input.getEObjectURI(), true);
					if (object instanceof TerminalRule)
						return !((TerminalRule) object).isFragment();
				}
				return false;
			}
		});
	}
	
	/**
	 * Do not propose enum and parser rules inside of terminal rules,
	 * do not propose terminal fragments in parser rules.
	 */
	@Override
	public void completeRuleCall_Rule(EObject model, Assignment assignment, final ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		AbstractRule containingRule = EcoreUtil2.getContainerOfType(model, AbstractRule.class);
		CrossReference crossReference = (CrossReference) assignment.getTerminal();
		if (containingRule instanceof TerminalRule) {
			lookupCrossReference(crossReference, context, acceptor, new Predicate<IEObjectDescription>() {
				public boolean apply(IEObjectDescription input) {
					return input.getEClass() == XtextPackage.Literals.TERMINAL_RULE;
				}
			});	
		} else {
			lookupCrossReference(crossReference, context, acceptor, new Predicate<IEObjectDescription>() {
				public boolean apply(IEObjectDescription input) {
					if (input.getEClass() == XtextPackage.Literals.TERMINAL_RULE) {
						EObject object = input.getEObjectOrProxy();
						if (object.eIsProxy())
							object = context.getResource().getResourceSet().getEObject(input.getEObjectURI(), true);
						if (object instanceof TerminalRule)
							return !((TerminalRule) object).isFragment();
					}
					return true;
				}
			});
		}
	}
	
}
