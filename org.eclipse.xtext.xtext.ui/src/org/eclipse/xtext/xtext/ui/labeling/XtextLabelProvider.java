/*******************************************************************************
 * Copyright (c) 2009, 2019 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.xtext.ui.labeling;

import com.google.common.collect.Lists;
import com.google.inject.Inject;

import java.util.List;

import org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider;
import org.eclipse.jface.preference.JFacePreferences;
import org.eclipse.jface.viewers.StyledString;
import org.eclipse.jface.viewers.StyledString.Styler;
import org.eclipse.xtext.AbstractElement;
import org.eclipse.xtext.AbstractRule;
import org.eclipse.xtext.Action;
import org.eclipse.xtext.Alternatives;
import org.eclipse.xtext.Assignment;
import org.eclipse.xtext.CharacterRange;
import org.eclipse.xtext.CrossReference;
import org.eclipse.xtext.EOF;
import org.eclipse.xtext.EnumLiteralDeclaration;
import org.eclipse.xtext.GeneratedMetamodel;
import org.eclipse.xtext.Grammar;
import org.eclipse.xtext.GrammarUtil;
import org.eclipse.xtext.Keyword;
import org.eclipse.xtext.NegatedToken;
import org.eclipse.xtext.ParserRule;
import org.eclipse.xtext.ReferencedMetamodel;
import org.eclipse.xtext.RuleCall;
import org.eclipse.xtext.TypeRef;
import org.eclipse.xtext.UnorderedGroup;
import org.eclipse.xtext.UntilToken;
import org.eclipse.xtext.Wildcard;
import org.eclipse.xtext.nodemodel.ICompositeNode;
import org.eclipse.xtext.nodemodel.ILeafNode;
import org.eclipse.xtext.nodemodel.util.NodeModelUtils;
import org.eclipse.xtext.ui.label.DefaultEObjectLabelProvider;
import org.eclipse.xtext.ui.label.StylerFactory;
import org.eclipse.xtext.util.Strings;
import org.eclipse.xtext.xtext.ui.editor.syntaxcoloring.SemanticHighlightingConfiguration;

/**
 * Provides labels for EObjects.
 * 
 * See https://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#label-provider
 */
public class XtextLabelProvider extends DefaultEObjectLabelProvider {
	private static final String UNKNOWN = "<unknown>";
	@Inject
	private SemanticHighlightingConfiguration semanticHighlightingConfiguration;

	@Inject 
	private StylerFactory stylerFactory;
	
	@Inject
	public XtextLabelProvider(AdapterFactoryLabelProvider delegate) {
		super(delegate);
	}
	
	StyledString text(ParserRule parserRule) {
		if (GrammarUtil.isDatatypeRule(parserRule)) {
			Styler xtextStyleAdapterStyler = stylerFactory.createXtextStyleAdapterStyler(semanticHighlightingConfiguration
					.dataTypeRule());
			return new StyledString(parserRule.getName(), xtextStyleAdapterStyler);
		}
		return convertToStyledString(parserRule.getName());
	}

	StyledString text(EnumLiteralDeclaration object) {
		String literalName = getLiteralName(object);
		Keyword kw = object.getLiteral();
		String kwValue = kw == null ? "" : " = '" + kw.getValue() + "'";
		return new StyledString(literalName + kwValue, UNKNOWN.equalsIgnoreCase(literalName) ? stylerFactory.createStyler(
				JFacePreferences.ERROR_COLOR, null) : null);
	}

	String text(Grammar object) {
		return "grammar " + GrammarUtil.getLanguageId(object);
	}

	String text(GeneratedMetamodel object) {
		return "generate " + object.getName() + (!Strings.isEmpty(object.getAlias()) ? " as " + object.getAlias() : "");
	}

	String text(ReferencedMetamodel object) {
		String label = "";
		if (object.getAlias() != null)
			label = " " + object.getAlias();
		if (object.getEPackage() != null) {
			if (label.length() == 0)
				label = " " + object.getEPackage().getName();
			else
				label = " " + object.getEPackage().getName() + " as" + label;
		}
		if (label.length() == 0) {
			label = " " + UNKNOWN;
		}
		return "import" + label;
	}

	String text(Assignment object) {
		StringBuffer label = new StringBuffer();
		label.append(object.getFeature()).append(" ").append(object.getOperator()).append(" ");
		AbstractElement terminal = object.getTerminal();
		if (terminal instanceof RuleCall) {
			RuleCall ruleCall = (RuleCall) terminal;
			String string = NodeModelUtils.getNode(ruleCall).getText();
			label.append(string);
		} else if (terminal instanceof Keyword) {
			Keyword keyword = (Keyword) terminal;
			String value = "'" + keyword.getValue() + "'";
			label.append(value);
		} else if (terminal instanceof CrossReference) {
			CrossReference crossReference = (CrossReference) terminal;
			label.append(getLabel(crossReference));
		} else {
			label.append("(..)");
		}

		String cardinality = object.getCardinality();
		label.append(cardinality != null ? cardinality : "");
		return label.toString();
	}

	String text(CrossReference object) {
		return getLabel(object);
	}

	String text(AbstractRule object) {
		return object.getName();
	}

	String text(Action object) {
		String classifierName = getClassifierName(object.getType());
		return "{" + classifierName + (object.getFeature() != null ? ("." + object.getFeature()) : "") + "}";
	}

	String text(Alternatives object) {
		return "|";
	}
	
	String text(UnorderedGroup object) {
		return "&";
	}

	String text(CharacterRange object) {
		return object.getLeft().getValue() + " .. " + object.getRight().getValue();
	}

	String text(NegatedToken object) {
		return "!";
	}

	String text(UntilToken object) {
		return "->";
	}

	String text(Wildcard object) {
		return "*";
	}
	
	String text(EOF object) {
		return "EOF";
	}

	String text(Keyword object) {
		return "'" + object.getValue() + "'";
	}

	String text(TypeRef object) {
		return "'" + object + "'";
	}

	private String getLiteralName(EnumLiteralDeclaration declaration) {
		if (declaration.getEnumLiteral() != null) {
			return declaration.getEnumLiteral().getName();
		}
		ICompositeNode node = NodeModelUtils.getNode(declaration);
		String literalName = UNKNOWN;
		if (node != null) {
			for (ILeafNode leaf : node.getLeafNodes()) {
				if (!leaf.isHidden()) {
					literalName = leaf.getText();
					break;
				}
			}
		}
		return literalName;
	}

	private String getLabel(RuleCall ruleCall) {
		if (ruleCall.getRule() != null) {
			return ruleCall.getRule().getName();
		}
		ICompositeNode node = NodeModelUtils.getNode(ruleCall);
		String ruleName = UNKNOWN;
		if (node != null) {
			for (ILeafNode leaf : node.getLeafNodes()) {
				if (!leaf.isHidden()) {
					ruleName = leaf.getText();
					break;
				}
			}
		}
		return ruleName;
	}

	private String getLabel(CrossReference ref) {
		TypeRef type = ref.getType();
		String typeName = getClassifierName(type);
		if (ref.getTerminal() instanceof RuleCall)
			return "[" + typeName + "|" + getLabel((RuleCall) ref.getTerminal()) + "]";
		return "[" + typeName + "|..]";
	}

	private String getClassifierName(TypeRef ref) {
		String classifierName = UNKNOWN;
		if (ref != null) {
			if (ref.getClassifier() != null)
				classifierName = ref.getClassifier().getName();
			else {
				ICompositeNode node = NodeModelUtils.getNode(ref);
				if (node != null) {
					List<ILeafNode> leafs = Lists.newArrayList(node.getLeafNodes());
					for (int i = leafs.size() - 1; i >= 0; i--) {
						if (!leafs.get(i).isHidden()) {
							classifierName = leafs.get(i).getText();
							break;
						}
					}
				}
			}
		}
		return classifierName;
	}

	String image(Grammar grammar) {
		return "language.gif";
	}

	String image(GeneratedMetamodel metamodel) {
		return "export.gif";
	}

	String image(ReferencedMetamodel metamodel) {
		return "import.gif";
	}

	String image(AbstractRule rule) {
		return "rule.gif";
	}

	String image(RuleCall ruleCall) {
		return "rule.gif";
	}

	String image(Keyword keyword) {
		return "keyword.gif";
	}
}
