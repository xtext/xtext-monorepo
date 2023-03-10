/*******************************************************************************
 * Copyright (c) 2010, 2016 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.xbase.ui.contentassist;

import static com.google.common.collect.Lists.*;
import static org.eclipse.xtext.util.Strings.*;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EReference;
import org.eclipse.jdt.core.search.IJavaSearchConstants;
import org.eclipse.jdt.ui.PreferenceConstants;
import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.contentassist.ICompletionProposal;
import org.eclipse.jface.text.contentassist.IContextInformation;
import org.eclipse.jface.viewers.StyledString;
import org.eclipse.xtext.AbstractElement;
import org.eclipse.xtext.Assignment;
import org.eclipse.xtext.CrossReference;
import org.eclipse.xtext.GrammarUtil;
import org.eclipse.xtext.Group;
import org.eclipse.xtext.Keyword;
import org.eclipse.xtext.RuleCall;
import org.eclipse.xtext.common.types.JvmConstructor;
import org.eclipse.xtext.common.types.JvmDeclaredType;
import org.eclipse.xtext.common.types.JvmExecutable;
import org.eclipse.xtext.common.types.JvmFeature;
import org.eclipse.xtext.common.types.JvmFormalParameter;
import org.eclipse.xtext.common.types.JvmIdentifiableElement;
import org.eclipse.xtext.common.types.JvmOperation;
import org.eclipse.xtext.common.types.JvmType;
import org.eclipse.xtext.common.types.JvmTypeReference;
import org.eclipse.xtext.common.types.TypesPackage;
import org.eclipse.xtext.common.types.util.TypeReferences;
import org.eclipse.xtext.common.types.xtext.ui.ITypesProposalProvider;
import org.eclipse.xtext.common.types.xtext.ui.TypeMatchFilters;
import org.eclipse.xtext.conversion.IValueConverter;
import org.eclipse.xtext.conversion.ValueConverterException;
import org.eclipse.xtext.conversion.impl.QualifiedNameValueConverter;
import org.eclipse.xtext.naming.IQualifiedNameConverter;
import org.eclipse.xtext.naming.QualifiedName;
import org.eclipse.xtext.nodemodel.ICompositeNode;
import org.eclipse.xtext.nodemodel.ILeafNode;
import org.eclipse.xtext.nodemodel.INode;
import org.eclipse.xtext.nodemodel.util.NodeModelUtils;
import org.eclipse.xtext.resource.IEObjectDescription;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.scoping.IScope;
import org.eclipse.xtext.scoping.impl.SimpleScope;
import org.eclipse.xtext.ui.editor.contentassist.ConfigurableCompletionProposal;
import org.eclipse.xtext.ui.editor.contentassist.ConfigurableCompletionProposal.IReplacementTextApplier;
import org.eclipse.xtext.ui.editor.contentassist.ContentAssistContext;
import org.eclipse.xtext.ui.editor.contentassist.ICompletionProposalAcceptor;
import org.eclipse.xtext.ui.editor.contentassist.PrefixMatcher;
import org.eclipse.xtext.ui.editor.contentassist.RepeatedContentAssistProcessor;
import org.eclipse.xtext.util.Strings;
import org.eclipse.xtext.xbase.XAbstractFeatureCall;
import org.eclipse.xtext.xbase.XAssignment;
import org.eclipse.xtext.xbase.XBasicForLoopExpression;
import org.eclipse.xtext.xbase.XBinaryOperation;
import org.eclipse.xtext.xbase.XBlockExpression;
import org.eclipse.xtext.xbase.XClosure;
import org.eclipse.xtext.xbase.XExpression;
import org.eclipse.xtext.xbase.XFeatureCall;
import org.eclipse.xtext.xbase.XMemberFeatureCall;
import org.eclipse.xtext.xbase.XbasePackage;
import org.eclipse.xtext.xbase.conversion.XbaseQualifiedNameValueConverter;
import org.eclipse.xtext.xbase.imports.RewritableImportSection;
import org.eclipse.xtext.xbase.scoping.SyntaxFilteredScopes;
import org.eclipse.xtext.xbase.scoping.batch.IIdentifiableElementDescription;
import org.eclipse.xtext.xbase.scoping.batch.StaticExtensionFeatureDescriptionWithImplicitFirstArgument;
import org.eclipse.xtext.xbase.scoping.batch.StaticFeatureDescription;
import org.eclipse.xtext.xbase.scoping.featurecalls.OperatorMapping;
import org.eclipse.xtext.xbase.typesystem.IBatchTypeResolver;
import org.eclipse.xtext.xbase.typesystem.IExpressionScope;
import org.eclipse.xtext.xbase.typesystem.IResolvedTypes;
import org.eclipse.xtext.xbase.typesystem.references.LightweightTypeReference;
import org.eclipse.xtext.xbase.typesystem.references.LightweightTypeReferenceFactory;
import org.eclipse.xtext.xbase.ui.contentassist.ImportingTypesProposalProvider.FQNImporter;
import org.eclipse.xtext.xbase.ui.imports.ReplaceConverter;
import org.eclipse.xtext.xtype.XtypePackage;

import com.google.common.base.Function;
import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.google.common.collect.Iterables;
import com.google.common.collect.Maps;
import com.google.inject.Inject;

/**
 * See https://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#content-assist
 * on how to customize the content assistant.
 */
public class XbaseProposalProvider extends AbstractXbaseProposalProvider implements RepeatedContentAssistProcessor.ModeAware {
	
	public static class ValidFeatureDescription implements Predicate<IEObjectDescription> {

		@Inject
		private OperatorMapping operatorMapping;
		
		@Override
		public boolean apply(IEObjectDescription input) {
			if (input instanceof IIdentifiableElementDescription) {
				final IIdentifiableElementDescription desc = (IIdentifiableElementDescription) input;
				if (!desc.isVisible() || !desc.isValidStaticState()) // || !desc.isValid())
					return false;
				
				// filter operator method names from CA
				if (input.getName().getFirstSegment().startsWith("operator_")) {
					return operatorMapping.getOperator(input.getName()) == null;
				}
				return true;
			}
			return true;
		}
		
	}
	
	private final static Logger log = Logger.getLogger(XbaseProposalProvider.class);
	
	/**
	 * the user data key used to store the IEObjectDescription in the {@link ConfigurableCompletionProposal#setAdditionalData(String, Object)}
	 */
	public final static String DESCRIPTION_KEY = "xbase.description";
	
	@Inject
	private ITypesProposalProvider typeProposalProvider;
	
	@Inject
	private ValidFeatureDescription featureDescriptionPredicate;
	
	@Inject
	private XbaseQualifiedNameValueConverter qualifiedNameValueConverter;
	
	@Inject
	private StaticQualifierPrefixMatcher staticQualifierPrefixMatcher;
	
	@Inject
	private IBatchTypeResolver typeResolver;
	
	@Inject
	private SyntaxFilteredScopes syntaxFilteredScopes;
	
	@Inject
	private TypeReferences typeReferences;
	
	@Inject
	private IQualifiedNameConverter qualifiedNameConverter;
	
	protected class XbaseProposalCreator extends DefaultProposalCreator {
		
		private ContentAssistContext contentAssistContext;
		private String ruleName;
		
		public XbaseProposalCreator(ContentAssistContext contentAssistContext, String ruleName,
				IQualifiedNameConverter qualifiedNameConverter) {
			super(contentAssistContext, ruleName, qualifiedNameConverter);
			this.contentAssistContext = contentAssistContext;
			this.ruleName = ruleName;
		}
		
		private Map<QualifiedName, ParameterData> simpleNameToParameterList = Maps.newHashMap();
		
		@Override
		public ICompletionProposal apply(final IEObjectDescription candidate) {
			IEObjectDescription myCandidate = candidate;
			ContentAssistContext myContentAssistContext = contentAssistContext;
			if (myCandidate instanceof MultiNameDescription) {
				final MultiNameDescription multiNamed = (MultiNameDescription) candidate;
				myCandidate = multiNamed.getDelegate();
				myContentAssistContext = myContentAssistContext.copy().setMatcher(new PrefixMatcher() {
					@Override
					public boolean isCandidateMatchingPrefix(String name, String prefix) {
						PrefixMatcher delegateMatcher = contentAssistContext.getMatcher();
						if (delegateMatcher.isCandidateMatchingPrefix(name, prefix))
							return true;
						IQualifiedNameConverter converter = getQualifiedNameConverter();
						String unconvertedName = converter.toString(candidate.getName());
						if (!unconvertedName.equals(name) && delegateMatcher.isCandidateMatchingPrefix(unconvertedName, prefix))
							return true;
						for(QualifiedName otherName: multiNamed.getOtherNames()) {
							String alternative = converter.toString(otherName);
							if (delegateMatcher.isCandidateMatchingPrefix(alternative, prefix))
								return true;
							String convertedAlternative = valueConverter != null ? valueConverter.toString(alternative) : getValueConverter().toString(alternative, ruleName);
							if (!convertedAlternative.equals(alternative) &&
									delegateMatcher.isCandidateMatchingPrefix(convertedAlternative, prefix)) {
								return true;
							}
						}
						return false;
					}
				}).toContext();
			}
			if (myCandidate instanceof IIdentifiableElementDescription && (isIdRule(ruleName))) {
				ICompletionProposal result = null;
				String proposal = getQualifiedNameConverter().toString(myCandidate.getName());
				if (valueConverter != null) {
					try {
						proposal = getValueConverter().toString(proposal, ruleName);
					} catch (ValueConverterException e) {
						log.debug(e.getMessage(), e);
						return null;
					}
				} else if (ruleName != null) {
					try {
						proposal = getValueConverter().toString(proposal, ruleName);
					} catch (ValueConverterException e) {
						log.debug(e.getMessage(), e);
						return null;
					}
				}
				ProposalBracketInfo bracketInfo = getProposalBracketInfo(myCandidate, contentAssistContext);
				proposal += bracketInfo.brackets;
				int insignificantParameters = 0;
				if(myCandidate instanceof IIdentifiableElementDescription) {
					IIdentifiableElementDescription casted = (IIdentifiableElementDescription) myCandidate;
					insignificantParameters = casted.getNumberOfIrrelevantParameters();
				}
				LightweightTypeReferenceFactory converter = getTypeConverter(contentAssistContext.getResource());
				EObject objectOrProxy = myCandidate.getEObjectOrProxy();
				StyledString displayString;
				if (objectOrProxy instanceof JvmFeature) {
					if (bracketInfo.brackets.startsWith(" =")) {
						displayString = getStyledDisplayString((JvmFeature)objectOrProxy,
								false, insignificantParameters,
								getQualifiedNameConverter().toString(myCandidate.getQualifiedName()),
								getQualifiedNameConverter().toString(myCandidate.getName()) + bracketInfo.brackets,
								converter);
					} else {
						displayString = getStyledDisplayString((JvmFeature)objectOrProxy,
								!isEmpty(bracketInfo.brackets), insignificantParameters,
								getQualifiedNameConverter().toString(myCandidate.getQualifiedName()),
								getQualifiedNameConverter().toString(myCandidate.getName()),
								converter);
					}
				} else {
					displayString = getStyledDisplayString(objectOrProxy,
							getQualifiedNameConverter().toString(myCandidate.getQualifiedName()),
							getQualifiedNameConverter().toString(myCandidate.getName()));
				}
				result = createCompletionProposal(proposal, displayString, null, myContentAssistContext);
				if (result instanceof ConfigurableCompletionProposal) {
					ConfigurableCompletionProposal casted = (ConfigurableCompletionProposal) result;
					casted.setAdditionalData(DESCRIPTION_KEY, myCandidate);
					casted.setAdditionalProposalInfo(objectOrProxy);
					casted.setHover(getHover());
					int offset = casted.getReplacementOffset() + proposal.length();
					casted.setCursorPosition(casted.getCursorPosition() + bracketInfo.caretOffset);
					if (bracketInfo.selectionOffset != 0) {
						offset += bracketInfo.selectionOffset;
						casted.setSelectionStart(offset);
						casted.setSelectionLength(bracketInfo.selectionLength);
						casted.setAutoInsertable(false);
						casted.setSimpleLinkedMode(myContentAssistContext.getViewer(), '\t', '\n', '\r');
					}
					if (objectOrProxy instanceof JvmExecutable) {
						final JvmExecutable executable = (JvmExecutable) objectOrProxy;
						StyledString parameterList = new StyledString();
						appendParameters(parameterList, executable, insignificantParameters, converter);
						// TODO how should we display overloaded methods were one variant does not take arguments? -> empty parentheses? '<no args>' ?
						if (parameterList.length() > 0) {
							ParameterData parameterData = simpleNameToParameterList.get(myCandidate.getName());
							if (parameterData == null) {
								parameterData = new ParameterData();
								simpleNameToParameterList.put(myCandidate.getName(), parameterData);
							}
							parameterData.addOverloaded(parameterList.toString(), executable.isVarArgs());
							IContextInformation contextInformation = new ParameterContextInformation(parameterData, displayString.toString(), offset, offset);
							casted.setContextInformation(contextInformation);
						}
						// If the user types 'is' as a prefix for boolean properties, we want to keep that after applying the proposal
						if (executable.getSimpleName().startsWith("is") && executable.getSimpleName().length() > 2 && executable.getParameters().size() - insignificantParameters == 0) {
							((ConfigurableCompletionProposal) result).setTextApplier(new ConfigurableCompletionProposal.IReplacementTextApplier() {
								@Override
								public void apply(IDocument document, ConfigurableCompletionProposal proposal) throws BadLocationException {
									String replacementString = proposal.getReplacementString();
									if (proposal.getReplacementLength() >= 2) {
										String is = document.get(proposal.getReplacementOffset(), 2);
										if ("is".equals(is)) {
											replacementString = getValueConverter().toString(executable.getSimpleName(), ruleName);
										}
									}
									proposal.setCursorPosition(replacementString.length());
									document.replace(proposal.getReplacementOffset(), proposal.getReplacementLength(), replacementString);
								}
							});
						}
					}
				}
				getPriorityHelper().adjustCrossReferencePriority(result, myContentAssistContext.getPrefix());
				return result;
			}
			return super.apply(candidate);
		}

	}
	
	@Override
	public String getNextCategory() {
		return getXbaseCrossReferenceProposalCreator().getNextCategory();
	}
	
	@Override
	public void nextMode() {
		getXbaseCrossReferenceProposalCreator().nextMode();
	}
	
	@Override
	public void reset() {
		getXbaseCrossReferenceProposalCreator().reset();
	}
	
	@Override
	public boolean isLastMode() {
		return getXbaseCrossReferenceProposalCreator().isLastMode();
	}
	
	public XbaseReferenceProposalCreator getXbaseCrossReferenceProposalCreator() {
		return (XbaseReferenceProposalCreator) super.getCrossReferenceProposalCreator();
	}
	
	@Override
	public void completeXImportDeclaration_ImportedType(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeJavaTypes(context, XtypePackage.Literals.XIMPORT_DECLARATION__IMPORTED_TYPE, true,
				getQualifiedNameValueConverter(), createVisibilityFilter(context, IJavaSearchConstants.TYPE), acceptor);
	}

	@Override
	public void completeJvmParameterizedTypeReference_Type(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		if (getXbaseCrossReferenceProposalCreator().isShowTypeProposals() || getXbaseCrossReferenceProposalCreator().isShowSmartProposals()) {
			completeJavaTypes(context, TypesPackage.Literals.JVM_PARAMETERIZED_TYPE_REFERENCE__TYPE, acceptor);
		}
	}
	
	@Override
	public void completeXConstructorCall_Constructor(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		completeJavaTypes(context, TypesPackage.Literals.JVM_PARAMETERIZED_TYPE_REFERENCE__TYPE, true,
				qualifiedNameValueConverter, TypeMatchFilters.and(TypeMatchFilters.canInstantiate(), createVisibilityFilter(context)), acceptor);
	}
	
	@Override
	public void completeXRelationalExpression_Type(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeJavaTypes(context, TypesPackage.Literals.JVM_PARAMETERIZED_TYPE_REFERENCE__TYPE, acceptor);
	}

	protected void completeJavaTypes(ContentAssistContext context, EReference reference, ICompletionProposalAcceptor acceptor) {
		completeJavaTypes(context, reference, qualifiedNameValueConverter, createVisibilityFilter(context), acceptor);
	}
	
	protected void completeJavaTypes(ContentAssistContext context, EReference reference, ITypesProposalProvider.Filter filter, ICompletionProposalAcceptor acceptor) {
		completeJavaTypes(context, reference, qualifiedNameValueConverter, filter, acceptor);
	}
	
	protected void completeJavaTypes(ContentAssistContext context, EReference reference, IValueConverter<String> valueConverter, ITypesProposalProvider.Filter filter, ICompletionProposalAcceptor acceptor) {
		completeJavaTypes(context, reference, false, valueConverter, filter, acceptor);
	}

	protected void completeJavaTypes(ContentAssistContext context, EReference reference, boolean forced,
			IValueConverter<String> valueConverter, ITypesProposalProvider.Filter filter,
			ICompletionProposalAcceptor acceptor) {
		String prefix = context.getPrefix();
		if (prefix.length() > 0) {
			if (Character.isJavaIdentifierStart(context.getPrefix().charAt(0))) {
				if (!forced && getXbaseCrossReferenceProposalCreator().isShowSmartProposals()) {
					if (!prefix.contains(".") && !prefix.contains("::") && !Character.isUpperCase(prefix.charAt(0)))
						return;
				}
				typeProposalProvider.createTypeProposals(this, context, reference, filter, valueConverter, acceptor);
			}
		} else {
			if (forced || !getXbaseCrossReferenceProposalCreator().isShowSmartProposals()) {
				INode lastCompleteNode = context.getLastCompleteNode();
				if (lastCompleteNode instanceof ILeafNode && !((ILeafNode) lastCompleteNode).isHidden()) {
					if (lastCompleteNode.getLength() > 0 && lastCompleteNode.getTotalEndOffset() == context.getOffset()) {
						String text = lastCompleteNode.getText();
						char lastChar = text.charAt(text.length() - 1);
						if (Character.isJavaIdentifierPart(lastChar)) {
							return;
						}
					}
				}
				typeProposalProvider.createTypeProposals(this, context, reference, filter, valueConverter, acceptor);
			}
		}
	}
	
	@Override
	public void completeXTypeLiteral_Type(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeJavaTypes(context, XbasePackage.Literals.XTYPE_LITERAL__TYPE, true, qualifiedNameValueConverter, createVisibilityFilter(context), acceptor);
	}
	
	public void proposeDeclaringTypeForStaticInvocation(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor){
		if (getXbaseCrossReferenceProposalCreator().isShowTypeProposals() || getXbaseCrossReferenceProposalCreator().isShowSmartProposals()) {
			ContentAssistContext modifiedContext = context.copy().setMatcher(staticQualifierPrefixMatcher).toContext();
			completeJavaTypes(modifiedContext, TypesPackage.Literals.JVM_PARAMETERIZED_TYPE_REFERENCE__TYPE, qualifiedNameValueConverter, createVisibilityFilter(context), acceptor);
		}
	}
	
	protected ITypesProposalProvider.Filter createVisibilityFilter(ContentAssistContext context) {
		return createVisibilityFilter(context, IJavaSearchConstants.TYPE);
	}
	
	protected ITypesProposalProvider.Filter createVisibilityFilter(ContentAssistContext context, int searchFor) {
		return TypeMatchFilters.and(TypeMatchFilters.isNotInternal(searchFor), TypeMatchFilters.isAcceptableByPreference());
	}
	
	@Override
	public void completeKeyword(Keyword keyword, ContentAssistContext contentAssistContext,
			ICompletionProposalAcceptor acceptor) {
		if (isKeywordWorthyToPropose(keyword, contentAssistContext)) {
			super.completeKeyword(keyword, contentAssistContext, acceptor);
		}
	}
	
	protected boolean isKeywordWorthyToPropose(Keyword keyword, ContentAssistContext context) {
		if (isKeywordWorthyToPropose(keyword)) {
			if ("as".equals(keyword.getValue()) || "instanceof".equals(keyword.getValue())) {
				EObject previousModel = context.getPreviousModel();
				if (previousModel instanceof XExpression) {
					if (context.getPrefix().length() == 0) {
						if (NodeModelUtils.getNode(previousModel).getEndOffset() > context.getOffset()) {
							return false;
						}
					}
					LightweightTypeReference type = typeResolver.resolveTypes(previousModel).getActualType((XExpression) previousModel);
					if (type == null || type.isPrimitiveVoid()) {
						return false;
					}
				}
			}
			return true;
		}
		return false;
	}

	protected boolean isKeywordWorthyToPropose(Keyword keyword) {
		return keyword.getValue().length() > 1 && Character.isLetter(keyword.getValue().charAt(0));
	}
	
	@Override
	protected void lookupCrossReference(CrossReference crossReference, ContentAssistContext contentAssistContext,
			ICompletionProposalAcceptor acceptor) {
		lookupCrossReference(crossReference, contentAssistContext, acceptor, getFeatureDescriptionPredicate(contentAssistContext));
	}
	
	@Override
	public void completeXFeatureCall_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		if (model != null) {
			if (typeResolver.resolveTypes(model).hasExpressionScope(model, IExpressionScope.Anchor.WITHIN)) {
				return;
			}
		}
		if (model instanceof XMemberFeatureCall) {
			ICompositeNode node = NodeModelUtils.getNode(model);
			int endOffset = node.getEndOffset();
			if (isInMemberFeatureCall(model, endOffset, context)) {
				return;
			}
		}
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.AFTER, context, acceptor);
	}

	@Override
	public void completeXForLoopExpression_EachExpression(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
	}
	
	@Override
	public void completeXForLoopExpression_ForExpression(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.BEFORE, context, acceptor);
	}
	
	@Override
	public void completeXTryCatchFinallyExpression_Expression(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
	}
	
	@Override
	public void completeXTryCatchFinallyExpression_FinallyExpression(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
	}
	
	@Override
	public void completeXSwitchExpression_Default(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
	}
	
	@Override
	public void completeXCasePart_Then(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.AFTER, context, acceptor);
	}
	
	@Override
	public void completeXCasePart_Case(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
	}
	
	@Override
	public XbaseReferenceProposalCreator getCrossReferenceProposalCreator() {
		return (XbaseReferenceProposalCreator) super.getCrossReferenceProposalCreator();
	}
	
	@Override
	public void completeXBlockExpression_Expressions(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		completeWithinBlock(model, context, acceptor);
	}
	
	protected void completeWithinBlock(EObject model, ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		ICompositeNode node = NodeModelUtils.getNode(model);
		if (node.getOffset() >= context.getOffset()) {
			createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.BEFORE, context, acceptor);
			return;
		}
		if (model instanceof XBlockExpression) {
			List<XExpression> children = ((XBlockExpression) model).getExpressions();
			if (!children.isEmpty()) {
				for(int i = children.size() - 1; i >= 0; i--) {
					XExpression child = children.get(i);
					ICompositeNode childNode = NodeModelUtils.getNode(child);
					if (childNode.getEndOffset() <= context.getOffset()) {
						createLocalVariableAndImplicitProposals(child, IExpressionScope.Anchor.AFTER, context, acceptor);
						return;
					}
				}
			}
		}
		int endOffset = node.getEndOffset();
		if (endOffset <= context.getOffset()) {
			if (model instanceof XFeatureCall && model.eContainer() instanceof XClosure || endOffset == context.getOffset() && context.getPrefix().length() == 0)
				return;
			if (isInMemberFeatureCall(model, endOffset, context))
				return;
			createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.AFTER, context, acceptor);
			return;
		} else if (isInMemberFeatureCall(model, endOffset, context)) {
			return;
		}
		if (model instanceof XClosure)
			return;
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.BEFORE, context, acceptor);
	}
	
	protected boolean isInMemberFeatureCall(EObject model, int endOffset, ContentAssistContext context) {
		if (model instanceof XMemberFeatureCall && endOffset >= context.getOffset()) {
			List<INode> featureNodes = NodeModelUtils.findNodesForFeature(model, XbasePackage.Literals.XABSTRACT_FEATURE_CALL__FEATURE);
			if (!featureNodes.isEmpty()) {
				INode featureNode = featureNodes.get(0);
				if (featureNode.getTotalOffset() < context.getOffset() && featureNode.getTotalEndOffset() >= context.getOffset()) {
					return true;
				}
			}
		}
		return false;
	}
	
	@Override
	public void completeXExpressionInClosure_Expressions(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		completeWithinBlock(model, context, acceptor);
	}
	
	@Override
	public void completeXAssignment_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		String ruleName = getConcreteSyntaxRuleName(assignment);
		// unfortunately we have two different kinds of 'feature' assignemnts in the rule XAssignment
		// thus we have to find the operator rule here
		if (isOperatorRule(ruleName)) {
			completeBinaryOperationFeature(model, assignment, context, acceptor);
		}
	}
	
	protected boolean isOperatorRule(String ruleName) {
		return ruleName != null && ruleName.startsWith("Op");
	}

	@Override
	public void completeXOrExpression_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeBinaryOperationFeature(model, assignment, context, acceptor);
	}
	
	@Override
	public void completeXAndExpression_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeBinaryOperationFeature(model, assignment, context, acceptor);
	}
	
	@Override
	public void completeXEqualityExpression_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeBinaryOperationFeature(model, assignment, context, acceptor);
	}
	
	@Override
	public void completeXRelationalExpression_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeBinaryOperationFeature(model, assignment, context, acceptor);
	}
	
	@Override
	public void completeXOtherOperatorExpression_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeBinaryOperationFeature(model, assignment, context, acceptor);
	}
	
	@Override
	public void completeXAdditiveExpression_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeBinaryOperationFeature(model, assignment, context, acceptor);
	}
	
	@Override
	public void completeXMultiplicativeExpression_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeBinaryOperationFeature(model, assignment, context, acceptor);
	}

	@Override
	public void completeXUnaryOperation_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		// don't propose unary operations like !, +, -
	}
	
	@Override
	public void completeXPostfixOperation_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		completeBinaryOperationFeature(model, assignment, context, acceptor);
	}
	
	protected void completeBinaryOperationFeature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		if (model instanceof XBinaryOperation) {
			if (context.getPrefix().length() == 0) { // check for a cursor inbetween an operator
				INode currentNode = context.getCurrentNode();
				int offset = currentNode.getOffset();
				int endOffset = currentNode.getEndOffset();
				if (offset < context.getOffset() && endOffset >= context.getOffset()) {
					if (currentNode.getGrammarElement() instanceof CrossReference) {
						// don't propose another binary operator
						return;
					}
				}
			}
			if (NodeModelUtils.findActualNodeFor(model).getEndOffset() <= context.getOffset()) {
				createReceiverProposals((XExpression) model,
						(CrossReference) assignment.getTerminal(), context, acceptor);
			} else {
				createReceiverProposals(((XBinaryOperation) model).getLeftOperand(),
						(CrossReference) assignment.getTerminal(), context, acceptor);
			}
		} else {
			EObject previousModel = context.getPreviousModel();
			if (previousModel instanceof XExpression) {
				if (context.getPrefix().length() == 0) {
					if (NodeModelUtils.getNode(previousModel).getEndOffset() > context.getOffset()) {
						return;
					}
				}
				createReceiverProposals((XExpression) previousModel,
						(CrossReference) assignment.getTerminal(), context, acceptor);
			}
		}
	}
	
	@Override
	public void completeXCatchClause_Expression(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
	}
	
	@Override
	public void complete_XExpression(EObject model, RuleCall ruleCall, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		// likely XParenthesizedExpression
		EObject container = ruleCall.eContainer();
		// avoid dependency on XbaseGrammarAccess
		if (container instanceof Group && "XParenthesizedExpression".equals(GrammarUtil.containingRule(ruleCall).getName())) {
			createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
		}
	}
	
	@Override
	public void completeXBasicForLoopExpression_InitExpressions(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		ICompositeNode node = NodeModelUtils.getNode(model);
		if (node.getOffset() >= context.getOffset()) {
			createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.BEFORE, context, acceptor);
			return;
		}
		if (model instanceof XBasicForLoopExpression) {
			List<XExpression> children = ((XBasicForLoopExpression) model).getInitExpressions();
			if (!children.isEmpty()) {
				for(int i = children.size() - 1; i >= 0; i--) {
					XExpression child = children.get(i);
					ICompositeNode childNode = NodeModelUtils.getNode(child);
					if (childNode.getEndOffset() <= context.getOffset()) {
						createLocalVariableAndImplicitProposals(child, IExpressionScope.Anchor.AFTER, context, acceptor);
						return;
					}
				}
			}
		}
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.BEFORE, context, acceptor);
	}
	
	@Override
	public void completeXBasicForLoopExpression_UpdateExpressions(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
	}
	
	@Override
	public void completeXBasicForLoopExpression_Expression(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
	}
	
	@Override
	public void completeXBasicForLoopExpression_EachExpression(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
	}
	
	@Override
	public void completeXClosure_Expression(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
	}
	
	@Override
	public void completeXShortClosure_Expression(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.WITHIN, context, acceptor);
	}
	
	@Override
	public void completeXMemberFeatureCall_Feature(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		if (model instanceof XMemberFeatureCall) {
			XExpression memberCallTarget = ((XMemberFeatureCall) model).getMemberCallTarget();
			IResolvedTypes resolvedTypes = typeResolver.resolveTypes(memberCallTarget);
			LightweightTypeReference memberCallTargetType = resolvedTypes.getActualType(memberCallTarget);
			Iterable<JvmFeature> featuresToImport = getFavoriteStaticFeatures(model, input -> {
				if(input instanceof JvmOperation && input.isStatic()) {
					List<JvmFormalParameter> parameters = ((JvmOperation) input).getParameters();
					if(parameters.size() > 0) {
						JvmFormalParameter firstParam = parameters.get(0);
						JvmTypeReference parameterType = firstParam.getParameterType();
						if(parameterType != null) {
							LightweightTypeReference lightweightTypeReference = memberCallTargetType.getOwner().toLightweightTypeReference(parameterType);
							if(lightweightTypeReference != null) {
								return memberCallTargetType.isAssignableFrom(lightweightTypeReference);
							}
						}
					}
				}
				return false;
			});
			// Create StaticExtensionFeatureDescriptionWithImplicitFirstArgument instead of SimpleIdentifiableElementDescription since we want the Proposal to show parameters
			Iterable<IEObjectDescription> scopedFeatures = Iterables.transform(featuresToImport, feature -> {
				QualifiedName qualifiedName = QualifiedName.create(feature.getSimpleName());
				return new StaticExtensionFeatureDescriptionWithImplicitFirstArgument(qualifiedName, feature, memberCallTarget, memberCallTargetType, 0, true);
			});
			// Scope for all static features
			IScope staticMemberScope = new SimpleScope(IScope.NULLSCOPE, scopedFeatures);
			proposeFavoriteStaticFeatures(model, context, acceptor, staticMemberScope);
			// Regular proposals
			createReceiverProposals(((XMemberFeatureCall) model).getMemberCallTarget(), (CrossReference) assignment.getTerminal(),
					context, acceptor);
		} else if (model instanceof XAssignment) {
			createReceiverProposals(((XAssignment) model).getAssignable(), (CrossReference) assignment.getTerminal(),
					context, acceptor);
		}
	}
	
	@Override
	public void completeXVariableDeclaration_Right(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(model, IExpressionScope.Anchor.BEFORE, context, acceptor);
	}
	
	protected void createLocalVariableAndImplicitProposals(
			EObject context,
			IExpressionScope.Anchor anchor,
			ContentAssistContext contentAssistContext,
			ICompletionProposalAcceptor acceptor) {
		String prefix = contentAssistContext.getPrefix();
		if (prefix.length() > 0) {
			if (!Character.isJavaIdentifierStart(prefix.charAt(0))) {
				if (prefix.length() > 1) {
					if (prefix.charAt(0) == '^' && !Character.isJavaIdentifierStart(prefix.charAt(1))) {
						return;
					}
				}
			}
		}
		
//		long time = System.currentTimeMillis();
		Function<IEObjectDescription, ICompletionProposal> proposalFactory = getProposalFactory(getFeatureCallRuleName(), contentAssistContext);
		IResolvedTypes resolvedTypes = context != null ? typeResolver.resolveTypes(context) : typeResolver.resolveTypes(contentAssistContext.getResource());
		IExpressionScope expressionScope = resolvedTypes.getExpressionScope(context, anchor);
		// TODO use the type name information
		IScope scope = expressionScope.getFeatureScope();
		getCrossReferenceProposalCreator().lookupCrossReference(scope, context, XbasePackage.Literals.XABSTRACT_FEATURE_CALL__FEATURE, acceptor, getFeatureDescriptionPredicate(contentAssistContext), proposalFactory);
//		System.out.printf("XbaseProposalProvider.createLocalVariableAndImplicitProposals = %d\n", System.currentTimeMillis() - time);
//		time = System.currentTimeMillis();
		
		// TODO use the type name information
		proposeDeclaringTypeForStaticInvocation(context, null /* ignore */, contentAssistContext, acceptor);
//		System.out.printf("XbaseProposalProvider.proposeDeclaringTypeForStaticInvocation = %d\n", System.currentTimeMillis() - time);
		if(context != null && !(context instanceof XMemberFeatureCall)) {
			Iterable<JvmFeature> featuresToImport = getFavoriteStaticFeatures(context, input->true);
			// Create StaticFeatureDescription instead of SimpleIdentifiableElementDescription since we want the Proposal to show parameters
			Iterable<IEObjectDescription> scopedFeatures = Iterables.transform(featuresToImport, feature -> {
				QualifiedName qualifiedName = QualifiedName.create(feature.getSimpleName());
				return new StaticFeatureDescription(qualifiedName, feature, 0, true);	
			});
			// Scope for all static features
			IScope staticMemberScope = new SimpleScope(IScope.NULLSCOPE, scopedFeatures);
			proposeFavoriteStaticFeatures(context, contentAssistContext, acceptor, staticMemberScope);
		}
	}
	
	/**
	 * @since 2.17
	 */
	protected Iterable<JvmFeature> getFavoriteStaticFeatures(EObject context, Predicate<JvmFeature> filter) {
		String pref = PreferenceConstants.getPreference(PreferenceConstants.CODEASSIST_FAVORITE_STATIC_MEMBERS, null);
		List<JvmFeature> result = newArrayList();
		if (Strings.isEmpty(pref)) {
			return result;
		}
		String[] favorites = pref.split(";"); //$NON-NLS-1$
		for (String fav : favorites) {
			boolean isWildcard = fav.lastIndexOf("*") > 0; //$NON-NLS-1$
			int indexOfLastDot = fav.lastIndexOf("."); //$NON-NLS-1$
			if (indexOfLastDot > 0) {
				String typeName = fav.substring(0, indexOfLastDot);
				JvmType type = typeReferences.findDeclaredType(typeName, context);
				final String membername = fav.substring(indexOfLastDot + 1, fav.length());
				if (type != null) {
					if (type instanceof JvmDeclaredType) {
						JvmDeclaredType genericType = (JvmDeclaredType) type;
						// All features but no Constructor
						FluentIterable<JvmFeature> allFeaturesToImport = FluentIterable.from(genericType.getMembers()).filter(JvmFeature.class).filter(input -> {
							boolean isValid = !(input instanceof JvmConstructor) && input.isStatic();
							if (isWildcard) {
								return isValid;
							} else {
								return isValid && input.getSimpleName().equals(membername);
							}
						});
						FluentIterable<JvmFeature> featuresToImport = allFeaturesToImport.filter(filter);
						if (context != null) {
							// Make sure that already imported static features are not proposed
							RewritableImportSection importSection = importSectionFactory.parse((XtextResource) context.eResource());
							featuresToImport = featuresToImport.filter(input -> !importSection.hasStaticImport(input.getSimpleName(), false));
						}
						featuresToImport.copyInto(result);
					}
				}
			}
		}
		return result;
	}
	
	/**
	 * @since 2.17
	 */
	protected void proposeFavoriteStaticFeatures(EObject context, ContentAssistContext contentAssistContext,
			ICompletionProposalAcceptor acceptor, IScope scopedFeatures) {
		Function<IEObjectDescription, ICompletionProposal> proposalFactory = getProposalFactory(getFeatureCallRuleName(), contentAssistContext);
		IReplacementTextApplier textApplier =  new FQNImporter(contentAssistContext.getResource(), contentAssistContext.getViewer(), scopedFeatures, qualifiedNameConverter,
				qualifiedNameValueConverter, importSectionFactory, replaceConverter);
		Function<IEObjectDescription, ICompletionProposal> importAddingProposalFactory = input->{
			ICompletionProposal proposal = proposalFactory.apply(input);
			if(proposal instanceof ConfigurableCompletionProposal) {
				ConfigurableCompletionProposal castedProposal = (ConfigurableCompletionProposal) proposal;
				// Add textApplier to introduce imports if necessary
				((ConfigurableCompletionProposal) proposal).setTextApplier(textApplier);
				return castedProposal;
			}
			return proposal;
		};
		getCrossReferenceProposalCreator().lookupCrossReference(scopedFeatures, context, XbasePackage.Literals.XABSTRACT_FEATURE_CALL__FEATURE, acceptor, getFeatureDescriptionPredicate(contentAssistContext), importAddingProposalFactory);
	}

	@Inject
	private RewritableImportSection.Factory importSectionFactory;
	
	@Inject
	private ReplaceConverter replaceConverter;
	
	protected String getFeatureCallRuleName() {
		return "IdOrSuper";
	}
	
	protected String getQualifiedNameRuleName() {
		return "QualifiedName";
	}
	
	/**
	 * Create proposal for {@link XAbstractFeatureCall#getFeature() simple feature calls} that use an <code>IdOrSuper</code>
	 * as concrete syntax.
	 */
	protected void createLocalVariableAndImplicitProposals(EObject context, ContentAssistContext contentAssistContext, ICompletionProposalAcceptor acceptor) {
		createLocalVariableAndImplicitProposals(context, IExpressionScope.Anchor.BEFORE, contentAssistContext, acceptor);
	}

	protected void createReceiverProposals(XExpression receiver, CrossReference crossReference, ContentAssistContext contentAssistContext, ICompletionProposalAcceptor acceptor) {
//		long time = System.currentTimeMillis();
		String ruleName = getConcreteSyntaxRuleName(crossReference);
		Function<IEObjectDescription, ICompletionProposal> proposalFactory = getProposalFactory(ruleName, contentAssistContext);
		IResolvedTypes resolvedTypes = typeResolver.resolveTypes(receiver);
		LightweightTypeReference receiverType = resolvedTypes.getActualType(receiver);
		if (receiverType == null || receiverType.isPrimitiveVoid()) {
			return;
		}
		IExpressionScope expressionScope = resolvedTypes.getExpressionScope(receiver, IExpressionScope.Anchor.RECEIVER);
		// TODO exploit the type name information
		IScope scope;
		if (contentAssistContext.getCurrentModel() != receiver) {
			EObject currentModel = contentAssistContext.getCurrentModel();
			if (currentModel instanceof XMemberFeatureCall && ((XMemberFeatureCall) currentModel).getMemberCallTarget() == receiver) {
				scope = filterByConcreteSyntax(expressionScope.getFeatureScope((XAbstractFeatureCall) currentModel), crossReference);
			} else {
				scope = filterByConcreteSyntax(expressionScope.getFeatureScope(), crossReference);
			}
		} else {
			scope = filterByConcreteSyntax(expressionScope.getFeatureScope(), crossReference);
		}
		getCrossReferenceProposalCreator().lookupCrossReference(scope, receiver, XbasePackage.Literals.XABSTRACT_FEATURE_CALL__FEATURE, acceptor, getFeatureDescriptionPredicate(contentAssistContext), proposalFactory);
//		System.out.printf("XbaseProposalProvider.createReceiverProposals = %d\n", System.currentTimeMillis() - time);
	}
	
	protected IScope filterByConcreteSyntax(IScope parent, AbstractElement syntax) {
		// filter down the x-refs to operators
		// rather than enumerating all proposals, just consider the syntactically valid entries
		return syntaxFilteredScopes.create(parent, syntax);
	}
	
	protected String getConcreteSyntaxRuleName(Assignment assignment) {
		AbstractElement terminal = assignment.getTerminal();
		if (terminal instanceof CrossReference) {
			return getConcreteSyntaxRuleName((CrossReference) terminal);
		}
		String ruleName = null;
		if (terminal instanceof RuleCall) {
			ruleName = getConcreteSyntaxRuleName((RuleCall) terminal);
		}
		return ruleName;
	}
	
	protected String getConcreteSyntaxRuleName(RuleCall ruleCall) {
		String ruleName = ruleCall.getRule().getName();
		return ruleName;
	}

	protected String getConcreteSyntaxRuleName(CrossReference crossReference) {
		String ruleName = null;
		if (crossReference.getTerminal() instanceof RuleCall) {
			ruleName = getConcreteSyntaxRuleName((RuleCall) crossReference.getTerminal());
		}
		return ruleName;
	}

	protected boolean doNotProposeFeatureOfBinaryOperation(ContentAssistContext contentAssistContext,
			XBinaryOperation binaryOperation) {
		List<INode> nodesForFeature = NodeModelUtils.findNodesForFeature(binaryOperation, XbasePackage.Literals.XABSTRACT_FEATURE_CALL__FEATURE);
		if (!nodesForFeature.isEmpty()) {
			INode node = nodesForFeature.get(0);
			if (node.getOffset() < contentAssistContext.getOffset() - contentAssistContext.getPrefix().length()) {
				XExpression rightOperand = binaryOperation.getRightOperand();
				if (rightOperand == null)
					return true;
				ICompositeNode rightOperandNode = NodeModelUtils.findActualNodeFor(rightOperand);
				if (rightOperandNode != null) {
					if (rightOperandNode.getOffset() >= contentAssistContext.getOffset())
						return true;
					if (isParentOf(rightOperandNode, contentAssistContext.getLastCompleteNode()))
						return true;
				}
			}
		}
		return false;
	}
	
	protected boolean isParentOf(INode node, INode child) {
		if (node == null)
			return false;
		while(child != null && node.equals(child)) {
			child = child.getParent();
		}
		return node.equals(child);
	}

	@Override
	protected Function<IEObjectDescription, ICompletionProposal> getProposalFactory(final String ruleName,
			final ContentAssistContext contentAssistContext) {
		return new XbaseProposalCreator(contentAssistContext, ruleName, getQualifiedNameConverter());
	}
	
	protected static class ProposalBracketInfo {
		String brackets = "";
		int selectionOffset = 0;
		int selectionLength = 0;
		int caretOffset = 0;
	}
	
	protected ProposalBracketInfo getProposalBracketInfo(IEObjectDescription proposedDescription, ContentAssistContext contentAssistContext) {
		ProposalBracketInfo info = new ProposalBracketInfo();
		if (proposedDescription instanceof IIdentifiableElementDescription) {
			IIdentifiableElementDescription jvmFeatureDescription = (IIdentifiableElementDescription)proposedDescription;
			JvmIdentifiableElement jvmFeature = jvmFeatureDescription.getElementOrProxy();
			if(jvmFeature instanceof JvmExecutable) {
				List<JvmFormalParameter> parameters = ((JvmExecutable) jvmFeature).getParameters();
				if (jvmFeatureDescription.getNumberOfParameters() == 1) {
					if (jvmFeature.getSimpleName().startsWith("set") && !proposedDescription.getName().getFirstSegment().startsWith("set")) {
						info.brackets = " = value";
						info.selectionOffset = -"value".length();
						info.selectionLength = "value".length();
						return info;
					}
					JvmTypeReference parameterType = parameters.get(parameters.size()-1).getParameterType();
					LightweightTypeReference light = getTypeConverter(contentAssistContext.getResource()).toLightweightReference(parameterType);
					if(light.isFunctionType()) {
						int numParameters = light.getAsFunctionTypeReference().getParameterTypes().size();
						if(numParameters == 1) {
							info.brackets = "[]";
							info.caretOffset = -1;
							return info;
						} else if(numParameters == 0) {
					 		info.brackets = "[|]";
							info.caretOffset = -1;
							return info;
						} else {
					 		final StringBuilder b = new StringBuilder();
					 		for(int i=0; i<numParameters; ++i) {
					 			if (i!=0) {
					 				b.append(", ");
					 			}
					 			b.append("p"+ (i+1));
					 		}
					 		info.brackets = "[" + b.toString() + "|]";
					 		info.caretOffset = -1;
					 		info.selectionOffset = -b.length() - 2;
					 		info.selectionLength = b.length();
					 		return info;
					 	}
					}
				}
			}
			if (isExplicitOperationCall(jvmFeatureDescription)) {
				info.brackets = "()";
				info.selectionOffset = -1;
			}
		}
		return info;
	}
	
	protected Predicate<IEObjectDescription> getFeatureDescriptionPredicate(ContentAssistContext contentAssistContext) {
		return featureDescriptionPredicate;
	}
	
	protected QualifiedNameValueConverter getQualifiedNameValueConverter() {
		return qualifiedNameValueConverter;
	}
	
	protected ITypesProposalProvider getTypesProposalProvider() {
		return typeProposalProvider;
	}
	
	protected boolean isIdRule(final String ruleName) {
		return "IdOrSuper".equals(ruleName) || "ValidID".equals(ruleName) || "FeatureCallID".equals(ruleName);
	}
	
	public boolean isExplicitOperationCall(IIdentifiableElementDescription desc) {
		return desc.getNumberOfParameters() > 0;
	}
}
