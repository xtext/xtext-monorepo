/*******************************************************************************
 * Copyright (c) 2010, 2020 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 * 
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
grammar InternalXbase;

options {
	superClass=AbstractInternalContentAssistParser;
	backtrack=true;
}

@lexer::header {
package org.eclipse.xtext.xbase.ide.contentassist.antlr.internal;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.ide.editor.contentassist.antlr.internal.Lexer;
}

@parser::header {
package org.eclipse.xtext.xbase.ide.contentassist.antlr.internal;

import java.io.InputStream;
import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.ide.editor.contentassist.antlr.internal.AbstractInternalContentAssistParser;
import org.eclipse.xtext.ide.editor.contentassist.antlr.internal.DFA;
import org.eclipse.xtext.xbase.services.XbaseGrammarAccess;

}
@parser::members {
	private XbaseGrammarAccess grammarAccess;

	public void setGrammarAccess(XbaseGrammarAccess grammarAccess) {
		this.grammarAccess = grammarAccess;
	}

	@Override
	protected Grammar getGrammar() {
		return grammarAccess.getGrammar();
	}

	@Override
	protected String getValueForTokenName(String tokenName) {
		return tokenName;
	}
}

// Entry rule entryRuleXExpression
entryRuleXExpression
:
{ before(grammarAccess.getXExpressionRule()); }
	 ruleXExpression
{ after(grammarAccess.getXExpressionRule()); } 
	 EOF 
;

// Rule XExpression
ruleXExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXExpressionAccess().getXAssignmentParserRuleCall()); }
		ruleXAssignment
		{ after(grammarAccess.getXExpressionAccess().getXAssignmentParserRuleCall()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXAssignment
entryRuleXAssignment
:
{ before(grammarAccess.getXAssignmentRule()); }
	 ruleXAssignment
{ after(grammarAccess.getXAssignmentRule()); } 
	 EOF 
;

// Rule XAssignment
ruleXAssignment 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXAssignmentAccess().getAlternatives()); }
		(rule__XAssignment__Alternatives)
		{ after(grammarAccess.getXAssignmentAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleOpSingleAssign
entryRuleOpSingleAssign
:
{ before(grammarAccess.getOpSingleAssignRule()); }
	 ruleOpSingleAssign
{ after(grammarAccess.getOpSingleAssignRule()); } 
	 EOF 
;

// Rule OpSingleAssign
ruleOpSingleAssign 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getOpSingleAssignAccess().getEqualsSignKeyword()); }
		'='
		{ after(grammarAccess.getOpSingleAssignAccess().getEqualsSignKeyword()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleOpMultiAssign
entryRuleOpMultiAssign
:
{ before(grammarAccess.getOpMultiAssignRule()); }
	 ruleOpMultiAssign
{ after(grammarAccess.getOpMultiAssignRule()); } 
	 EOF 
;

// Rule OpMultiAssign
ruleOpMultiAssign 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getOpMultiAssignAccess().getAlternatives()); }
		(rule__OpMultiAssign__Alternatives)
		{ after(grammarAccess.getOpMultiAssignAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXOrExpression
entryRuleXOrExpression
:
{ before(grammarAccess.getXOrExpressionRule()); }
	 ruleXOrExpression
{ after(grammarAccess.getXOrExpressionRule()); } 
	 EOF 
;

// Rule XOrExpression
ruleXOrExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXOrExpressionAccess().getGroup()); }
		(rule__XOrExpression__Group__0)
		{ after(grammarAccess.getXOrExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleOpOr
entryRuleOpOr
:
{ before(grammarAccess.getOpOrRule()); }
	 ruleOpOr
{ after(grammarAccess.getOpOrRule()); } 
	 EOF 
;

// Rule OpOr
ruleOpOr 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getOpOrAccess().getVerticalLineVerticalLineKeyword()); }
		'||'
		{ after(grammarAccess.getOpOrAccess().getVerticalLineVerticalLineKeyword()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXAndExpression
entryRuleXAndExpression
:
{ before(grammarAccess.getXAndExpressionRule()); }
	 ruleXAndExpression
{ after(grammarAccess.getXAndExpressionRule()); } 
	 EOF 
;

// Rule XAndExpression
ruleXAndExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXAndExpressionAccess().getGroup()); }
		(rule__XAndExpression__Group__0)
		{ after(grammarAccess.getXAndExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleOpAnd
entryRuleOpAnd
:
{ before(grammarAccess.getOpAndRule()); }
	 ruleOpAnd
{ after(grammarAccess.getOpAndRule()); } 
	 EOF 
;

// Rule OpAnd
ruleOpAnd 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getOpAndAccess().getAmpersandAmpersandKeyword()); }
		'&&'
		{ after(grammarAccess.getOpAndAccess().getAmpersandAmpersandKeyword()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXEqualityExpression
entryRuleXEqualityExpression
:
{ before(grammarAccess.getXEqualityExpressionRule()); }
	 ruleXEqualityExpression
{ after(grammarAccess.getXEqualityExpressionRule()); } 
	 EOF 
;

// Rule XEqualityExpression
ruleXEqualityExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXEqualityExpressionAccess().getGroup()); }
		(rule__XEqualityExpression__Group__0)
		{ after(grammarAccess.getXEqualityExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleOpEquality
entryRuleOpEquality
:
{ before(grammarAccess.getOpEqualityRule()); }
	 ruleOpEquality
{ after(grammarAccess.getOpEqualityRule()); } 
	 EOF 
;

// Rule OpEquality
ruleOpEquality 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getOpEqualityAccess().getAlternatives()); }
		(rule__OpEquality__Alternatives)
		{ after(grammarAccess.getOpEqualityAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXRelationalExpression
entryRuleXRelationalExpression
:
{ before(grammarAccess.getXRelationalExpressionRule()); }
	 ruleXRelationalExpression
{ after(grammarAccess.getXRelationalExpressionRule()); } 
	 EOF 
;

// Rule XRelationalExpression
ruleXRelationalExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXRelationalExpressionAccess().getGroup()); }
		(rule__XRelationalExpression__Group__0)
		{ after(grammarAccess.getXRelationalExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleOpCompare
entryRuleOpCompare
:
{ before(grammarAccess.getOpCompareRule()); }
	 ruleOpCompare
{ after(grammarAccess.getOpCompareRule()); } 
	 EOF 
;

// Rule OpCompare
ruleOpCompare 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getOpCompareAccess().getAlternatives()); }
		(rule__OpCompare__Alternatives)
		{ after(grammarAccess.getOpCompareAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXOtherOperatorExpression
entryRuleXOtherOperatorExpression
:
{ before(grammarAccess.getXOtherOperatorExpressionRule()); }
	 ruleXOtherOperatorExpression
{ after(grammarAccess.getXOtherOperatorExpressionRule()); } 
	 EOF 
;

// Rule XOtherOperatorExpression
ruleXOtherOperatorExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXOtherOperatorExpressionAccess().getGroup()); }
		(rule__XOtherOperatorExpression__Group__0)
		{ after(grammarAccess.getXOtherOperatorExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleOpOther
entryRuleOpOther
:
{ before(grammarAccess.getOpOtherRule()); }
	 ruleOpOther
{ after(grammarAccess.getOpOtherRule()); } 
	 EOF 
;

// Rule OpOther
ruleOpOther 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getOpOtherAccess().getAlternatives()); }
		(rule__OpOther__Alternatives)
		{ after(grammarAccess.getOpOtherAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXAdditiveExpression
entryRuleXAdditiveExpression
:
{ before(grammarAccess.getXAdditiveExpressionRule()); }
	 ruleXAdditiveExpression
{ after(grammarAccess.getXAdditiveExpressionRule()); } 
	 EOF 
;

// Rule XAdditiveExpression
ruleXAdditiveExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXAdditiveExpressionAccess().getGroup()); }
		(rule__XAdditiveExpression__Group__0)
		{ after(grammarAccess.getXAdditiveExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleOpAdd
entryRuleOpAdd
:
{ before(grammarAccess.getOpAddRule()); }
	 ruleOpAdd
{ after(grammarAccess.getOpAddRule()); } 
	 EOF 
;

// Rule OpAdd
ruleOpAdd 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getOpAddAccess().getAlternatives()); }
		(rule__OpAdd__Alternatives)
		{ after(grammarAccess.getOpAddAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXMultiplicativeExpression
entryRuleXMultiplicativeExpression
:
{ before(grammarAccess.getXMultiplicativeExpressionRule()); }
	 ruleXMultiplicativeExpression
{ after(grammarAccess.getXMultiplicativeExpressionRule()); } 
	 EOF 
;

// Rule XMultiplicativeExpression
ruleXMultiplicativeExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXMultiplicativeExpressionAccess().getGroup()); }
		(rule__XMultiplicativeExpression__Group__0)
		{ after(grammarAccess.getXMultiplicativeExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleOpMulti
entryRuleOpMulti
:
{ before(grammarAccess.getOpMultiRule()); }
	 ruleOpMulti
{ after(grammarAccess.getOpMultiRule()); } 
	 EOF 
;

// Rule OpMulti
ruleOpMulti 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getOpMultiAccess().getAlternatives()); }
		(rule__OpMulti__Alternatives)
		{ after(grammarAccess.getOpMultiAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXUnaryOperation
entryRuleXUnaryOperation
:
{ before(grammarAccess.getXUnaryOperationRule()); }
	 ruleXUnaryOperation
{ after(grammarAccess.getXUnaryOperationRule()); } 
	 EOF 
;

// Rule XUnaryOperation
ruleXUnaryOperation 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXUnaryOperationAccess().getAlternatives()); }
		(rule__XUnaryOperation__Alternatives)
		{ after(grammarAccess.getXUnaryOperationAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleOpUnary
entryRuleOpUnary
:
{ before(grammarAccess.getOpUnaryRule()); }
	 ruleOpUnary
{ after(grammarAccess.getOpUnaryRule()); } 
	 EOF 
;

// Rule OpUnary
ruleOpUnary 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getOpUnaryAccess().getAlternatives()); }
		(rule__OpUnary__Alternatives)
		{ after(grammarAccess.getOpUnaryAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXCastedExpression
entryRuleXCastedExpression
:
{ before(grammarAccess.getXCastedExpressionRule()); }
	 ruleXCastedExpression
{ after(grammarAccess.getXCastedExpressionRule()); } 
	 EOF 
;

// Rule XCastedExpression
ruleXCastedExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXCastedExpressionAccess().getGroup()); }
		(rule__XCastedExpression__Group__0)
		{ after(grammarAccess.getXCastedExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXPostfixOperation
entryRuleXPostfixOperation
:
{ before(grammarAccess.getXPostfixOperationRule()); }
	 ruleXPostfixOperation
{ after(grammarAccess.getXPostfixOperationRule()); } 
	 EOF 
;

// Rule XPostfixOperation
ruleXPostfixOperation 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXPostfixOperationAccess().getGroup()); }
		(rule__XPostfixOperation__Group__0)
		{ after(grammarAccess.getXPostfixOperationAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleOpPostfix
entryRuleOpPostfix
:
{ before(grammarAccess.getOpPostfixRule()); }
	 ruleOpPostfix
{ after(grammarAccess.getOpPostfixRule()); } 
	 EOF 
;

// Rule OpPostfix
ruleOpPostfix 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getOpPostfixAccess().getAlternatives()); }
		(rule__OpPostfix__Alternatives)
		{ after(grammarAccess.getOpPostfixAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXMemberFeatureCall
entryRuleXMemberFeatureCall
:
{ before(grammarAccess.getXMemberFeatureCallRule()); }
	 ruleXMemberFeatureCall
{ after(grammarAccess.getXMemberFeatureCallRule()); } 
	 EOF 
;

// Rule XMemberFeatureCall
ruleXMemberFeatureCall 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup()); }
		(rule__XMemberFeatureCall__Group__0)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXPrimaryExpression
entryRuleXPrimaryExpression
:
{ before(grammarAccess.getXPrimaryExpressionRule()); }
	 ruleXPrimaryExpression
{ after(grammarAccess.getXPrimaryExpressionRule()); } 
	 EOF 
;

// Rule XPrimaryExpression
ruleXPrimaryExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getAlternatives()); }
		(rule__XPrimaryExpression__Alternatives)
		{ after(grammarAccess.getXPrimaryExpressionAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXLiteral
entryRuleXLiteral
:
{ before(grammarAccess.getXLiteralRule()); }
	 ruleXLiteral
{ after(grammarAccess.getXLiteralRule()); } 
	 EOF 
;

// Rule XLiteral
ruleXLiteral 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXLiteralAccess().getAlternatives()); }
		(rule__XLiteral__Alternatives)
		{ after(grammarAccess.getXLiteralAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXCollectionLiteral
entryRuleXCollectionLiteral
:
{ before(grammarAccess.getXCollectionLiteralRule()); }
	 ruleXCollectionLiteral
{ after(grammarAccess.getXCollectionLiteralRule()); } 
	 EOF 
;

// Rule XCollectionLiteral
ruleXCollectionLiteral 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXCollectionLiteralAccess().getAlternatives()); }
		(rule__XCollectionLiteral__Alternatives)
		{ after(grammarAccess.getXCollectionLiteralAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXSetLiteral
entryRuleXSetLiteral
:
{ before(grammarAccess.getXSetLiteralRule()); }
	 ruleXSetLiteral
{ after(grammarAccess.getXSetLiteralRule()); } 
	 EOF 
;

// Rule XSetLiteral
ruleXSetLiteral 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXSetLiteralAccess().getGroup()); }
		(rule__XSetLiteral__Group__0)
		{ after(grammarAccess.getXSetLiteralAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXListLiteral
entryRuleXListLiteral
:
{ before(grammarAccess.getXListLiteralRule()); }
	 ruleXListLiteral
{ after(grammarAccess.getXListLiteralRule()); } 
	 EOF 
;

// Rule XListLiteral
ruleXListLiteral 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXListLiteralAccess().getGroup()); }
		(rule__XListLiteral__Group__0)
		{ after(grammarAccess.getXListLiteralAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXClosure
entryRuleXClosure
:
{ before(grammarAccess.getXClosureRule()); }
	 ruleXClosure
{ after(grammarAccess.getXClosureRule()); } 
	 EOF 
;

// Rule XClosure
ruleXClosure 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXClosureAccess().getGroup()); }
		(rule__XClosure__Group__0)
		{ after(grammarAccess.getXClosureAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXExpressionInClosure
entryRuleXExpressionInClosure
:
{ before(grammarAccess.getXExpressionInClosureRule()); }
	 ruleXExpressionInClosure
{ after(grammarAccess.getXExpressionInClosureRule()); } 
	 EOF 
;

// Rule XExpressionInClosure
ruleXExpressionInClosure 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXExpressionInClosureAccess().getGroup()); }
		(rule__XExpressionInClosure__Group__0)
		{ after(grammarAccess.getXExpressionInClosureAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXShortClosure
entryRuleXShortClosure
:
{ before(grammarAccess.getXShortClosureRule()); }
	 ruleXShortClosure
{ after(grammarAccess.getXShortClosureRule()); } 
	 EOF 
;

// Rule XShortClosure
ruleXShortClosure 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXShortClosureAccess().getGroup()); }
		(rule__XShortClosure__Group__0)
		{ after(grammarAccess.getXShortClosureAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXParenthesizedExpression
entryRuleXParenthesizedExpression
:
{ before(grammarAccess.getXParenthesizedExpressionRule()); }
	 ruleXParenthesizedExpression
{ after(grammarAccess.getXParenthesizedExpressionRule()); } 
	 EOF 
;

// Rule XParenthesizedExpression
ruleXParenthesizedExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXParenthesizedExpressionAccess().getGroup()); }
		(rule__XParenthesizedExpression__Group__0)
		{ after(grammarAccess.getXParenthesizedExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXIfExpression
entryRuleXIfExpression
:
{ before(grammarAccess.getXIfExpressionRule()); }
	 ruleXIfExpression
{ after(grammarAccess.getXIfExpressionRule()); } 
	 EOF 
;

// Rule XIfExpression
ruleXIfExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXIfExpressionAccess().getGroup()); }
		(rule__XIfExpression__Group__0)
		{ after(grammarAccess.getXIfExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXSwitchExpression
entryRuleXSwitchExpression
:
{ before(grammarAccess.getXSwitchExpressionRule()); }
	 ruleXSwitchExpression
{ after(grammarAccess.getXSwitchExpressionRule()); } 
	 EOF 
;

// Rule XSwitchExpression
ruleXSwitchExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXSwitchExpressionAccess().getGroup()); }
		(rule__XSwitchExpression__Group__0)
		{ after(grammarAccess.getXSwitchExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXCasePart
entryRuleXCasePart
:
{ before(grammarAccess.getXCasePartRule()); }
	 ruleXCasePart
{ after(grammarAccess.getXCasePartRule()); } 
	 EOF 
;

// Rule XCasePart
ruleXCasePart 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXCasePartAccess().getGroup()); }
		(rule__XCasePart__Group__0)
		{ after(grammarAccess.getXCasePartAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXForLoopExpression
entryRuleXForLoopExpression
:
{ before(grammarAccess.getXForLoopExpressionRule()); }
	 ruleXForLoopExpression
{ after(grammarAccess.getXForLoopExpressionRule()); } 
	 EOF 
;

// Rule XForLoopExpression
ruleXForLoopExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXForLoopExpressionAccess().getGroup()); }
		(rule__XForLoopExpression__Group__0)
		{ after(grammarAccess.getXForLoopExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXBasicForLoopExpression
entryRuleXBasicForLoopExpression
:
{ before(grammarAccess.getXBasicForLoopExpressionRule()); }
	 ruleXBasicForLoopExpression
{ after(grammarAccess.getXBasicForLoopExpressionRule()); } 
	 EOF 
;

// Rule XBasicForLoopExpression
ruleXBasicForLoopExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXBasicForLoopExpressionAccess().getGroup()); }
		(rule__XBasicForLoopExpression__Group__0)
		{ after(grammarAccess.getXBasicForLoopExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXWhileExpression
entryRuleXWhileExpression
:
{ before(grammarAccess.getXWhileExpressionRule()); }
	 ruleXWhileExpression
{ after(grammarAccess.getXWhileExpressionRule()); } 
	 EOF 
;

// Rule XWhileExpression
ruleXWhileExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXWhileExpressionAccess().getGroup()); }
		(rule__XWhileExpression__Group__0)
		{ after(grammarAccess.getXWhileExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXDoWhileExpression
entryRuleXDoWhileExpression
:
{ before(grammarAccess.getXDoWhileExpressionRule()); }
	 ruleXDoWhileExpression
{ after(grammarAccess.getXDoWhileExpressionRule()); } 
	 EOF 
;

// Rule XDoWhileExpression
ruleXDoWhileExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXDoWhileExpressionAccess().getGroup()); }
		(rule__XDoWhileExpression__Group__0)
		{ after(grammarAccess.getXDoWhileExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXBlockExpression
entryRuleXBlockExpression
:
{ before(grammarAccess.getXBlockExpressionRule()); }
	 ruleXBlockExpression
{ after(grammarAccess.getXBlockExpressionRule()); } 
	 EOF 
;

// Rule XBlockExpression
ruleXBlockExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXBlockExpressionAccess().getGroup()); }
		(rule__XBlockExpression__Group__0)
		{ after(grammarAccess.getXBlockExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXExpressionOrVarDeclaration
entryRuleXExpressionOrVarDeclaration
:
{ before(grammarAccess.getXExpressionOrVarDeclarationRule()); }
	 ruleXExpressionOrVarDeclaration
{ after(grammarAccess.getXExpressionOrVarDeclarationRule()); } 
	 EOF 
;

// Rule XExpressionOrVarDeclaration
ruleXExpressionOrVarDeclaration 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXExpressionOrVarDeclarationAccess().getAlternatives()); }
		(rule__XExpressionOrVarDeclaration__Alternatives)
		{ after(grammarAccess.getXExpressionOrVarDeclarationAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXVariableDeclaration
entryRuleXVariableDeclaration
:
{ before(grammarAccess.getXVariableDeclarationRule()); }
	 ruleXVariableDeclaration
{ after(grammarAccess.getXVariableDeclarationRule()); } 
	 EOF 
;

// Rule XVariableDeclaration
ruleXVariableDeclaration 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXVariableDeclarationAccess().getGroup()); }
		(rule__XVariableDeclaration__Group__0)
		{ after(grammarAccess.getXVariableDeclarationAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleJvmFormalParameter
entryRuleJvmFormalParameter
:
{ before(grammarAccess.getJvmFormalParameterRule()); }
	 ruleJvmFormalParameter
{ after(grammarAccess.getJvmFormalParameterRule()); } 
	 EOF 
;

// Rule JvmFormalParameter
ruleJvmFormalParameter 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getJvmFormalParameterAccess().getGroup()); }
		(rule__JvmFormalParameter__Group__0)
		{ after(grammarAccess.getJvmFormalParameterAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleFullJvmFormalParameter
entryRuleFullJvmFormalParameter
:
{ before(grammarAccess.getFullJvmFormalParameterRule()); }
	 ruleFullJvmFormalParameter
{ after(grammarAccess.getFullJvmFormalParameterRule()); } 
	 EOF 
;

// Rule FullJvmFormalParameter
ruleFullJvmFormalParameter 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getFullJvmFormalParameterAccess().getGroup()); }
		(rule__FullJvmFormalParameter__Group__0)
		{ after(grammarAccess.getFullJvmFormalParameterAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXFeatureCall
entryRuleXFeatureCall
:
{ before(grammarAccess.getXFeatureCallRule()); }
	 ruleXFeatureCall
{ after(grammarAccess.getXFeatureCallRule()); } 
	 EOF 
;

// Rule XFeatureCall
ruleXFeatureCall 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXFeatureCallAccess().getGroup()); }
		(rule__XFeatureCall__Group__0)
		{ after(grammarAccess.getXFeatureCallAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleFeatureCallID
entryRuleFeatureCallID
:
{ before(grammarAccess.getFeatureCallIDRule()); }
	 ruleFeatureCallID
{ after(grammarAccess.getFeatureCallIDRule()); } 
	 EOF 
;

// Rule FeatureCallID
ruleFeatureCallID 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getFeatureCallIDAccess().getAlternatives()); }
		(rule__FeatureCallID__Alternatives)
		{ after(grammarAccess.getFeatureCallIDAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleIdOrSuper
entryRuleIdOrSuper
:
{ before(grammarAccess.getIdOrSuperRule()); }
	 ruleIdOrSuper
{ after(grammarAccess.getIdOrSuperRule()); } 
	 EOF 
;

// Rule IdOrSuper
ruleIdOrSuper 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getIdOrSuperAccess().getAlternatives()); }
		(rule__IdOrSuper__Alternatives)
		{ after(grammarAccess.getIdOrSuperAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXConstructorCall
entryRuleXConstructorCall
:
{ before(grammarAccess.getXConstructorCallRule()); }
	 ruleXConstructorCall
{ after(grammarAccess.getXConstructorCallRule()); } 
	 EOF 
;

// Rule XConstructorCall
ruleXConstructorCall 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXConstructorCallAccess().getGroup()); }
		(rule__XConstructorCall__Group__0)
		{ after(grammarAccess.getXConstructorCallAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXBooleanLiteral
entryRuleXBooleanLiteral
:
{ before(grammarAccess.getXBooleanLiteralRule()); }
	 ruleXBooleanLiteral
{ after(grammarAccess.getXBooleanLiteralRule()); } 
	 EOF 
;

// Rule XBooleanLiteral
ruleXBooleanLiteral 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXBooleanLiteralAccess().getGroup()); }
		(rule__XBooleanLiteral__Group__0)
		{ after(grammarAccess.getXBooleanLiteralAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXNullLiteral
entryRuleXNullLiteral
:
{ before(grammarAccess.getXNullLiteralRule()); }
	 ruleXNullLiteral
{ after(grammarAccess.getXNullLiteralRule()); } 
	 EOF 
;

// Rule XNullLiteral
ruleXNullLiteral 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXNullLiteralAccess().getGroup()); }
		(rule__XNullLiteral__Group__0)
		{ after(grammarAccess.getXNullLiteralAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXNumberLiteral
entryRuleXNumberLiteral
:
{ before(grammarAccess.getXNumberLiteralRule()); }
	 ruleXNumberLiteral
{ after(grammarAccess.getXNumberLiteralRule()); } 
	 EOF 
;

// Rule XNumberLiteral
ruleXNumberLiteral 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXNumberLiteralAccess().getGroup()); }
		(rule__XNumberLiteral__Group__0)
		{ after(grammarAccess.getXNumberLiteralAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXStringLiteral
entryRuleXStringLiteral
:
{ before(grammarAccess.getXStringLiteralRule()); }
	 ruleXStringLiteral
{ after(grammarAccess.getXStringLiteralRule()); } 
	 EOF 
;

// Rule XStringLiteral
ruleXStringLiteral 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXStringLiteralAccess().getGroup()); }
		(rule__XStringLiteral__Group__0)
		{ after(grammarAccess.getXStringLiteralAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXTypeLiteral
entryRuleXTypeLiteral
:
{ before(grammarAccess.getXTypeLiteralRule()); }
	 ruleXTypeLiteral
{ after(grammarAccess.getXTypeLiteralRule()); } 
	 EOF 
;

// Rule XTypeLiteral
ruleXTypeLiteral 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXTypeLiteralAccess().getGroup()); }
		(rule__XTypeLiteral__Group__0)
		{ after(grammarAccess.getXTypeLiteralAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXThrowExpression
entryRuleXThrowExpression
:
{ before(grammarAccess.getXThrowExpressionRule()); }
	 ruleXThrowExpression
{ after(grammarAccess.getXThrowExpressionRule()); } 
	 EOF 
;

// Rule XThrowExpression
ruleXThrowExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXThrowExpressionAccess().getGroup()); }
		(rule__XThrowExpression__Group__0)
		{ after(grammarAccess.getXThrowExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXReturnExpression
entryRuleXReturnExpression
:
{ before(grammarAccess.getXReturnExpressionRule()); }
	 ruleXReturnExpression
{ after(grammarAccess.getXReturnExpressionRule()); } 
	 EOF 
;

// Rule XReturnExpression
ruleXReturnExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXReturnExpressionAccess().getGroup()); }
		(rule__XReturnExpression__Group__0)
		{ after(grammarAccess.getXReturnExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXTryCatchFinallyExpression
entryRuleXTryCatchFinallyExpression
:
{ before(grammarAccess.getXTryCatchFinallyExpressionRule()); }
	 ruleXTryCatchFinallyExpression
{ after(grammarAccess.getXTryCatchFinallyExpressionRule()); } 
	 EOF 
;

// Rule XTryCatchFinallyExpression
ruleXTryCatchFinallyExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getGroup()); }
		(rule__XTryCatchFinallyExpression__Group__0)
		{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXSynchronizedExpression
entryRuleXSynchronizedExpression
:
{ before(grammarAccess.getXSynchronizedExpressionRule()); }
	 ruleXSynchronizedExpression
{ after(grammarAccess.getXSynchronizedExpressionRule()); } 
	 EOF 
;

// Rule XSynchronizedExpression
ruleXSynchronizedExpression 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXSynchronizedExpressionAccess().getGroup()); }
		(rule__XSynchronizedExpression__Group__0)
		{ after(grammarAccess.getXSynchronizedExpressionAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXCatchClause
entryRuleXCatchClause
:
{ before(grammarAccess.getXCatchClauseRule()); }
	 ruleXCatchClause
{ after(grammarAccess.getXCatchClauseRule()); } 
	 EOF 
;

// Rule XCatchClause
ruleXCatchClause 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXCatchClauseAccess().getGroup()); }
		(rule__XCatchClause__Group__0)
		{ after(grammarAccess.getXCatchClauseAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleQualifiedName
entryRuleQualifiedName
:
{ before(grammarAccess.getQualifiedNameRule()); }
	 ruleQualifiedName
{ after(grammarAccess.getQualifiedNameRule()); } 
	 EOF 
;

// Rule QualifiedName
ruleQualifiedName 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getQualifiedNameAccess().getGroup()); }
		(rule__QualifiedName__Group__0)
		{ after(grammarAccess.getQualifiedNameAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleNumber
entryRuleNumber
@init { 
	HiddenTokens myHiddenTokenState = ((XtextTokenStream)input).setHiddenTokens();
}
:
{ before(grammarAccess.getNumberRule()); }
	 ruleNumber
{ after(grammarAccess.getNumberRule()); } 
	 EOF 
;
finally {
	myHiddenTokenState.restore();
}

// Rule Number
ruleNumber 
	@init {
		HiddenTokens myHiddenTokenState = ((XtextTokenStream)input).setHiddenTokens();
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getNumberAccess().getAlternatives()); }
		(rule__Number__Alternatives)
		{ after(grammarAccess.getNumberAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
	myHiddenTokenState.restore();
}

// Entry rule entryRuleJvmTypeReference
entryRuleJvmTypeReference
:
{ before(grammarAccess.getJvmTypeReferenceRule()); }
	 ruleJvmTypeReference
{ after(grammarAccess.getJvmTypeReferenceRule()); } 
	 EOF 
;

// Rule JvmTypeReference
ruleJvmTypeReference 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getJvmTypeReferenceAccess().getAlternatives()); }
		(rule__JvmTypeReference__Alternatives)
		{ after(grammarAccess.getJvmTypeReferenceAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleArrayBrackets
entryRuleArrayBrackets
:
{ before(grammarAccess.getArrayBracketsRule()); }
	 ruleArrayBrackets
{ after(grammarAccess.getArrayBracketsRule()); } 
	 EOF 
;

// Rule ArrayBrackets
ruleArrayBrackets 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getArrayBracketsAccess().getGroup()); }
		(rule__ArrayBrackets__Group__0)
		{ after(grammarAccess.getArrayBracketsAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXFunctionTypeRef
entryRuleXFunctionTypeRef
:
{ before(grammarAccess.getXFunctionTypeRefRule()); }
	 ruleXFunctionTypeRef
{ after(grammarAccess.getXFunctionTypeRefRule()); } 
	 EOF 
;

// Rule XFunctionTypeRef
ruleXFunctionTypeRef 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXFunctionTypeRefAccess().getGroup()); }
		(rule__XFunctionTypeRef__Group__0)
		{ after(grammarAccess.getXFunctionTypeRefAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleJvmParameterizedTypeReference
entryRuleJvmParameterizedTypeReference
:
{ before(grammarAccess.getJvmParameterizedTypeReferenceRule()); }
	 ruleJvmParameterizedTypeReference
{ after(grammarAccess.getJvmParameterizedTypeReferenceRule()); } 
	 EOF 
;

// Rule JvmParameterizedTypeReference
ruleJvmParameterizedTypeReference 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup()); }
		(rule__JvmParameterizedTypeReference__Group__0)
		{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleJvmArgumentTypeReference
entryRuleJvmArgumentTypeReference
:
{ before(grammarAccess.getJvmArgumentTypeReferenceRule()); }
	 ruleJvmArgumentTypeReference
{ after(grammarAccess.getJvmArgumentTypeReferenceRule()); } 
	 EOF 
;

// Rule JvmArgumentTypeReference
ruleJvmArgumentTypeReference 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getJvmArgumentTypeReferenceAccess().getAlternatives()); }
		(rule__JvmArgumentTypeReference__Alternatives)
		{ after(grammarAccess.getJvmArgumentTypeReferenceAccess().getAlternatives()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleJvmWildcardTypeReference
entryRuleJvmWildcardTypeReference
:
{ before(grammarAccess.getJvmWildcardTypeReferenceRule()); }
	 ruleJvmWildcardTypeReference
{ after(grammarAccess.getJvmWildcardTypeReferenceRule()); } 
	 EOF 
;

// Rule JvmWildcardTypeReference
ruleJvmWildcardTypeReference 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getGroup()); }
		(rule__JvmWildcardTypeReference__Group__0)
		{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleJvmUpperBound
entryRuleJvmUpperBound
:
{ before(grammarAccess.getJvmUpperBoundRule()); }
	 ruleJvmUpperBound
{ after(grammarAccess.getJvmUpperBoundRule()); } 
	 EOF 
;

// Rule JvmUpperBound
ruleJvmUpperBound 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getJvmUpperBoundAccess().getGroup()); }
		(rule__JvmUpperBound__Group__0)
		{ after(grammarAccess.getJvmUpperBoundAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleJvmUpperBoundAnded
entryRuleJvmUpperBoundAnded
:
{ before(grammarAccess.getJvmUpperBoundAndedRule()); }
	 ruleJvmUpperBoundAnded
{ after(grammarAccess.getJvmUpperBoundAndedRule()); } 
	 EOF 
;

// Rule JvmUpperBoundAnded
ruleJvmUpperBoundAnded 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getJvmUpperBoundAndedAccess().getGroup()); }
		(rule__JvmUpperBoundAnded__Group__0)
		{ after(grammarAccess.getJvmUpperBoundAndedAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleJvmLowerBound
entryRuleJvmLowerBound
:
{ before(grammarAccess.getJvmLowerBoundRule()); }
	 ruleJvmLowerBound
{ after(grammarAccess.getJvmLowerBoundRule()); } 
	 EOF 
;

// Rule JvmLowerBound
ruleJvmLowerBound 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getJvmLowerBoundAccess().getGroup()); }
		(rule__JvmLowerBound__Group__0)
		{ after(grammarAccess.getJvmLowerBoundAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleJvmLowerBoundAnded
entryRuleJvmLowerBoundAnded
:
{ before(grammarAccess.getJvmLowerBoundAndedRule()); }
	 ruleJvmLowerBoundAnded
{ after(grammarAccess.getJvmLowerBoundAndedRule()); } 
	 EOF 
;

// Rule JvmLowerBoundAnded
ruleJvmLowerBoundAnded 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getJvmLowerBoundAndedAccess().getGroup()); }
		(rule__JvmLowerBoundAnded__Group__0)
		{ after(grammarAccess.getJvmLowerBoundAndedAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleQualifiedNameWithWildcard
entryRuleQualifiedNameWithWildcard
:
{ before(grammarAccess.getQualifiedNameWithWildcardRule()); }
	 ruleQualifiedNameWithWildcard
{ after(grammarAccess.getQualifiedNameWithWildcardRule()); } 
	 EOF 
;

// Rule QualifiedNameWithWildcard
ruleQualifiedNameWithWildcard 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getQualifiedNameWithWildcardAccess().getGroup()); }
		(rule__QualifiedNameWithWildcard__Group__0)
		{ after(grammarAccess.getQualifiedNameWithWildcardAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleValidID
entryRuleValidID
:
{ before(grammarAccess.getValidIDRule()); }
	 ruleValidID
{ after(grammarAccess.getValidIDRule()); } 
	 EOF 
;

// Rule ValidID
ruleValidID 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getValidIDAccess().getIDTerminalRuleCall()); }
		RULE_ID
		{ after(grammarAccess.getValidIDAccess().getIDTerminalRuleCall()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleXImportDeclaration
entryRuleXImportDeclaration
:
{ before(grammarAccess.getXImportDeclarationRule()); }
	 ruleXImportDeclaration
{ after(grammarAccess.getXImportDeclarationRule()); } 
	 EOF 
;

// Rule XImportDeclaration
ruleXImportDeclaration 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getGroup()); }
		(rule__XImportDeclaration__Group__0)
		{ after(grammarAccess.getXImportDeclarationAccess().getGroup()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

// Entry rule entryRuleQualifiedNameInStaticImport
entryRuleQualifiedNameInStaticImport
:
{ before(grammarAccess.getQualifiedNameInStaticImportRule()); }
	 ruleQualifiedNameInStaticImport
{ after(grammarAccess.getQualifiedNameInStaticImportRule()); } 
	 EOF 
;

// Rule QualifiedNameInStaticImport
ruleQualifiedNameInStaticImport 
	@init {
		int stackSize = keepStackSize();
	}
	:
	(
		(
			{ before(grammarAccess.getQualifiedNameInStaticImportAccess().getGroup()); }
			(rule__QualifiedNameInStaticImport__Group__0)
			{ after(grammarAccess.getQualifiedNameInStaticImportAccess().getGroup()); }
		)
		(
			{ before(grammarAccess.getQualifiedNameInStaticImportAccess().getGroup()); }
			(rule__QualifiedNameInStaticImport__Group__0)*
			{ after(grammarAccess.getQualifiedNameInStaticImportAccess().getGroup()); }
		)
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXAssignmentAccess().getGroup_0()); }
		(rule__XAssignment__Group_0__0)
		{ after(grammarAccess.getXAssignmentAccess().getGroup_0()); }
	)
	|
	(
		{ before(grammarAccess.getXAssignmentAccess().getGroup_1()); }
		(rule__XAssignment__Group_1__0)
		{ after(grammarAccess.getXAssignmentAccess().getGroup_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMultiAssign__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getOpMultiAssignAccess().getPlusSignEqualsSignKeyword_0()); }
		'+='
		{ after(grammarAccess.getOpMultiAssignAccess().getPlusSignEqualsSignKeyword_0()); }
	)
	|
	(
		{ before(grammarAccess.getOpMultiAssignAccess().getHyphenMinusEqualsSignKeyword_1()); }
		'-='
		{ after(grammarAccess.getOpMultiAssignAccess().getHyphenMinusEqualsSignKeyword_1()); }
	)
	|
	(
		{ before(grammarAccess.getOpMultiAssignAccess().getAsteriskEqualsSignKeyword_2()); }
		'*='
		{ after(grammarAccess.getOpMultiAssignAccess().getAsteriskEqualsSignKeyword_2()); }
	)
	|
	(
		{ before(grammarAccess.getOpMultiAssignAccess().getSolidusEqualsSignKeyword_3()); }
		'/='
		{ after(grammarAccess.getOpMultiAssignAccess().getSolidusEqualsSignKeyword_3()); }
	)
	|
	(
		{ before(grammarAccess.getOpMultiAssignAccess().getPercentSignEqualsSignKeyword_4()); }
		'%='
		{ after(grammarAccess.getOpMultiAssignAccess().getPercentSignEqualsSignKeyword_4()); }
	)
	|
	(
		{ before(grammarAccess.getOpMultiAssignAccess().getGroup_5()); }
		(rule__OpMultiAssign__Group_5__0)
		{ after(grammarAccess.getOpMultiAssignAccess().getGroup_5()); }
	)
	|
	(
		{ before(grammarAccess.getOpMultiAssignAccess().getGroup_6()); }
		(rule__OpMultiAssign__Group_6__0)
		{ after(grammarAccess.getOpMultiAssignAccess().getGroup_6()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpEquality__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getOpEqualityAccess().getEqualsSignEqualsSignKeyword_0()); }
		'=='
		{ after(grammarAccess.getOpEqualityAccess().getEqualsSignEqualsSignKeyword_0()); }
	)
	|
	(
		{ before(grammarAccess.getOpEqualityAccess().getExclamationMarkEqualsSignKeyword_1()); }
		'!='
		{ after(grammarAccess.getOpEqualityAccess().getExclamationMarkEqualsSignKeyword_1()); }
	)
	|
	(
		{ before(grammarAccess.getOpEqualityAccess().getEqualsSignEqualsSignEqualsSignKeyword_2()); }
		'==='
		{ after(grammarAccess.getOpEqualityAccess().getEqualsSignEqualsSignEqualsSignKeyword_2()); }
	)
	|
	(
		{ before(grammarAccess.getOpEqualityAccess().getExclamationMarkEqualsSignEqualsSignKeyword_3()); }
		'!=='
		{ after(grammarAccess.getOpEqualityAccess().getExclamationMarkEqualsSignEqualsSignKeyword_3()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Alternatives_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXRelationalExpressionAccess().getGroup_1_0()); }
		(rule__XRelationalExpression__Group_1_0__0)
		{ after(grammarAccess.getXRelationalExpressionAccess().getGroup_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getXRelationalExpressionAccess().getGroup_1_1()); }
		(rule__XRelationalExpression__Group_1_1__0)
		{ after(grammarAccess.getXRelationalExpressionAccess().getGroup_1_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpCompare__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getOpCompareAccess().getGreaterThanSignEqualsSignKeyword_0()); }
		'>='
		{ after(grammarAccess.getOpCompareAccess().getGreaterThanSignEqualsSignKeyword_0()); }
	)
	|
	(
		{ before(grammarAccess.getOpCompareAccess().getGroup_1()); }
		(rule__OpCompare__Group_1__0)
		{ after(grammarAccess.getOpCompareAccess().getGroup_1()); }
	)
	|
	(
		{ before(grammarAccess.getOpCompareAccess().getGreaterThanSignKeyword_2()); }
		'>'
		{ after(grammarAccess.getOpCompareAccess().getGreaterThanSignKeyword_2()); }
	)
	|
	(
		{ before(grammarAccess.getOpCompareAccess().getLessThanSignKeyword_3()); }
		'<'
		{ after(grammarAccess.getOpCompareAccess().getLessThanSignKeyword_3()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getOpOtherAccess().getHyphenMinusGreaterThanSignKeyword_0()); }
		'->'
		{ after(grammarAccess.getOpOtherAccess().getHyphenMinusGreaterThanSignKeyword_0()); }
	)
	|
	(
		{ before(grammarAccess.getOpOtherAccess().getFullStopFullStopLessThanSignKeyword_1()); }
		'..<'
		{ after(grammarAccess.getOpOtherAccess().getFullStopFullStopLessThanSignKeyword_1()); }
	)
	|
	(
		{ before(grammarAccess.getOpOtherAccess().getGroup_2()); }
		(rule__OpOther__Group_2__0)
		{ after(grammarAccess.getOpOtherAccess().getGroup_2()); }
	)
	|
	(
		{ before(grammarAccess.getOpOtherAccess().getFullStopFullStopKeyword_3()); }
		'..'
		{ after(grammarAccess.getOpOtherAccess().getFullStopFullStopKeyword_3()); }
	)
	|
	(
		{ before(grammarAccess.getOpOtherAccess().getEqualsSignGreaterThanSignKeyword_4()); }
		'=>'
		{ after(grammarAccess.getOpOtherAccess().getEqualsSignGreaterThanSignKeyword_4()); }
	)
	|
	(
		{ before(grammarAccess.getOpOtherAccess().getGroup_5()); }
		(rule__OpOther__Group_5__0)
		{ after(grammarAccess.getOpOtherAccess().getGroup_5()); }
	)
	|
	(
		{ before(grammarAccess.getOpOtherAccess().getGroup_6()); }
		(rule__OpOther__Group_6__0)
		{ after(grammarAccess.getOpOtherAccess().getGroup_6()); }
	)
	|
	(
		{ before(grammarAccess.getOpOtherAccess().getLessThanSignGreaterThanSignKeyword_7()); }
		'<>'
		{ after(grammarAccess.getOpOtherAccess().getLessThanSignGreaterThanSignKeyword_7()); }
	)
	|
	(
		{ before(grammarAccess.getOpOtherAccess().getQuestionMarkColonKeyword_8()); }
		'?:'
		{ after(grammarAccess.getOpOtherAccess().getQuestionMarkColonKeyword_8()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Alternatives_5_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getOpOtherAccess().getGroup_5_1_0()); }
		(rule__OpOther__Group_5_1_0__0)
		{ after(grammarAccess.getOpOtherAccess().getGroup_5_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getOpOtherAccess().getGreaterThanSignKeyword_5_1_1()); }
		'>'
		{ after(grammarAccess.getOpOtherAccess().getGreaterThanSignKeyword_5_1_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Alternatives_6_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getOpOtherAccess().getGroup_6_1_0()); }
		(rule__OpOther__Group_6_1_0__0)
		{ after(grammarAccess.getOpOtherAccess().getGroup_6_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getOpOtherAccess().getLessThanSignKeyword_6_1_1()); }
		'<'
		{ after(grammarAccess.getOpOtherAccess().getLessThanSignKeyword_6_1_1()); }
	)
	|
	(
		{ before(grammarAccess.getOpOtherAccess().getEqualsSignGreaterThanSignKeyword_6_1_2()); }
		'=>'
		{ after(grammarAccess.getOpOtherAccess().getEqualsSignGreaterThanSignKeyword_6_1_2()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpAdd__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getOpAddAccess().getPlusSignKeyword_0()); }
		'+'
		{ after(grammarAccess.getOpAddAccess().getPlusSignKeyword_0()); }
	)
	|
	(
		{ before(grammarAccess.getOpAddAccess().getHyphenMinusKeyword_1()); }
		'-'
		{ after(grammarAccess.getOpAddAccess().getHyphenMinusKeyword_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMulti__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getOpMultiAccess().getAsteriskKeyword_0()); }
		'*'
		{ after(grammarAccess.getOpMultiAccess().getAsteriskKeyword_0()); }
	)
	|
	(
		{ before(grammarAccess.getOpMultiAccess().getAsteriskAsteriskKeyword_1()); }
		'**'
		{ after(grammarAccess.getOpMultiAccess().getAsteriskAsteriskKeyword_1()); }
	)
	|
	(
		{ before(grammarAccess.getOpMultiAccess().getSolidusKeyword_2()); }
		'/'
		{ after(grammarAccess.getOpMultiAccess().getSolidusKeyword_2()); }
	)
	|
	(
		{ before(grammarAccess.getOpMultiAccess().getPercentSignKeyword_3()); }
		'%'
		{ after(grammarAccess.getOpMultiAccess().getPercentSignKeyword_3()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XUnaryOperation__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXUnaryOperationAccess().getGroup_0()); }
		(rule__XUnaryOperation__Group_0__0)
		{ after(grammarAccess.getXUnaryOperationAccess().getGroup_0()); }
	)
	|
	(
		{ before(grammarAccess.getXUnaryOperationAccess().getXCastedExpressionParserRuleCall_1()); }
		ruleXCastedExpression
		{ after(grammarAccess.getXUnaryOperationAccess().getXCastedExpressionParserRuleCall_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpUnary__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getOpUnaryAccess().getExclamationMarkKeyword_0()); }
		'!'
		{ after(grammarAccess.getOpUnaryAccess().getExclamationMarkKeyword_0()); }
	)
	|
	(
		{ before(grammarAccess.getOpUnaryAccess().getHyphenMinusKeyword_1()); }
		'-'
		{ after(grammarAccess.getOpUnaryAccess().getHyphenMinusKeyword_1()); }
	)
	|
	(
		{ before(grammarAccess.getOpUnaryAccess().getPlusSignKeyword_2()); }
		'+'
		{ after(grammarAccess.getOpUnaryAccess().getPlusSignKeyword_2()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpPostfix__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getOpPostfixAccess().getPlusSignPlusSignKeyword_0()); }
		'++'
		{ after(grammarAccess.getOpPostfixAccess().getPlusSignPlusSignKeyword_0()); }
	)
	|
	(
		{ before(grammarAccess.getOpPostfixAccess().getHyphenMinusHyphenMinusKeyword_1()); }
		'--'
		{ after(grammarAccess.getOpPostfixAccess().getHyphenMinusHyphenMinusKeyword_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Alternatives_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_0()); }
		(rule__XMemberFeatureCall__Group_1_0__0)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1()); }
		(rule__XMemberFeatureCall__Group_1_1__0)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Alternatives_1_0_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getFullStopKeyword_1_0_0_0_1_0()); }
		'.'
		{ after(grammarAccess.getXMemberFeatureCallAccess().getFullStopKeyword_1_0_0_0_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticAssignment_1_0_0_0_1_1()); }
		(rule__XMemberFeatureCall__ExplicitStaticAssignment_1_0_0_0_1_1)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticAssignment_1_0_0_0_1_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Alternatives_1_1_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getFullStopKeyword_1_1_0_0_1_0()); }
		'.'
		{ after(grammarAccess.getXMemberFeatureCallAccess().getFullStopKeyword_1_1_0_0_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getNullSafeAssignment_1_1_0_0_1_1()); }
		(rule__XMemberFeatureCall__NullSafeAssignment_1_1_0_0_1_1)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getNullSafeAssignment_1_1_0_0_1_1()); }
	)
	|
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticAssignment_1_1_0_0_1_2()); }
		(rule__XMemberFeatureCall__ExplicitStaticAssignment_1_1_0_0_1_2)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticAssignment_1_1_0_0_1_2()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Alternatives_1_1_3_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsAssignment_1_1_3_1_0()); }
		(rule__XMemberFeatureCall__MemberCallArgumentsAssignment_1_1_3_1_0)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsAssignment_1_1_3_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_3_1_1()); }
		(rule__XMemberFeatureCall__Group_1_1_3_1_1__0)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_3_1_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XPrimaryExpression__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXConstructorCallParserRuleCall_0()); }
		ruleXConstructorCall
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXConstructorCallParserRuleCall_0()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXBlockExpressionParserRuleCall_1()); }
		ruleXBlockExpression
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXBlockExpressionParserRuleCall_1()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXSwitchExpressionParserRuleCall_2()); }
		ruleXSwitchExpression
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXSwitchExpressionParserRuleCall_2()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXSynchronizedExpressionParserRuleCall_3()); }
		(ruleXSynchronizedExpression)
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXSynchronizedExpressionParserRuleCall_3()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXFeatureCallParserRuleCall_4()); }
		ruleXFeatureCall
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXFeatureCallParserRuleCall_4()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXLiteralParserRuleCall_5()); }
		ruleXLiteral
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXLiteralParserRuleCall_5()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXIfExpressionParserRuleCall_6()); }
		ruleXIfExpression
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXIfExpressionParserRuleCall_6()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXForLoopExpressionParserRuleCall_7()); }
		(ruleXForLoopExpression)
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXForLoopExpressionParserRuleCall_7()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXBasicForLoopExpressionParserRuleCall_8()); }
		ruleXBasicForLoopExpression
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXBasicForLoopExpressionParserRuleCall_8()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXWhileExpressionParserRuleCall_9()); }
		ruleXWhileExpression
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXWhileExpressionParserRuleCall_9()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXDoWhileExpressionParserRuleCall_10()); }
		ruleXDoWhileExpression
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXDoWhileExpressionParserRuleCall_10()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXThrowExpressionParserRuleCall_11()); }
		ruleXThrowExpression
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXThrowExpressionParserRuleCall_11()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXReturnExpressionParserRuleCall_12()); }
		ruleXReturnExpression
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXReturnExpressionParserRuleCall_12()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXTryCatchFinallyExpressionParserRuleCall_13()); }
		ruleXTryCatchFinallyExpression
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXTryCatchFinallyExpressionParserRuleCall_13()); }
	)
	|
	(
		{ before(grammarAccess.getXPrimaryExpressionAccess().getXParenthesizedExpressionParserRuleCall_14()); }
		ruleXParenthesizedExpression
		{ after(grammarAccess.getXPrimaryExpressionAccess().getXParenthesizedExpressionParserRuleCall_14()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XLiteral__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXLiteralAccess().getXCollectionLiteralParserRuleCall_0()); }
		ruleXCollectionLiteral
		{ after(grammarAccess.getXLiteralAccess().getXCollectionLiteralParserRuleCall_0()); }
	)
	|
	(
		{ before(grammarAccess.getXLiteralAccess().getXClosureParserRuleCall_1()); }
		(ruleXClosure)
		{ after(grammarAccess.getXLiteralAccess().getXClosureParserRuleCall_1()); }
	)
	|
	(
		{ before(grammarAccess.getXLiteralAccess().getXBooleanLiteralParserRuleCall_2()); }
		ruleXBooleanLiteral
		{ after(grammarAccess.getXLiteralAccess().getXBooleanLiteralParserRuleCall_2()); }
	)
	|
	(
		{ before(grammarAccess.getXLiteralAccess().getXNumberLiteralParserRuleCall_3()); }
		ruleXNumberLiteral
		{ after(grammarAccess.getXLiteralAccess().getXNumberLiteralParserRuleCall_3()); }
	)
	|
	(
		{ before(grammarAccess.getXLiteralAccess().getXNullLiteralParserRuleCall_4()); }
		ruleXNullLiteral
		{ after(grammarAccess.getXLiteralAccess().getXNullLiteralParserRuleCall_4()); }
	)
	|
	(
		{ before(grammarAccess.getXLiteralAccess().getXStringLiteralParserRuleCall_5()); }
		ruleXStringLiteral
		{ after(grammarAccess.getXLiteralAccess().getXStringLiteralParserRuleCall_5()); }
	)
	|
	(
		{ before(grammarAccess.getXLiteralAccess().getXTypeLiteralParserRuleCall_6()); }
		ruleXTypeLiteral
		{ after(grammarAccess.getXLiteralAccess().getXTypeLiteralParserRuleCall_6()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCollectionLiteral__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXCollectionLiteralAccess().getXSetLiteralParserRuleCall_0()); }
		ruleXSetLiteral
		{ after(grammarAccess.getXCollectionLiteralAccess().getXSetLiteralParserRuleCall_0()); }
	)
	|
	(
		{ before(grammarAccess.getXCollectionLiteralAccess().getXListLiteralParserRuleCall_1()); }
		ruleXListLiteral
		{ after(grammarAccess.getXCollectionLiteralAccess().getXListLiteralParserRuleCall_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Alternatives_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXSwitchExpressionAccess().getGroup_2_0()); }
		(rule__XSwitchExpression__Group_2_0__0)
		{ after(grammarAccess.getXSwitchExpressionAccess().getGroup_2_0()); }
	)
	|
	(
		{ before(grammarAccess.getXSwitchExpressionAccess().getGroup_2_1()); }
		(rule__XSwitchExpression__Group_2_1__0)
		{ after(grammarAccess.getXSwitchExpressionAccess().getGroup_2_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Alternatives_3
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXCasePartAccess().getGroup_3_0()); }
		(rule__XCasePart__Group_3_0__0)
		{ after(grammarAccess.getXCasePartAccess().getGroup_3_0()); }
	)
	|
	(
		{ before(grammarAccess.getXCasePartAccess().getFallThroughAssignment_3_1()); }
		(rule__XCasePart__FallThroughAssignment_3_1)
		{ after(grammarAccess.getXCasePartAccess().getFallThroughAssignment_3_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XExpressionOrVarDeclaration__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXExpressionOrVarDeclarationAccess().getXVariableDeclarationParserRuleCall_0()); }
		ruleXVariableDeclaration
		{ after(grammarAccess.getXExpressionOrVarDeclarationAccess().getXVariableDeclarationParserRuleCall_0()); }
	)
	|
	(
		{ before(grammarAccess.getXExpressionOrVarDeclarationAccess().getXExpressionParserRuleCall_1()); }
		ruleXExpression
		{ after(grammarAccess.getXExpressionOrVarDeclarationAccess().getXExpressionParserRuleCall_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Alternatives_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXVariableDeclarationAccess().getWriteableAssignment_1_0()); }
		(rule__XVariableDeclaration__WriteableAssignment_1_0)
		{ after(grammarAccess.getXVariableDeclarationAccess().getWriteableAssignment_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getXVariableDeclarationAccess().getValKeyword_1_1()); }
		'val'
		{ after(grammarAccess.getXVariableDeclarationAccess().getValKeyword_1_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Alternatives_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXVariableDeclarationAccess().getGroup_2_0()); }
		(rule__XVariableDeclaration__Group_2_0__0)
		{ after(grammarAccess.getXVariableDeclarationAccess().getGroup_2_0()); }
	)
	|
	(
		{ before(grammarAccess.getXVariableDeclarationAccess().getNameAssignment_2_1()); }
		(rule__XVariableDeclaration__NameAssignment_2_1)
		{ after(grammarAccess.getXVariableDeclarationAccess().getNameAssignment_2_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Alternatives_3_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsAssignment_3_1_0()); }
		(rule__XFeatureCall__FeatureCallArgumentsAssignment_3_1_0)
		{ after(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsAssignment_3_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getXFeatureCallAccess().getGroup_3_1_1()); }
		(rule__XFeatureCall__Group_3_1_1__0)
		{ after(grammarAccess.getXFeatureCallAccess().getGroup_3_1_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__FeatureCallID__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getFeatureCallIDAccess().getValidIDParserRuleCall_0()); }
		ruleValidID
		{ after(grammarAccess.getFeatureCallIDAccess().getValidIDParserRuleCall_0()); }
	)
	|
	(
		{ before(grammarAccess.getFeatureCallIDAccess().getExtendsKeyword_1()); }
		'extends'
		{ after(grammarAccess.getFeatureCallIDAccess().getExtendsKeyword_1()); }
	)
	|
	(
		{ before(grammarAccess.getFeatureCallIDAccess().getStaticKeyword_2()); }
		'static'
		{ after(grammarAccess.getFeatureCallIDAccess().getStaticKeyword_2()); }
	)
	|
	(
		{ before(grammarAccess.getFeatureCallIDAccess().getImportKeyword_3()); }
		'import'
		{ after(grammarAccess.getFeatureCallIDAccess().getImportKeyword_3()); }
	)
	|
	(
		{ before(grammarAccess.getFeatureCallIDAccess().getExtensionKeyword_4()); }
		'extension'
		{ after(grammarAccess.getFeatureCallIDAccess().getExtensionKeyword_4()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__IdOrSuper__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getIdOrSuperAccess().getFeatureCallIDParserRuleCall_0()); }
		ruleFeatureCallID
		{ after(grammarAccess.getIdOrSuperAccess().getFeatureCallIDParserRuleCall_0()); }
	)
	|
	(
		{ before(grammarAccess.getIdOrSuperAccess().getSuperKeyword_1()); }
		'super'
		{ after(grammarAccess.getIdOrSuperAccess().getSuperKeyword_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Alternatives_4_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXConstructorCallAccess().getArgumentsAssignment_4_1_0()); }
		(rule__XConstructorCall__ArgumentsAssignment_4_1_0)
		{ after(grammarAccess.getXConstructorCallAccess().getArgumentsAssignment_4_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getXConstructorCallAccess().getGroup_4_1_1()); }
		(rule__XConstructorCall__Group_4_1_1__0)
		{ after(grammarAccess.getXConstructorCallAccess().getGroup_4_1_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBooleanLiteral__Alternatives_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXBooleanLiteralAccess().getFalseKeyword_1_0()); }
		'false'
		{ after(grammarAccess.getXBooleanLiteralAccess().getFalseKeyword_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getXBooleanLiteralAccess().getIsTrueAssignment_1_1()); }
		(rule__XBooleanLiteral__IsTrueAssignment_1_1)
		{ after(grammarAccess.getXBooleanLiteralAccess().getIsTrueAssignment_1_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Alternatives_3
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getGroup_3_0()); }
		(rule__XTryCatchFinallyExpression__Group_3_0__0)
		{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getGroup_3_0()); }
	)
	|
	(
		{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getGroup_3_1()); }
		(rule__XTryCatchFinallyExpression__Group_3_1__0)
		{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getGroup_3_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__Number__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getNumberAccess().getHEXTerminalRuleCall_0()); }
		RULE_HEX
		{ after(grammarAccess.getNumberAccess().getHEXTerminalRuleCall_0()); }
	)
	|
	(
		{ before(grammarAccess.getNumberAccess().getGroup_1()); }
		(rule__Number__Group_1__0)
		{ after(grammarAccess.getNumberAccess().getGroup_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__Number__Alternatives_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getNumberAccess().getINTTerminalRuleCall_1_0_0()); }
		RULE_INT
		{ after(grammarAccess.getNumberAccess().getINTTerminalRuleCall_1_0_0()); }
	)
	|
	(
		{ before(grammarAccess.getNumberAccess().getDECIMALTerminalRuleCall_1_0_1()); }
		RULE_DECIMAL
		{ after(grammarAccess.getNumberAccess().getDECIMALTerminalRuleCall_1_0_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__Number__Alternatives_1_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getNumberAccess().getINTTerminalRuleCall_1_1_1_0()); }
		RULE_INT
		{ after(grammarAccess.getNumberAccess().getINTTerminalRuleCall_1_1_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getNumberAccess().getDECIMALTerminalRuleCall_1_1_1_1()); }
		RULE_DECIMAL
		{ after(grammarAccess.getNumberAccess().getDECIMALTerminalRuleCall_1_1_1_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmTypeReference__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmTypeReferenceAccess().getGroup_0()); }
		(rule__JvmTypeReference__Group_0__0)
		{ after(grammarAccess.getJvmTypeReferenceAccess().getGroup_0()); }
	)
	|
	(
		{ before(grammarAccess.getJvmTypeReferenceAccess().getXFunctionTypeRefParserRuleCall_1()); }
		ruleXFunctionTypeRef
		{ after(grammarAccess.getJvmTypeReferenceAccess().getXFunctionTypeRefParserRuleCall_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmArgumentTypeReference__Alternatives
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmArgumentTypeReferenceAccess().getJvmTypeReferenceParserRuleCall_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getJvmArgumentTypeReferenceAccess().getJvmTypeReferenceParserRuleCall_0()); }
	)
	|
	(
		{ before(grammarAccess.getJvmArgumentTypeReferenceAccess().getJvmWildcardTypeReferenceParserRuleCall_1()); }
		ruleJvmWildcardTypeReference
		{ after(grammarAccess.getJvmArgumentTypeReferenceAccess().getJvmWildcardTypeReferenceParserRuleCall_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Alternatives_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getGroup_2_0()); }
		(rule__JvmWildcardTypeReference__Group_2_0__0)
		{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getGroup_2_0()); }
	)
	|
	(
		{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getGroup_2_1()); }
		(rule__JvmWildcardTypeReference__Group_2_1__0)
		{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getGroup_2_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Alternatives_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getGroup_1_0()); }
		(rule__XImportDeclaration__Group_1_0__0)
		{ after(grammarAccess.getXImportDeclarationAccess().getGroup_1_0()); }
	)
	|
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getImportedTypeAssignment_1_1()); }
		(rule__XImportDeclaration__ImportedTypeAssignment_1_1)
		{ after(grammarAccess.getXImportDeclarationAccess().getImportedTypeAssignment_1_1()); }
	)
	|
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getImportedNamespaceAssignment_1_2()); }
		(rule__XImportDeclaration__ImportedNamespaceAssignment_1_2)
		{ after(grammarAccess.getXImportDeclarationAccess().getImportedNamespaceAssignment_1_2()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Alternatives_1_0_3
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getWildcardAssignment_1_0_3_0()); }
		(rule__XImportDeclaration__WildcardAssignment_1_0_3_0)
		{ after(grammarAccess.getXImportDeclarationAccess().getWildcardAssignment_1_0_3_0()); }
	)
	|
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getMemberNameAssignment_1_0_3_1()); }
		(rule__XImportDeclaration__MemberNameAssignment_1_0_3_1)
		{ after(grammarAccess.getXImportDeclarationAccess().getMemberNameAssignment_1_0_3_1()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAssignment__Group_0__0__Impl
	rule__XAssignment__Group_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAssignmentAccess().getXAssignmentAction_0_0()); }
	()
	{ after(grammarAccess.getXAssignmentAccess().getXAssignmentAction_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAssignment__Group_0__1__Impl
	rule__XAssignment__Group_0__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAssignmentAccess().getFeatureAssignment_0_1()); }
	(rule__XAssignment__FeatureAssignment_0_1)
	{ after(grammarAccess.getXAssignmentAccess().getFeatureAssignment_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_0__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAssignment__Group_0__2__Impl
	rule__XAssignment__Group_0__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_0__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAssignmentAccess().getOpSingleAssignParserRuleCall_0_2()); }
	ruleOpSingleAssign
	{ after(grammarAccess.getXAssignmentAccess().getOpSingleAssignParserRuleCall_0_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_0__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAssignment__Group_0__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_0__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAssignmentAccess().getValueAssignment_0_3()); }
	(rule__XAssignment__ValueAssignment_0_3)
	{ after(grammarAccess.getXAssignmentAccess().getValueAssignment_0_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAssignment__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAssignment__Group_1__0__Impl
	rule__XAssignment__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAssignmentAccess().getXOrExpressionParserRuleCall_1_0()); }
	ruleXOrExpression
	{ after(grammarAccess.getXAssignmentAccess().getXOrExpressionParserRuleCall_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAssignment__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAssignmentAccess().getGroup_1_1()); }
	(rule__XAssignment__Group_1_1__0)?
	{ after(grammarAccess.getXAssignmentAccess().getGroup_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAssignment__Group_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAssignment__Group_1_1__0__Impl
	rule__XAssignment__Group_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAssignmentAccess().getGroup_1_1_0()); }
	(rule__XAssignment__Group_1_1_0__0)
	{ after(grammarAccess.getXAssignmentAccess().getGroup_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAssignment__Group_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAssignmentAccess().getRightOperandAssignment_1_1_1()); }
	(rule__XAssignment__RightOperandAssignment_1_1_1)
	{ after(grammarAccess.getXAssignmentAccess().getRightOperandAssignment_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAssignment__Group_1_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAssignment__Group_1_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_1_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAssignmentAccess().getGroup_1_1_0_0()); }
	(rule__XAssignment__Group_1_1_0_0__0)
	{ after(grammarAccess.getXAssignmentAccess().getGroup_1_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAssignment__Group_1_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAssignment__Group_1_1_0_0__0__Impl
	rule__XAssignment__Group_1_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_1_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAssignmentAccess().getXBinaryOperationLeftOperandAction_1_1_0_0_0()); }
	()
	{ after(grammarAccess.getXAssignmentAccess().getXBinaryOperationLeftOperandAction_1_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_1_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAssignment__Group_1_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__Group_1_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAssignmentAccess().getFeatureAssignment_1_1_0_0_1()); }
	(rule__XAssignment__FeatureAssignment_1_1_0_0_1)
	{ after(grammarAccess.getXAssignmentAccess().getFeatureAssignment_1_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__OpMultiAssign__Group_5__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpMultiAssign__Group_5__0__Impl
	rule__OpMultiAssign__Group_5__1
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMultiAssign__Group_5__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpMultiAssignAccess().getLessThanSignKeyword_5_0()); }
	'<'
	{ after(grammarAccess.getOpMultiAssignAccess().getLessThanSignKeyword_5_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMultiAssign__Group_5__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpMultiAssign__Group_5__1__Impl
	rule__OpMultiAssign__Group_5__2
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMultiAssign__Group_5__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpMultiAssignAccess().getLessThanSignKeyword_5_1()); }
	'<'
	{ after(grammarAccess.getOpMultiAssignAccess().getLessThanSignKeyword_5_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMultiAssign__Group_5__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpMultiAssign__Group_5__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMultiAssign__Group_5__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpMultiAssignAccess().getEqualsSignKeyword_5_2()); }
	'='
	{ after(grammarAccess.getOpMultiAssignAccess().getEqualsSignKeyword_5_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__OpMultiAssign__Group_6__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpMultiAssign__Group_6__0__Impl
	rule__OpMultiAssign__Group_6__1
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMultiAssign__Group_6__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpMultiAssignAccess().getGreaterThanSignKeyword_6_0()); }
	'>'
	{ after(grammarAccess.getOpMultiAssignAccess().getGreaterThanSignKeyword_6_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMultiAssign__Group_6__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpMultiAssign__Group_6__1__Impl
	rule__OpMultiAssign__Group_6__2
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMultiAssign__Group_6__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpMultiAssignAccess().getGreaterThanSignKeyword_6_1()); }
	('>')?
	{ after(grammarAccess.getOpMultiAssignAccess().getGreaterThanSignKeyword_6_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMultiAssign__Group_6__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpMultiAssign__Group_6__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__OpMultiAssign__Group_6__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpMultiAssignAccess().getGreaterThanSignEqualsSignKeyword_6_2()); }
	'>='
	{ after(grammarAccess.getOpMultiAssignAccess().getGreaterThanSignEqualsSignKeyword_6_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XOrExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOrExpression__Group__0__Impl
	rule__XOrExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOrExpressionAccess().getXAndExpressionParserRuleCall_0()); }
	ruleXAndExpression
	{ after(grammarAccess.getXOrExpressionAccess().getXAndExpressionParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOrExpression__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOrExpressionAccess().getGroup_1()); }
	(rule__XOrExpression__Group_1__0)*
	{ after(grammarAccess.getXOrExpressionAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XOrExpression__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOrExpression__Group_1__0__Impl
	rule__XOrExpression__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOrExpressionAccess().getGroup_1_0()); }
	(rule__XOrExpression__Group_1_0__0)
	{ after(grammarAccess.getXOrExpressionAccess().getGroup_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOrExpression__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOrExpressionAccess().getRightOperandAssignment_1_1()); }
	(rule__XOrExpression__RightOperandAssignment_1_1)
	{ after(grammarAccess.getXOrExpressionAccess().getRightOperandAssignment_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XOrExpression__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOrExpression__Group_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOrExpressionAccess().getGroup_1_0_0()); }
	(rule__XOrExpression__Group_1_0_0__0)
	{ after(grammarAccess.getXOrExpressionAccess().getGroup_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XOrExpression__Group_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOrExpression__Group_1_0_0__0__Impl
	rule__XOrExpression__Group_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__Group_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOrExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
	()
	{ after(grammarAccess.getXOrExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__Group_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOrExpression__Group_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__Group_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOrExpressionAccess().getFeatureAssignment_1_0_0_1()); }
	(rule__XOrExpression__FeatureAssignment_1_0_0_1)
	{ after(grammarAccess.getXOrExpressionAccess().getFeatureAssignment_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAndExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAndExpression__Group__0__Impl
	rule__XAndExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAndExpressionAccess().getXEqualityExpressionParserRuleCall_0()); }
	ruleXEqualityExpression
	{ after(grammarAccess.getXAndExpressionAccess().getXEqualityExpressionParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAndExpression__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAndExpressionAccess().getGroup_1()); }
	(rule__XAndExpression__Group_1__0)*
	{ after(grammarAccess.getXAndExpressionAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAndExpression__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAndExpression__Group_1__0__Impl
	rule__XAndExpression__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAndExpressionAccess().getGroup_1_0()); }
	(rule__XAndExpression__Group_1_0__0)
	{ after(grammarAccess.getXAndExpressionAccess().getGroup_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAndExpression__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAndExpressionAccess().getRightOperandAssignment_1_1()); }
	(rule__XAndExpression__RightOperandAssignment_1_1)
	{ after(grammarAccess.getXAndExpressionAccess().getRightOperandAssignment_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAndExpression__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAndExpression__Group_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAndExpressionAccess().getGroup_1_0_0()); }
	(rule__XAndExpression__Group_1_0_0__0)
	{ after(grammarAccess.getXAndExpressionAccess().getGroup_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAndExpression__Group_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAndExpression__Group_1_0_0__0__Impl
	rule__XAndExpression__Group_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__Group_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAndExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
	()
	{ after(grammarAccess.getXAndExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__Group_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAndExpression__Group_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__Group_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAndExpressionAccess().getFeatureAssignment_1_0_0_1()); }
	(rule__XAndExpression__FeatureAssignment_1_0_0_1)
	{ after(grammarAccess.getXAndExpressionAccess().getFeatureAssignment_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XEqualityExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XEqualityExpression__Group__0__Impl
	rule__XEqualityExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXEqualityExpressionAccess().getXRelationalExpressionParserRuleCall_0()); }
	ruleXRelationalExpression
	{ after(grammarAccess.getXEqualityExpressionAccess().getXRelationalExpressionParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XEqualityExpression__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXEqualityExpressionAccess().getGroup_1()); }
	(rule__XEqualityExpression__Group_1__0)*
	{ after(grammarAccess.getXEqualityExpressionAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XEqualityExpression__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XEqualityExpression__Group_1__0__Impl
	rule__XEqualityExpression__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXEqualityExpressionAccess().getGroup_1_0()); }
	(rule__XEqualityExpression__Group_1_0__0)
	{ after(grammarAccess.getXEqualityExpressionAccess().getGroup_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XEqualityExpression__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXEqualityExpressionAccess().getRightOperandAssignment_1_1()); }
	(rule__XEqualityExpression__RightOperandAssignment_1_1)
	{ after(grammarAccess.getXEqualityExpressionAccess().getRightOperandAssignment_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XEqualityExpression__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XEqualityExpression__Group_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXEqualityExpressionAccess().getGroup_1_0_0()); }
	(rule__XEqualityExpression__Group_1_0_0__0)
	{ after(grammarAccess.getXEqualityExpressionAccess().getGroup_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XEqualityExpression__Group_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XEqualityExpression__Group_1_0_0__0__Impl
	rule__XEqualityExpression__Group_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__Group_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXEqualityExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
	()
	{ after(grammarAccess.getXEqualityExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__Group_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XEqualityExpression__Group_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__Group_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXEqualityExpressionAccess().getFeatureAssignment_1_0_0_1()); }
	(rule__XEqualityExpression__FeatureAssignment_1_0_0_1)
	{ after(grammarAccess.getXEqualityExpressionAccess().getFeatureAssignment_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XRelationalExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group__0__Impl
	rule__XRelationalExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getXOtherOperatorExpressionParserRuleCall_0()); }
	ruleXOtherOperatorExpression
	{ after(grammarAccess.getXRelationalExpressionAccess().getXOtherOperatorExpressionParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getAlternatives_1()); }
	(rule__XRelationalExpression__Alternatives_1)*
	{ after(grammarAccess.getXRelationalExpressionAccess().getAlternatives_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XRelationalExpression__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group_1_0__0__Impl
	rule__XRelationalExpression__Group_1_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getGroup_1_0_0()); }
	(rule__XRelationalExpression__Group_1_0_0__0)
	{ after(grammarAccess.getXRelationalExpressionAccess().getGroup_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group_1_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getTypeAssignment_1_0_1()); }
	(rule__XRelationalExpression__TypeAssignment_1_0_1)
	{ after(grammarAccess.getXRelationalExpressionAccess().getTypeAssignment_1_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XRelationalExpression__Group_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group_1_0_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getGroup_1_0_0_0()); }
	(rule__XRelationalExpression__Group_1_0_0_0__0)
	{ after(grammarAccess.getXRelationalExpressionAccess().getGroup_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XRelationalExpression__Group_1_0_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group_1_0_0_0__0__Impl
	rule__XRelationalExpression__Group_1_0_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_0_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getXInstanceOfExpressionExpressionAction_1_0_0_0_0()); }
	()
	{ after(grammarAccess.getXRelationalExpressionAccess().getXInstanceOfExpressionExpressionAction_1_0_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_0_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group_1_0_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_0_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getInstanceofKeyword_1_0_0_0_1()); }
	'instanceof'
	{ after(grammarAccess.getXRelationalExpressionAccess().getInstanceofKeyword_1_0_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XRelationalExpression__Group_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group_1_1__0__Impl
	rule__XRelationalExpression__Group_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getGroup_1_1_0()); }
	(rule__XRelationalExpression__Group_1_1_0__0)
	{ after(grammarAccess.getXRelationalExpressionAccess().getGroup_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getRightOperandAssignment_1_1_1()); }
	(rule__XRelationalExpression__RightOperandAssignment_1_1_1)
	{ after(grammarAccess.getXRelationalExpressionAccess().getRightOperandAssignment_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XRelationalExpression__Group_1_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group_1_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getGroup_1_1_0_0()); }
	(rule__XRelationalExpression__Group_1_1_0_0__0)
	{ after(grammarAccess.getXRelationalExpressionAccess().getGroup_1_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XRelationalExpression__Group_1_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group_1_1_0_0__0__Impl
	rule__XRelationalExpression__Group_1_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getXBinaryOperationLeftOperandAction_1_1_0_0_0()); }
	()
	{ after(grammarAccess.getXRelationalExpressionAccess().getXBinaryOperationLeftOperandAction_1_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XRelationalExpression__Group_1_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__Group_1_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXRelationalExpressionAccess().getFeatureAssignment_1_1_0_0_1()); }
	(rule__XRelationalExpression__FeatureAssignment_1_1_0_0_1)
	{ after(grammarAccess.getXRelationalExpressionAccess().getFeatureAssignment_1_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__OpCompare__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpCompare__Group_1__0__Impl
	rule__OpCompare__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__OpCompare__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpCompareAccess().getLessThanSignKeyword_1_0()); }
	'<'
	{ after(grammarAccess.getOpCompareAccess().getLessThanSignKeyword_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpCompare__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpCompare__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__OpCompare__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpCompareAccess().getEqualsSignKeyword_1_1()); }
	'='
	{ after(grammarAccess.getOpCompareAccess().getEqualsSignKeyword_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XOtherOperatorExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOtherOperatorExpression__Group__0__Impl
	rule__XOtherOperatorExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOtherOperatorExpressionAccess().getXAdditiveExpressionParserRuleCall_0()); }
	ruleXAdditiveExpression
	{ after(grammarAccess.getXOtherOperatorExpressionAccess().getXAdditiveExpressionParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOtherOperatorExpression__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOtherOperatorExpressionAccess().getGroup_1()); }
	(rule__XOtherOperatorExpression__Group_1__0)*
	{ after(grammarAccess.getXOtherOperatorExpressionAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XOtherOperatorExpression__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOtherOperatorExpression__Group_1__0__Impl
	rule__XOtherOperatorExpression__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOtherOperatorExpressionAccess().getGroup_1_0()); }
	(rule__XOtherOperatorExpression__Group_1_0__0)
	{ after(grammarAccess.getXOtherOperatorExpressionAccess().getGroup_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOtherOperatorExpression__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOtherOperatorExpressionAccess().getRightOperandAssignment_1_1()); }
	(rule__XOtherOperatorExpression__RightOperandAssignment_1_1)
	{ after(grammarAccess.getXOtherOperatorExpressionAccess().getRightOperandAssignment_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XOtherOperatorExpression__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOtherOperatorExpression__Group_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOtherOperatorExpressionAccess().getGroup_1_0_0()); }
	(rule__XOtherOperatorExpression__Group_1_0_0__0)
	{ after(grammarAccess.getXOtherOperatorExpressionAccess().getGroup_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XOtherOperatorExpression__Group_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOtherOperatorExpression__Group_1_0_0__0__Impl
	rule__XOtherOperatorExpression__Group_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__Group_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOtherOperatorExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
	()
	{ after(grammarAccess.getXOtherOperatorExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__Group_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XOtherOperatorExpression__Group_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__Group_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXOtherOperatorExpressionAccess().getFeatureAssignment_1_0_0_1()); }
	(rule__XOtherOperatorExpression__FeatureAssignment_1_0_0_1)
	{ after(grammarAccess.getXOtherOperatorExpressionAccess().getFeatureAssignment_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__OpOther__Group_2__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_2__0__Impl
	rule__OpOther__Group_2__1
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_2__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getGreaterThanSignKeyword_2_0()); }
	'>'
	{ after(grammarAccess.getOpOtherAccess().getGreaterThanSignKeyword_2_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_2__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_2__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_2__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getFullStopFullStopKeyword_2_1()); }
	'..'
	{ after(grammarAccess.getOpOtherAccess().getFullStopFullStopKeyword_2_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__OpOther__Group_5__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_5__0__Impl
	rule__OpOther__Group_5__1
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_5__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getGreaterThanSignKeyword_5_0()); }
	'>'
	{ after(grammarAccess.getOpOtherAccess().getGreaterThanSignKeyword_5_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_5__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_5__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_5__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getAlternatives_5_1()); }
	(rule__OpOther__Alternatives_5_1)
	{ after(grammarAccess.getOpOtherAccess().getAlternatives_5_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__OpOther__Group_5_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_5_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_5_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getGroup_5_1_0_0()); }
	(rule__OpOther__Group_5_1_0_0__0)
	{ after(grammarAccess.getOpOtherAccess().getGroup_5_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__OpOther__Group_5_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_5_1_0_0__0__Impl
	rule__OpOther__Group_5_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_5_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getGreaterThanSignKeyword_5_1_0_0_0()); }
	'>'
	{ after(grammarAccess.getOpOtherAccess().getGreaterThanSignKeyword_5_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_5_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_5_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_5_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getGreaterThanSignKeyword_5_1_0_0_1()); }
	'>'
	{ after(grammarAccess.getOpOtherAccess().getGreaterThanSignKeyword_5_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__OpOther__Group_6__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_6__0__Impl
	rule__OpOther__Group_6__1
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_6__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getLessThanSignKeyword_6_0()); }
	'<'
	{ after(grammarAccess.getOpOtherAccess().getLessThanSignKeyword_6_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_6__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_6__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_6__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getAlternatives_6_1()); }
	(rule__OpOther__Alternatives_6_1)
	{ after(grammarAccess.getOpOtherAccess().getAlternatives_6_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__OpOther__Group_6_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_6_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_6_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getGroup_6_1_0_0()); }
	(rule__OpOther__Group_6_1_0_0__0)
	{ after(grammarAccess.getOpOtherAccess().getGroup_6_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__OpOther__Group_6_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_6_1_0_0__0__Impl
	rule__OpOther__Group_6_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_6_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getLessThanSignKeyword_6_1_0_0_0()); }
	'<'
	{ after(grammarAccess.getOpOtherAccess().getLessThanSignKeyword_6_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_6_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__OpOther__Group_6_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__OpOther__Group_6_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getOpOtherAccess().getLessThanSignKeyword_6_1_0_0_1()); }
	'<'
	{ after(grammarAccess.getOpOtherAccess().getLessThanSignKeyword_6_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAdditiveExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAdditiveExpression__Group__0__Impl
	rule__XAdditiveExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAdditiveExpressionAccess().getXMultiplicativeExpressionParserRuleCall_0()); }
	ruleXMultiplicativeExpression
	{ after(grammarAccess.getXAdditiveExpressionAccess().getXMultiplicativeExpressionParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAdditiveExpression__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAdditiveExpressionAccess().getGroup_1()); }
	(rule__XAdditiveExpression__Group_1__0)*
	{ after(grammarAccess.getXAdditiveExpressionAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAdditiveExpression__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAdditiveExpression__Group_1__0__Impl
	rule__XAdditiveExpression__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAdditiveExpressionAccess().getGroup_1_0()); }
	(rule__XAdditiveExpression__Group_1_0__0)
	{ after(grammarAccess.getXAdditiveExpressionAccess().getGroup_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAdditiveExpression__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAdditiveExpressionAccess().getRightOperandAssignment_1_1()); }
	(rule__XAdditiveExpression__RightOperandAssignment_1_1)
	{ after(grammarAccess.getXAdditiveExpressionAccess().getRightOperandAssignment_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAdditiveExpression__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAdditiveExpression__Group_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAdditiveExpressionAccess().getGroup_1_0_0()); }
	(rule__XAdditiveExpression__Group_1_0_0__0)
	{ after(grammarAccess.getXAdditiveExpressionAccess().getGroup_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAdditiveExpression__Group_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAdditiveExpression__Group_1_0_0__0__Impl
	rule__XAdditiveExpression__Group_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__Group_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAdditiveExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
	()
	{ after(grammarAccess.getXAdditiveExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__Group_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XAdditiveExpression__Group_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__Group_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXAdditiveExpressionAccess().getFeatureAssignment_1_0_0_1()); }
	(rule__XAdditiveExpression__FeatureAssignment_1_0_0_1)
	{ after(grammarAccess.getXAdditiveExpressionAccess().getFeatureAssignment_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMultiplicativeExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMultiplicativeExpression__Group__0__Impl
	rule__XMultiplicativeExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMultiplicativeExpressionAccess().getXUnaryOperationParserRuleCall_0()); }
	ruleXUnaryOperation
	{ after(grammarAccess.getXMultiplicativeExpressionAccess().getXUnaryOperationParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMultiplicativeExpression__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMultiplicativeExpressionAccess().getGroup_1()); }
	(rule__XMultiplicativeExpression__Group_1__0)*
	{ after(grammarAccess.getXMultiplicativeExpressionAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMultiplicativeExpression__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMultiplicativeExpression__Group_1__0__Impl
	rule__XMultiplicativeExpression__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMultiplicativeExpressionAccess().getGroup_1_0()); }
	(rule__XMultiplicativeExpression__Group_1_0__0)
	{ after(grammarAccess.getXMultiplicativeExpressionAccess().getGroup_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMultiplicativeExpression__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMultiplicativeExpressionAccess().getRightOperandAssignment_1_1()); }
	(rule__XMultiplicativeExpression__RightOperandAssignment_1_1)
	{ after(grammarAccess.getXMultiplicativeExpressionAccess().getRightOperandAssignment_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMultiplicativeExpression__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMultiplicativeExpression__Group_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMultiplicativeExpressionAccess().getGroup_1_0_0()); }
	(rule__XMultiplicativeExpression__Group_1_0_0__0)
	{ after(grammarAccess.getXMultiplicativeExpressionAccess().getGroup_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMultiplicativeExpression__Group_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMultiplicativeExpression__Group_1_0_0__0__Impl
	rule__XMultiplicativeExpression__Group_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__Group_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMultiplicativeExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
	()
	{ after(grammarAccess.getXMultiplicativeExpressionAccess().getXBinaryOperationLeftOperandAction_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__Group_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMultiplicativeExpression__Group_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__Group_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMultiplicativeExpressionAccess().getFeatureAssignment_1_0_0_1()); }
	(rule__XMultiplicativeExpression__FeatureAssignment_1_0_0_1)
	{ after(grammarAccess.getXMultiplicativeExpressionAccess().getFeatureAssignment_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XUnaryOperation__Group_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XUnaryOperation__Group_0__0__Impl
	rule__XUnaryOperation__Group_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XUnaryOperation__Group_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXUnaryOperationAccess().getXUnaryOperationAction_0_0()); }
	()
	{ after(grammarAccess.getXUnaryOperationAccess().getXUnaryOperationAction_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XUnaryOperation__Group_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XUnaryOperation__Group_0__1__Impl
	rule__XUnaryOperation__Group_0__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XUnaryOperation__Group_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXUnaryOperationAccess().getFeatureAssignment_0_1()); }
	(rule__XUnaryOperation__FeatureAssignment_0_1)
	{ after(grammarAccess.getXUnaryOperationAccess().getFeatureAssignment_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XUnaryOperation__Group_0__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XUnaryOperation__Group_0__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XUnaryOperation__Group_0__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXUnaryOperationAccess().getOperandAssignment_0_2()); }
	(rule__XUnaryOperation__OperandAssignment_0_2)
	{ after(grammarAccess.getXUnaryOperationAccess().getOperandAssignment_0_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XCastedExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCastedExpression__Group__0__Impl
	rule__XCastedExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XCastedExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCastedExpressionAccess().getXPostfixOperationParserRuleCall_0()); }
	ruleXPostfixOperation
	{ after(grammarAccess.getXCastedExpressionAccess().getXPostfixOperationParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCastedExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCastedExpression__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XCastedExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCastedExpressionAccess().getGroup_1()); }
	(rule__XCastedExpression__Group_1__0)*
	{ after(grammarAccess.getXCastedExpressionAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XCastedExpression__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCastedExpression__Group_1__0__Impl
	rule__XCastedExpression__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XCastedExpression__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCastedExpressionAccess().getGroup_1_0()); }
	(rule__XCastedExpression__Group_1_0__0)
	{ after(grammarAccess.getXCastedExpressionAccess().getGroup_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCastedExpression__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCastedExpression__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XCastedExpression__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCastedExpressionAccess().getTypeAssignment_1_1()); }
	(rule__XCastedExpression__TypeAssignment_1_1)
	{ after(grammarAccess.getXCastedExpressionAccess().getTypeAssignment_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XCastedExpression__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCastedExpression__Group_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XCastedExpression__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCastedExpressionAccess().getGroup_1_0_0()); }
	(rule__XCastedExpression__Group_1_0_0__0)
	{ after(grammarAccess.getXCastedExpressionAccess().getGroup_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XCastedExpression__Group_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCastedExpression__Group_1_0_0__0__Impl
	rule__XCastedExpression__Group_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XCastedExpression__Group_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCastedExpressionAccess().getXCastedExpressionTargetAction_1_0_0_0()); }
	()
	{ after(grammarAccess.getXCastedExpressionAccess().getXCastedExpressionTargetAction_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCastedExpression__Group_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCastedExpression__Group_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XCastedExpression__Group_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCastedExpressionAccess().getAsKeyword_1_0_0_1()); }
	'as'
	{ after(grammarAccess.getXCastedExpressionAccess().getAsKeyword_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XPostfixOperation__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XPostfixOperation__Group__0__Impl
	rule__XPostfixOperation__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XPostfixOperation__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXPostfixOperationAccess().getXMemberFeatureCallParserRuleCall_0()); }
	ruleXMemberFeatureCall
	{ after(grammarAccess.getXPostfixOperationAccess().getXMemberFeatureCallParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XPostfixOperation__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XPostfixOperation__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XPostfixOperation__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXPostfixOperationAccess().getGroup_1()); }
	(rule__XPostfixOperation__Group_1__0)?
	{ after(grammarAccess.getXPostfixOperationAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XPostfixOperation__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XPostfixOperation__Group_1__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XPostfixOperation__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXPostfixOperationAccess().getGroup_1_0()); }
	(rule__XPostfixOperation__Group_1_0__0)
	{ after(grammarAccess.getXPostfixOperationAccess().getGroup_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XPostfixOperation__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XPostfixOperation__Group_1_0__0__Impl
	rule__XPostfixOperation__Group_1_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XPostfixOperation__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXPostfixOperationAccess().getXPostfixOperationOperandAction_1_0_0()); }
	()
	{ after(grammarAccess.getXPostfixOperationAccess().getXPostfixOperationOperandAction_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XPostfixOperation__Group_1_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XPostfixOperation__Group_1_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XPostfixOperation__Group_1_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXPostfixOperationAccess().getFeatureAssignment_1_0_1()); }
	(rule__XPostfixOperation__FeatureAssignment_1_0_1)
	{ after(grammarAccess.getXPostfixOperationAccess().getFeatureAssignment_1_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group__0__Impl
	rule__XMemberFeatureCall__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getXPrimaryExpressionParserRuleCall_0()); }
	ruleXPrimaryExpression
	{ after(grammarAccess.getXMemberFeatureCallAccess().getXPrimaryExpressionParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getAlternatives_1()); }
	(rule__XMemberFeatureCall__Alternatives_1)*
	{ after(grammarAccess.getXMemberFeatureCallAccess().getAlternatives_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_0__0__Impl
	rule__XMemberFeatureCall__Group_1_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_0_0()); }
	(rule__XMemberFeatureCall__Group_1_0_0__0)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getValueAssignment_1_0_1()); }
	(rule__XMemberFeatureCall__ValueAssignment_1_0_1)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getValueAssignment_1_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_0_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_0_0_0()); }
	(rule__XMemberFeatureCall__Group_1_0_0_0__0)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group_1_0_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_0_0_0__0__Impl
	rule__XMemberFeatureCall__Group_1_0_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_0_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getXAssignmentAssignableAction_1_0_0_0_0()); }
	()
	{ after(grammarAccess.getXMemberFeatureCallAccess().getXAssignmentAssignableAction_1_0_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_0_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_0_0_0__1__Impl
	rule__XMemberFeatureCall__Group_1_0_0_0__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_0_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getAlternatives_1_0_0_0_1()); }
	(rule__XMemberFeatureCall__Alternatives_1_0_0_0_1)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getAlternatives_1_0_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_0_0_0__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_0_0_0__2__Impl
	rule__XMemberFeatureCall__Group_1_0_0_0__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_0_0_0__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getFeatureAssignment_1_0_0_0_2()); }
	(rule__XMemberFeatureCall__FeatureAssignment_1_0_0_0_2)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getFeatureAssignment_1_0_0_0_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_0_0_0__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_0_0_0__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_0_0_0__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getOpSingleAssignParserRuleCall_1_0_0_0_3()); }
	ruleOpSingleAssign
	{ after(grammarAccess.getXMemberFeatureCallAccess().getOpSingleAssignParserRuleCall_1_0_0_0_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1__0__Impl
	rule__XMemberFeatureCall__Group_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_0()); }
	(rule__XMemberFeatureCall__Group_1_1_0__0)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1__1__Impl
	rule__XMemberFeatureCall__Group_1_1__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_1()); }
	(rule__XMemberFeatureCall__Group_1_1_1__0)?
	{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1__2__Impl
	rule__XMemberFeatureCall__Group_1_1__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getFeatureAssignment_1_1_2()); }
	(rule__XMemberFeatureCall__FeatureAssignment_1_1_2)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getFeatureAssignment_1_1_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1__3__Impl
	rule__XMemberFeatureCall__Group_1_1__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_3()); }
	(rule__XMemberFeatureCall__Group_1_1_3__0)?
	{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1__4__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsAssignment_1_1_4()); }
	(rule__XMemberFeatureCall__MemberCallArgumentsAssignment_1_1_4)?
	{ after(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsAssignment_1_1_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group_1_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_0_0()); }
	(rule__XMemberFeatureCall__Group_1_1_0_0__0)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group_1_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_0_0__0__Impl
	rule__XMemberFeatureCall__Group_1_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getXMemberFeatureCallMemberCallTargetAction_1_1_0_0_0()); }
	()
	{ after(grammarAccess.getXMemberFeatureCallAccess().getXMemberFeatureCallMemberCallTargetAction_1_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getAlternatives_1_1_0_0_1()); }
	(rule__XMemberFeatureCall__Alternatives_1_1_0_0_1)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getAlternatives_1_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group_1_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_1__0__Impl
	rule__XMemberFeatureCall__Group_1_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getLessThanSignKeyword_1_1_1_0()); }
	'<'
	{ after(grammarAccess.getXMemberFeatureCallAccess().getLessThanSignKeyword_1_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_1__1__Impl
	rule__XMemberFeatureCall__Group_1_1_1__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getTypeArgumentsAssignment_1_1_1_1()); }
	(rule__XMemberFeatureCall__TypeArgumentsAssignment_1_1_1_1)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getTypeArgumentsAssignment_1_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_1__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_1__2__Impl
	rule__XMemberFeatureCall__Group_1_1_1__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_1__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_1_2()); }
	(rule__XMemberFeatureCall__Group_1_1_1_2__0)*
	{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_1_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_1__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_1__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_1__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getGreaterThanSignKeyword_1_1_1_3()); }
	'>'
	{ after(grammarAccess.getXMemberFeatureCallAccess().getGreaterThanSignKeyword_1_1_1_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group_1_1_1_2__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_1_2__0__Impl
	rule__XMemberFeatureCall__Group_1_1_1_2__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_1_2__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getCommaKeyword_1_1_1_2_0()); }
	','
	{ after(grammarAccess.getXMemberFeatureCallAccess().getCommaKeyword_1_1_1_2_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_1_2__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_1_2__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_1_2__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getTypeArgumentsAssignment_1_1_1_2_1()); }
	(rule__XMemberFeatureCall__TypeArgumentsAssignment_1_1_1_2_1)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getTypeArgumentsAssignment_1_1_1_2_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group_1_1_3__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_3__0__Impl
	rule__XMemberFeatureCall__Group_1_1_3__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_3__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getExplicitOperationCallAssignment_1_1_3_0()); }
	(rule__XMemberFeatureCall__ExplicitOperationCallAssignment_1_1_3_0)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getExplicitOperationCallAssignment_1_1_3_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_3__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_3__1__Impl
	rule__XMemberFeatureCall__Group_1_1_3__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_3__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getAlternatives_1_1_3_1()); }
	(rule__XMemberFeatureCall__Alternatives_1_1_3_1)?
	{ after(grammarAccess.getXMemberFeatureCallAccess().getAlternatives_1_1_3_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_3__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_3__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_3__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getRightParenthesisKeyword_1_1_3_2()); }
	')'
	{ after(grammarAccess.getXMemberFeatureCallAccess().getRightParenthesisKeyword_1_1_3_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group_1_1_3_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_3_1_1__0__Impl
	rule__XMemberFeatureCall__Group_1_1_3_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_3_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsAssignment_1_1_3_1_1_0()); }
	(rule__XMemberFeatureCall__MemberCallArgumentsAssignment_1_1_3_1_1_0)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsAssignment_1_1_3_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_3_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_3_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_3_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_3_1_1_1()); }
	(rule__XMemberFeatureCall__Group_1_1_3_1_1_1__0)*
	{ after(grammarAccess.getXMemberFeatureCallAccess().getGroup_1_1_3_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XMemberFeatureCall__Group_1_1_3_1_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_3_1_1_1__0__Impl
	rule__XMemberFeatureCall__Group_1_1_3_1_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_3_1_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getCommaKeyword_1_1_3_1_1_1_0()); }
	','
	{ after(grammarAccess.getXMemberFeatureCallAccess().getCommaKeyword_1_1_3_1_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_3_1_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XMemberFeatureCall__Group_1_1_3_1_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__Group_1_1_3_1_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsAssignment_1_1_3_1_1_1_1()); }
	(rule__XMemberFeatureCall__MemberCallArgumentsAssignment_1_1_3_1_1_1_1)
	{ after(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsAssignment_1_1_3_1_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSetLiteral__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSetLiteral__Group__0__Impl
	rule__XSetLiteral__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSetLiteralAccess().getXSetLiteralAction_0()); }
	()
	{ after(grammarAccess.getXSetLiteralAccess().getXSetLiteralAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSetLiteral__Group__1__Impl
	rule__XSetLiteral__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSetLiteralAccess().getNumberSignKeyword_1()); }
	'#'
	{ after(grammarAccess.getXSetLiteralAccess().getNumberSignKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSetLiteral__Group__2__Impl
	rule__XSetLiteral__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSetLiteralAccess().getLeftCurlyBracketKeyword_2()); }
	'{'
	{ after(grammarAccess.getXSetLiteralAccess().getLeftCurlyBracketKeyword_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSetLiteral__Group__3__Impl
	rule__XSetLiteral__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSetLiteralAccess().getGroup_3()); }
	(rule__XSetLiteral__Group_3__0)?
	{ after(grammarAccess.getXSetLiteralAccess().getGroup_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSetLiteral__Group__4__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSetLiteralAccess().getRightCurlyBracketKeyword_4()); }
	'}'
	{ after(grammarAccess.getXSetLiteralAccess().getRightCurlyBracketKeyword_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSetLiteral__Group_3__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSetLiteral__Group_3__0__Impl
	rule__XSetLiteral__Group_3__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group_3__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSetLiteralAccess().getElementsAssignment_3_0()); }
	(rule__XSetLiteral__ElementsAssignment_3_0)
	{ after(grammarAccess.getXSetLiteralAccess().getElementsAssignment_3_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group_3__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSetLiteral__Group_3__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group_3__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSetLiteralAccess().getGroup_3_1()); }
	(rule__XSetLiteral__Group_3_1__0)*
	{ after(grammarAccess.getXSetLiteralAccess().getGroup_3_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSetLiteral__Group_3_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSetLiteral__Group_3_1__0__Impl
	rule__XSetLiteral__Group_3_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group_3_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSetLiteralAccess().getCommaKeyword_3_1_0()); }
	','
	{ after(grammarAccess.getXSetLiteralAccess().getCommaKeyword_3_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group_3_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSetLiteral__Group_3_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__Group_3_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSetLiteralAccess().getElementsAssignment_3_1_1()); }
	(rule__XSetLiteral__ElementsAssignment_3_1_1)
	{ after(grammarAccess.getXSetLiteralAccess().getElementsAssignment_3_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XListLiteral__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XListLiteral__Group__0__Impl
	rule__XListLiteral__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXListLiteralAccess().getXListLiteralAction_0()); }
	()
	{ after(grammarAccess.getXListLiteralAccess().getXListLiteralAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XListLiteral__Group__1__Impl
	rule__XListLiteral__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXListLiteralAccess().getNumberSignKeyword_1()); }
	'#'
	{ after(grammarAccess.getXListLiteralAccess().getNumberSignKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XListLiteral__Group__2__Impl
	rule__XListLiteral__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXListLiteralAccess().getLeftSquareBracketKeyword_2()); }
	'['
	{ after(grammarAccess.getXListLiteralAccess().getLeftSquareBracketKeyword_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XListLiteral__Group__3__Impl
	rule__XListLiteral__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXListLiteralAccess().getGroup_3()); }
	(rule__XListLiteral__Group_3__0)?
	{ after(grammarAccess.getXListLiteralAccess().getGroup_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XListLiteral__Group__4__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXListLiteralAccess().getRightSquareBracketKeyword_4()); }
	']'
	{ after(grammarAccess.getXListLiteralAccess().getRightSquareBracketKeyword_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XListLiteral__Group_3__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XListLiteral__Group_3__0__Impl
	rule__XListLiteral__Group_3__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group_3__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXListLiteralAccess().getElementsAssignment_3_0()); }
	(rule__XListLiteral__ElementsAssignment_3_0)
	{ after(grammarAccess.getXListLiteralAccess().getElementsAssignment_3_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group_3__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XListLiteral__Group_3__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group_3__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXListLiteralAccess().getGroup_3_1()); }
	(rule__XListLiteral__Group_3_1__0)*
	{ after(grammarAccess.getXListLiteralAccess().getGroup_3_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XListLiteral__Group_3_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XListLiteral__Group_3_1__0__Impl
	rule__XListLiteral__Group_3_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group_3_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXListLiteralAccess().getCommaKeyword_3_1_0()); }
	','
	{ after(grammarAccess.getXListLiteralAccess().getCommaKeyword_3_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group_3_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XListLiteral__Group_3_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__Group_3_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXListLiteralAccess().getElementsAssignment_3_1_1()); }
	(rule__XListLiteral__ElementsAssignment_3_1_1)
	{ after(grammarAccess.getXListLiteralAccess().getElementsAssignment_3_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XClosure__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group__0__Impl
	rule__XClosure__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getGroup_0()); }
	(rule__XClosure__Group_0__0)
	{ after(grammarAccess.getXClosureAccess().getGroup_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group__1__Impl
	rule__XClosure__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getGroup_1()); }
	(rule__XClosure__Group_1__0)?
	{ after(grammarAccess.getXClosureAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group__2__Impl
	rule__XClosure__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getExpressionAssignment_2()); }
	(rule__XClosure__ExpressionAssignment_2)
	{ after(grammarAccess.getXClosureAccess().getExpressionAssignment_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getRightSquareBracketKeyword_3()); }
	']'
	{ after(grammarAccess.getXClosureAccess().getRightSquareBracketKeyword_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XClosure__Group_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getGroup_0_0()); }
	(rule__XClosure__Group_0_0__0)
	{ after(grammarAccess.getXClosureAccess().getGroup_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XClosure__Group_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group_0_0__0__Impl
	rule__XClosure__Group_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getXClosureAction_0_0_0()); }
	()
	{ after(grammarAccess.getXClosureAccess().getXClosureAction_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getLeftSquareBracketKeyword_0_0_1()); }
	'['
	{ after(grammarAccess.getXClosureAccess().getLeftSquareBracketKeyword_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XClosure__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group_1__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getGroup_1_0()); }
	(rule__XClosure__Group_1_0__0)
	{ after(grammarAccess.getXClosureAccess().getGroup_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XClosure__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group_1_0__0__Impl
	rule__XClosure__Group_1_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getGroup_1_0_0()); }
	(rule__XClosure__Group_1_0_0__0)?
	{ after(grammarAccess.getXClosureAccess().getGroup_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_1_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group_1_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_1_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getExplicitSyntaxAssignment_1_0_1()); }
	(rule__XClosure__ExplicitSyntaxAssignment_1_0_1)
	{ after(grammarAccess.getXClosureAccess().getExplicitSyntaxAssignment_1_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XClosure__Group_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group_1_0_0__0__Impl
	rule__XClosure__Group_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getDeclaredFormalParametersAssignment_1_0_0_0()); }
	(rule__XClosure__DeclaredFormalParametersAssignment_1_0_0_0)
	{ after(grammarAccess.getXClosureAccess().getDeclaredFormalParametersAssignment_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getGroup_1_0_0_1()); }
	(rule__XClosure__Group_1_0_0_1__0)*
	{ after(grammarAccess.getXClosureAccess().getGroup_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XClosure__Group_1_0_0_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group_1_0_0_1__0__Impl
	rule__XClosure__Group_1_0_0_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_1_0_0_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getCommaKeyword_1_0_0_1_0()); }
	','
	{ after(grammarAccess.getXClosureAccess().getCommaKeyword_1_0_0_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_1_0_0_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XClosure__Group_1_0_0_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__Group_1_0_0_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXClosureAccess().getDeclaredFormalParametersAssignment_1_0_0_1_1()); }
	(rule__XClosure__DeclaredFormalParametersAssignment_1_0_0_1_1)
	{ after(grammarAccess.getXClosureAccess().getDeclaredFormalParametersAssignment_1_0_0_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XExpressionInClosure__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XExpressionInClosure__Group__0__Impl
	rule__XExpressionInClosure__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XExpressionInClosure__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXExpressionInClosureAccess().getXBlockExpressionAction_0()); }
	()
	{ after(grammarAccess.getXExpressionInClosureAccess().getXBlockExpressionAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XExpressionInClosure__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XExpressionInClosure__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XExpressionInClosure__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXExpressionInClosureAccess().getGroup_1()); }
	(rule__XExpressionInClosure__Group_1__0)*
	{ after(grammarAccess.getXExpressionInClosureAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XExpressionInClosure__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XExpressionInClosure__Group_1__0__Impl
	rule__XExpressionInClosure__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XExpressionInClosure__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXExpressionInClosureAccess().getExpressionsAssignment_1_0()); }
	(rule__XExpressionInClosure__ExpressionsAssignment_1_0)
	{ after(grammarAccess.getXExpressionInClosureAccess().getExpressionsAssignment_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XExpressionInClosure__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XExpressionInClosure__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XExpressionInClosure__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXExpressionInClosureAccess().getSemicolonKeyword_1_1()); }
	(';')?
	{ after(grammarAccess.getXExpressionInClosureAccess().getSemicolonKeyword_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XShortClosure__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XShortClosure__Group__0__Impl
	rule__XShortClosure__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXShortClosureAccess().getGroup_0()); }
	(rule__XShortClosure__Group_0__0)
	{ after(grammarAccess.getXShortClosureAccess().getGroup_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XShortClosure__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXShortClosureAccess().getExpressionAssignment_1()); }
	(rule__XShortClosure__ExpressionAssignment_1)
	{ after(grammarAccess.getXShortClosureAccess().getExpressionAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XShortClosure__Group_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XShortClosure__Group_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXShortClosureAccess().getGroup_0_0()); }
	(rule__XShortClosure__Group_0_0__0)
	{ after(grammarAccess.getXShortClosureAccess().getGroup_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XShortClosure__Group_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XShortClosure__Group_0_0__0__Impl
	rule__XShortClosure__Group_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXShortClosureAccess().getXClosureAction_0_0_0()); }
	()
	{ after(grammarAccess.getXShortClosureAccess().getXClosureAction_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XShortClosure__Group_0_0__1__Impl
	rule__XShortClosure__Group_0_0__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXShortClosureAccess().getGroup_0_0_1()); }
	(rule__XShortClosure__Group_0_0_1__0)?
	{ after(grammarAccess.getXShortClosureAccess().getGroup_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0_0__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XShortClosure__Group_0_0__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0_0__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXShortClosureAccess().getExplicitSyntaxAssignment_0_0_2()); }
	(rule__XShortClosure__ExplicitSyntaxAssignment_0_0_2)
	{ after(grammarAccess.getXShortClosureAccess().getExplicitSyntaxAssignment_0_0_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XShortClosure__Group_0_0_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XShortClosure__Group_0_0_1__0__Impl
	rule__XShortClosure__Group_0_0_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0_0_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXShortClosureAccess().getDeclaredFormalParametersAssignment_0_0_1_0()); }
	(rule__XShortClosure__DeclaredFormalParametersAssignment_0_0_1_0)
	{ after(grammarAccess.getXShortClosureAccess().getDeclaredFormalParametersAssignment_0_0_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0_0_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XShortClosure__Group_0_0_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0_0_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXShortClosureAccess().getGroup_0_0_1_1()); }
	(rule__XShortClosure__Group_0_0_1_1__0)*
	{ after(grammarAccess.getXShortClosureAccess().getGroup_0_0_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XShortClosure__Group_0_0_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XShortClosure__Group_0_0_1_1__0__Impl
	rule__XShortClosure__Group_0_0_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0_0_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXShortClosureAccess().getCommaKeyword_0_0_1_1_0()); }
	','
	{ after(grammarAccess.getXShortClosureAccess().getCommaKeyword_0_0_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0_0_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XShortClosure__Group_0_0_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__Group_0_0_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXShortClosureAccess().getDeclaredFormalParametersAssignment_0_0_1_1_1()); }
	(rule__XShortClosure__DeclaredFormalParametersAssignment_0_0_1_1_1)
	{ after(grammarAccess.getXShortClosureAccess().getDeclaredFormalParametersAssignment_0_0_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XParenthesizedExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XParenthesizedExpression__Group__0__Impl
	rule__XParenthesizedExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XParenthesizedExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXParenthesizedExpressionAccess().getLeftParenthesisKeyword_0()); }
	'('
	{ after(grammarAccess.getXParenthesizedExpressionAccess().getLeftParenthesisKeyword_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XParenthesizedExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XParenthesizedExpression__Group__1__Impl
	rule__XParenthesizedExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XParenthesizedExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXParenthesizedExpressionAccess().getXExpressionParserRuleCall_1()); }
	ruleXExpression
	{ after(grammarAccess.getXParenthesizedExpressionAccess().getXExpressionParserRuleCall_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XParenthesizedExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XParenthesizedExpression__Group__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XParenthesizedExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXParenthesizedExpressionAccess().getRightParenthesisKeyword_2()); }
	')'
	{ after(grammarAccess.getXParenthesizedExpressionAccess().getRightParenthesisKeyword_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XIfExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XIfExpression__Group__0__Impl
	rule__XIfExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXIfExpressionAccess().getXIfExpressionAction_0()); }
	()
	{ after(grammarAccess.getXIfExpressionAccess().getXIfExpressionAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XIfExpression__Group__1__Impl
	rule__XIfExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXIfExpressionAccess().getIfKeyword_1()); }
	'if'
	{ after(grammarAccess.getXIfExpressionAccess().getIfKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XIfExpression__Group__2__Impl
	rule__XIfExpression__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXIfExpressionAccess().getLeftParenthesisKeyword_2()); }
	'('
	{ after(grammarAccess.getXIfExpressionAccess().getLeftParenthesisKeyword_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XIfExpression__Group__3__Impl
	rule__XIfExpression__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXIfExpressionAccess().getIfAssignment_3()); }
	(rule__XIfExpression__IfAssignment_3)
	{ after(grammarAccess.getXIfExpressionAccess().getIfAssignment_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XIfExpression__Group__4__Impl
	rule__XIfExpression__Group__5
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXIfExpressionAccess().getRightParenthesisKeyword_4()); }
	')'
	{ after(grammarAccess.getXIfExpressionAccess().getRightParenthesisKeyword_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__5
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XIfExpression__Group__5__Impl
	rule__XIfExpression__Group__6
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__5__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXIfExpressionAccess().getThenAssignment_5()); }
	(rule__XIfExpression__ThenAssignment_5)
	{ after(grammarAccess.getXIfExpressionAccess().getThenAssignment_5()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__6
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XIfExpression__Group__6__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group__6__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXIfExpressionAccess().getGroup_6()); }
	(rule__XIfExpression__Group_6__0)?
	{ after(grammarAccess.getXIfExpressionAccess().getGroup_6()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XIfExpression__Group_6__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XIfExpression__Group_6__0__Impl
	rule__XIfExpression__Group_6__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group_6__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXIfExpressionAccess().getElseKeyword_6_0()); }
	('else')
	{ after(grammarAccess.getXIfExpressionAccess().getElseKeyword_6_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group_6__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XIfExpression__Group_6__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__Group_6__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXIfExpressionAccess().getElseAssignment_6_1()); }
	(rule__XIfExpression__ElseAssignment_6_1)
	{ after(grammarAccess.getXIfExpressionAccess().getElseAssignment_6_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSwitchExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group__0__Impl
	rule__XSwitchExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getXSwitchExpressionAction_0()); }
	()
	{ after(grammarAccess.getXSwitchExpressionAccess().getXSwitchExpressionAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group__1__Impl
	rule__XSwitchExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getSwitchKeyword_1()); }
	'switch'
	{ after(grammarAccess.getXSwitchExpressionAccess().getSwitchKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group__2__Impl
	rule__XSwitchExpression__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getAlternatives_2()); }
	(rule__XSwitchExpression__Alternatives_2)
	{ after(grammarAccess.getXSwitchExpressionAccess().getAlternatives_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group__3__Impl
	rule__XSwitchExpression__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getLeftCurlyBracketKeyword_3()); }
	'{'
	{ after(grammarAccess.getXSwitchExpressionAccess().getLeftCurlyBracketKeyword_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group__4__Impl
	rule__XSwitchExpression__Group__5
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getCasesAssignment_4()); }
	(rule__XSwitchExpression__CasesAssignment_4)*
	{ after(grammarAccess.getXSwitchExpressionAccess().getCasesAssignment_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__5
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group__5__Impl
	rule__XSwitchExpression__Group__6
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__5__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getGroup_5()); }
	(rule__XSwitchExpression__Group_5__0)?
	{ after(grammarAccess.getXSwitchExpressionAccess().getGroup_5()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__6
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group__6__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group__6__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getRightCurlyBracketKeyword_6()); }
	'}'
	{ after(grammarAccess.getXSwitchExpressionAccess().getRightCurlyBracketKeyword_6()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSwitchExpression__Group_2_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_0__0__Impl
	rule__XSwitchExpression__Group_2_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getGroup_2_0_0()); }
	(rule__XSwitchExpression__Group_2_0_0__0)
	{ after(grammarAccess.getXSwitchExpressionAccess().getGroup_2_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_0__1__Impl
	rule__XSwitchExpression__Group_2_0__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getSwitchAssignment_2_0_1()); }
	(rule__XSwitchExpression__SwitchAssignment_2_0_1)
	{ after(grammarAccess.getXSwitchExpressionAccess().getSwitchAssignment_2_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_0__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_0__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_0__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getRightParenthesisKeyword_2_0_2()); }
	')'
	{ after(grammarAccess.getXSwitchExpressionAccess().getRightParenthesisKeyword_2_0_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSwitchExpression__Group_2_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_0_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getGroup_2_0_0_0()); }
	(rule__XSwitchExpression__Group_2_0_0_0__0)
	{ after(grammarAccess.getXSwitchExpressionAccess().getGroup_2_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSwitchExpression__Group_2_0_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_0_0_0__0__Impl
	rule__XSwitchExpression__Group_2_0_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_0_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getLeftParenthesisKeyword_2_0_0_0_0()); }
	'('
	{ after(grammarAccess.getXSwitchExpressionAccess().getLeftParenthesisKeyword_2_0_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_0_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_0_0_0__1__Impl
	rule__XSwitchExpression__Group_2_0_0_0__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_0_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getDeclaredParamAssignment_2_0_0_0_1()); }
	(rule__XSwitchExpression__DeclaredParamAssignment_2_0_0_0_1)
	{ after(grammarAccess.getXSwitchExpressionAccess().getDeclaredParamAssignment_2_0_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_0_0_0__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_0_0_0__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_0_0_0__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getColonKeyword_2_0_0_0_2()); }
	':'
	{ after(grammarAccess.getXSwitchExpressionAccess().getColonKeyword_2_0_0_0_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSwitchExpression__Group_2_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_1__0__Impl
	rule__XSwitchExpression__Group_2_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getGroup_2_1_0()); }
	(rule__XSwitchExpression__Group_2_1_0__0)?
	{ after(grammarAccess.getXSwitchExpressionAccess().getGroup_2_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getSwitchAssignment_2_1_1()); }
	(rule__XSwitchExpression__SwitchAssignment_2_1_1)
	{ after(grammarAccess.getXSwitchExpressionAccess().getSwitchAssignment_2_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSwitchExpression__Group_2_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_1_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getGroup_2_1_0_0()); }
	(rule__XSwitchExpression__Group_2_1_0_0__0)
	{ after(grammarAccess.getXSwitchExpressionAccess().getGroup_2_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSwitchExpression__Group_2_1_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_1_0_0__0__Impl
	rule__XSwitchExpression__Group_2_1_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_1_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getDeclaredParamAssignment_2_1_0_0_0()); }
	(rule__XSwitchExpression__DeclaredParamAssignment_2_1_0_0_0)
	{ after(grammarAccess.getXSwitchExpressionAccess().getDeclaredParamAssignment_2_1_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_1_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_2_1_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_2_1_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getColonKeyword_2_1_0_0_1()); }
	':'
	{ after(grammarAccess.getXSwitchExpressionAccess().getColonKeyword_2_1_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSwitchExpression__Group_5__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_5__0__Impl
	rule__XSwitchExpression__Group_5__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_5__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getDefaultKeyword_5_0()); }
	'default'
	{ after(grammarAccess.getXSwitchExpressionAccess().getDefaultKeyword_5_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_5__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_5__1__Impl
	rule__XSwitchExpression__Group_5__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_5__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getColonKeyword_5_1()); }
	':'
	{ after(grammarAccess.getXSwitchExpressionAccess().getColonKeyword_5_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_5__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSwitchExpression__Group_5__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__Group_5__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSwitchExpressionAccess().getDefaultAssignment_5_2()); }
	(rule__XSwitchExpression__DefaultAssignment_5_2)
	{ after(grammarAccess.getXSwitchExpressionAccess().getDefaultAssignment_5_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XCasePart__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCasePart__Group__0__Impl
	rule__XCasePart__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCasePartAccess().getXCasePartAction_0()); }
	()
	{ after(grammarAccess.getXCasePartAccess().getXCasePartAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCasePart__Group__1__Impl
	rule__XCasePart__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCasePartAccess().getTypeGuardAssignment_1()); }
	(rule__XCasePart__TypeGuardAssignment_1)?
	{ after(grammarAccess.getXCasePartAccess().getTypeGuardAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCasePart__Group__2__Impl
	rule__XCasePart__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCasePartAccess().getGroup_2()); }
	(rule__XCasePart__Group_2__0)?
	{ after(grammarAccess.getXCasePartAccess().getGroup_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCasePart__Group__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCasePartAccess().getAlternatives_3()); }
	(rule__XCasePart__Alternatives_3)
	{ after(grammarAccess.getXCasePartAccess().getAlternatives_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XCasePart__Group_2__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCasePart__Group_2__0__Impl
	rule__XCasePart__Group_2__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group_2__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCasePartAccess().getCaseKeyword_2_0()); }
	'case'
	{ after(grammarAccess.getXCasePartAccess().getCaseKeyword_2_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group_2__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCasePart__Group_2__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group_2__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCasePartAccess().getCaseAssignment_2_1()); }
	(rule__XCasePart__CaseAssignment_2_1)
	{ after(grammarAccess.getXCasePartAccess().getCaseAssignment_2_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XCasePart__Group_3_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCasePart__Group_3_0__0__Impl
	rule__XCasePart__Group_3_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group_3_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCasePartAccess().getColonKeyword_3_0_0()); }
	':'
	{ after(grammarAccess.getXCasePartAccess().getColonKeyword_3_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group_3_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCasePart__Group_3_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__Group_3_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCasePartAccess().getThenAssignment_3_0_1()); }
	(rule__XCasePart__ThenAssignment_3_0_1)
	{ after(grammarAccess.getXCasePartAccess().getThenAssignment_3_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XForLoopExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XForLoopExpression__Group__0__Impl
	rule__XForLoopExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXForLoopExpressionAccess().getGroup_0()); }
	(rule__XForLoopExpression__Group_0__0)
	{ after(grammarAccess.getXForLoopExpressionAccess().getGroup_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XForLoopExpression__Group__1__Impl
	rule__XForLoopExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXForLoopExpressionAccess().getForExpressionAssignment_1()); }
	(rule__XForLoopExpression__ForExpressionAssignment_1)
	{ after(grammarAccess.getXForLoopExpressionAccess().getForExpressionAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XForLoopExpression__Group__2__Impl
	rule__XForLoopExpression__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXForLoopExpressionAccess().getRightParenthesisKeyword_2()); }
	')'
	{ after(grammarAccess.getXForLoopExpressionAccess().getRightParenthesisKeyword_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XForLoopExpression__Group__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXForLoopExpressionAccess().getEachExpressionAssignment_3()); }
	(rule__XForLoopExpression__EachExpressionAssignment_3)
	{ after(grammarAccess.getXForLoopExpressionAccess().getEachExpressionAssignment_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XForLoopExpression__Group_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XForLoopExpression__Group_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXForLoopExpressionAccess().getGroup_0_0()); }
	(rule__XForLoopExpression__Group_0_0__0)
	{ after(grammarAccess.getXForLoopExpressionAccess().getGroup_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XForLoopExpression__Group_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XForLoopExpression__Group_0_0__0__Impl
	rule__XForLoopExpression__Group_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXForLoopExpressionAccess().getXForLoopExpressionAction_0_0_0()); }
	()
	{ after(grammarAccess.getXForLoopExpressionAccess().getXForLoopExpressionAction_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XForLoopExpression__Group_0_0__1__Impl
	rule__XForLoopExpression__Group_0_0__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXForLoopExpressionAccess().getForKeyword_0_0_1()); }
	'for'
	{ after(grammarAccess.getXForLoopExpressionAccess().getForKeyword_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group_0_0__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XForLoopExpression__Group_0_0__2__Impl
	rule__XForLoopExpression__Group_0_0__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group_0_0__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXForLoopExpressionAccess().getLeftParenthesisKeyword_0_0_2()); }
	'('
	{ after(grammarAccess.getXForLoopExpressionAccess().getLeftParenthesisKeyword_0_0_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group_0_0__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XForLoopExpression__Group_0_0__3__Impl
	rule__XForLoopExpression__Group_0_0__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group_0_0__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXForLoopExpressionAccess().getDeclaredParamAssignment_0_0_3()); }
	(rule__XForLoopExpression__DeclaredParamAssignment_0_0_3)
	{ after(grammarAccess.getXForLoopExpressionAccess().getDeclaredParamAssignment_0_0_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group_0_0__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XForLoopExpression__Group_0_0__4__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__Group_0_0__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXForLoopExpressionAccess().getColonKeyword_0_0_4()); }
	':'
	{ after(grammarAccess.getXForLoopExpressionAccess().getColonKeyword_0_0_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XBasicForLoopExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group__0__Impl
	rule__XBasicForLoopExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getXBasicForLoopExpressionAction_0()); }
	()
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getXBasicForLoopExpressionAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group__1__Impl
	rule__XBasicForLoopExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getForKeyword_1()); }
	'for'
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getForKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group__2__Impl
	rule__XBasicForLoopExpression__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getLeftParenthesisKeyword_2()); }
	'('
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getLeftParenthesisKeyword_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group__3__Impl
	rule__XBasicForLoopExpression__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getGroup_3()); }
	(rule__XBasicForLoopExpression__Group_3__0)?
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getGroup_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group__4__Impl
	rule__XBasicForLoopExpression__Group__5
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getSemicolonKeyword_4()); }
	';'
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getSemicolonKeyword_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__5
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group__5__Impl
	rule__XBasicForLoopExpression__Group__6
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__5__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getExpressionAssignment_5()); }
	(rule__XBasicForLoopExpression__ExpressionAssignment_5)?
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getExpressionAssignment_5()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__6
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group__6__Impl
	rule__XBasicForLoopExpression__Group__7
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__6__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getSemicolonKeyword_6()); }
	';'
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getSemicolonKeyword_6()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__7
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group__7__Impl
	rule__XBasicForLoopExpression__Group__8
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__7__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getGroup_7()); }
	(rule__XBasicForLoopExpression__Group_7__0)?
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getGroup_7()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__8
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group__8__Impl
	rule__XBasicForLoopExpression__Group__9
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__8__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getRightParenthesisKeyword_8()); }
	')'
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getRightParenthesisKeyword_8()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__9
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group__9__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group__9__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getEachExpressionAssignment_9()); }
	(rule__XBasicForLoopExpression__EachExpressionAssignment_9)
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getEachExpressionAssignment_9()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XBasicForLoopExpression__Group_3__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group_3__0__Impl
	rule__XBasicForLoopExpression__Group_3__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_3__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getInitExpressionsAssignment_3_0()); }
	(rule__XBasicForLoopExpression__InitExpressionsAssignment_3_0)
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getInitExpressionsAssignment_3_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_3__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group_3__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_3__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getGroup_3_1()); }
	(rule__XBasicForLoopExpression__Group_3_1__0)*
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getGroup_3_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XBasicForLoopExpression__Group_3_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group_3_1__0__Impl
	rule__XBasicForLoopExpression__Group_3_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_3_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getCommaKeyword_3_1_0()); }
	','
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getCommaKeyword_3_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_3_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group_3_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_3_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getInitExpressionsAssignment_3_1_1()); }
	(rule__XBasicForLoopExpression__InitExpressionsAssignment_3_1_1)
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getInitExpressionsAssignment_3_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XBasicForLoopExpression__Group_7__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group_7__0__Impl
	rule__XBasicForLoopExpression__Group_7__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_7__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getUpdateExpressionsAssignment_7_0()); }
	(rule__XBasicForLoopExpression__UpdateExpressionsAssignment_7_0)
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getUpdateExpressionsAssignment_7_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_7__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group_7__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_7__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getGroup_7_1()); }
	(rule__XBasicForLoopExpression__Group_7_1__0)*
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getGroup_7_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XBasicForLoopExpression__Group_7_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group_7_1__0__Impl
	rule__XBasicForLoopExpression__Group_7_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_7_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getCommaKeyword_7_1_0()); }
	','
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getCommaKeyword_7_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_7_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBasicForLoopExpression__Group_7_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__Group_7_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBasicForLoopExpressionAccess().getUpdateExpressionsAssignment_7_1_1()); }
	(rule__XBasicForLoopExpression__UpdateExpressionsAssignment_7_1_1)
	{ after(grammarAccess.getXBasicForLoopExpressionAccess().getUpdateExpressionsAssignment_7_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XWhileExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XWhileExpression__Group__0__Impl
	rule__XWhileExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXWhileExpressionAccess().getXWhileExpressionAction_0()); }
	()
	{ after(grammarAccess.getXWhileExpressionAccess().getXWhileExpressionAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XWhileExpression__Group__1__Impl
	rule__XWhileExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXWhileExpressionAccess().getWhileKeyword_1()); }
	'while'
	{ after(grammarAccess.getXWhileExpressionAccess().getWhileKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XWhileExpression__Group__2__Impl
	rule__XWhileExpression__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXWhileExpressionAccess().getLeftParenthesisKeyword_2()); }
	'('
	{ after(grammarAccess.getXWhileExpressionAccess().getLeftParenthesisKeyword_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XWhileExpression__Group__3__Impl
	rule__XWhileExpression__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXWhileExpressionAccess().getPredicateAssignment_3()); }
	(rule__XWhileExpression__PredicateAssignment_3)
	{ after(grammarAccess.getXWhileExpressionAccess().getPredicateAssignment_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__Group__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XWhileExpression__Group__4__Impl
	rule__XWhileExpression__Group__5
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__Group__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXWhileExpressionAccess().getRightParenthesisKeyword_4()); }
	')'
	{ after(grammarAccess.getXWhileExpressionAccess().getRightParenthesisKeyword_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__Group__5
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XWhileExpression__Group__5__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__Group__5__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXWhileExpressionAccess().getBodyAssignment_5()); }
	(rule__XWhileExpression__BodyAssignment_5)
	{ after(grammarAccess.getXWhileExpressionAccess().getBodyAssignment_5()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XDoWhileExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XDoWhileExpression__Group__0__Impl
	rule__XDoWhileExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXDoWhileExpressionAccess().getXDoWhileExpressionAction_0()); }
	()
	{ after(grammarAccess.getXDoWhileExpressionAccess().getXDoWhileExpressionAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XDoWhileExpression__Group__1__Impl
	rule__XDoWhileExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXDoWhileExpressionAccess().getDoKeyword_1()); }
	'do'
	{ after(grammarAccess.getXDoWhileExpressionAccess().getDoKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XDoWhileExpression__Group__2__Impl
	rule__XDoWhileExpression__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXDoWhileExpressionAccess().getBodyAssignment_2()); }
	(rule__XDoWhileExpression__BodyAssignment_2)
	{ after(grammarAccess.getXDoWhileExpressionAccess().getBodyAssignment_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XDoWhileExpression__Group__3__Impl
	rule__XDoWhileExpression__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXDoWhileExpressionAccess().getWhileKeyword_3()); }
	'while'
	{ after(grammarAccess.getXDoWhileExpressionAccess().getWhileKeyword_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XDoWhileExpression__Group__4__Impl
	rule__XDoWhileExpression__Group__5
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXDoWhileExpressionAccess().getLeftParenthesisKeyword_4()); }
	'('
	{ after(grammarAccess.getXDoWhileExpressionAccess().getLeftParenthesisKeyword_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__5
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XDoWhileExpression__Group__5__Impl
	rule__XDoWhileExpression__Group__6
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__5__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXDoWhileExpressionAccess().getPredicateAssignment_5()); }
	(rule__XDoWhileExpression__PredicateAssignment_5)
	{ after(grammarAccess.getXDoWhileExpressionAccess().getPredicateAssignment_5()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__6
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XDoWhileExpression__Group__6__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__Group__6__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXDoWhileExpressionAccess().getRightParenthesisKeyword_6()); }
	')'
	{ after(grammarAccess.getXDoWhileExpressionAccess().getRightParenthesisKeyword_6()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XBlockExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBlockExpression__Group__0__Impl
	rule__XBlockExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XBlockExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBlockExpressionAccess().getXBlockExpressionAction_0()); }
	()
	{ after(grammarAccess.getXBlockExpressionAccess().getXBlockExpressionAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBlockExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBlockExpression__Group__1__Impl
	rule__XBlockExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XBlockExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBlockExpressionAccess().getLeftCurlyBracketKeyword_1()); }
	'{'
	{ after(grammarAccess.getXBlockExpressionAccess().getLeftCurlyBracketKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBlockExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBlockExpression__Group__2__Impl
	rule__XBlockExpression__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XBlockExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBlockExpressionAccess().getGroup_2()); }
	(rule__XBlockExpression__Group_2__0)*
	{ after(grammarAccess.getXBlockExpressionAccess().getGroup_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBlockExpression__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBlockExpression__Group__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XBlockExpression__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBlockExpressionAccess().getRightCurlyBracketKeyword_3()); }
	'}'
	{ after(grammarAccess.getXBlockExpressionAccess().getRightCurlyBracketKeyword_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XBlockExpression__Group_2__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBlockExpression__Group_2__0__Impl
	rule__XBlockExpression__Group_2__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XBlockExpression__Group_2__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBlockExpressionAccess().getExpressionsAssignment_2_0()); }
	(rule__XBlockExpression__ExpressionsAssignment_2_0)
	{ after(grammarAccess.getXBlockExpressionAccess().getExpressionsAssignment_2_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBlockExpression__Group_2__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBlockExpression__Group_2__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XBlockExpression__Group_2__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBlockExpressionAccess().getSemicolonKeyword_2_1()); }
	(';')?
	{ after(grammarAccess.getXBlockExpressionAccess().getSemicolonKeyword_2_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XVariableDeclaration__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XVariableDeclaration__Group__0__Impl
	rule__XVariableDeclaration__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXVariableDeclarationAccess().getXVariableDeclarationAction_0()); }
	()
	{ after(grammarAccess.getXVariableDeclarationAccess().getXVariableDeclarationAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XVariableDeclaration__Group__1__Impl
	rule__XVariableDeclaration__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXVariableDeclarationAccess().getAlternatives_1()); }
	(rule__XVariableDeclaration__Alternatives_1)
	{ after(grammarAccess.getXVariableDeclarationAccess().getAlternatives_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XVariableDeclaration__Group__2__Impl
	rule__XVariableDeclaration__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXVariableDeclarationAccess().getAlternatives_2()); }
	(rule__XVariableDeclaration__Alternatives_2)
	{ after(grammarAccess.getXVariableDeclarationAccess().getAlternatives_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XVariableDeclaration__Group__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXVariableDeclarationAccess().getGroup_3()); }
	(rule__XVariableDeclaration__Group_3__0)?
	{ after(grammarAccess.getXVariableDeclarationAccess().getGroup_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XVariableDeclaration__Group_2_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XVariableDeclaration__Group_2_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group_2_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXVariableDeclarationAccess().getGroup_2_0_0()); }
	(rule__XVariableDeclaration__Group_2_0_0__0)
	{ after(grammarAccess.getXVariableDeclarationAccess().getGroup_2_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XVariableDeclaration__Group_2_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XVariableDeclaration__Group_2_0_0__0__Impl
	rule__XVariableDeclaration__Group_2_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group_2_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXVariableDeclarationAccess().getTypeAssignment_2_0_0_0()); }
	(rule__XVariableDeclaration__TypeAssignment_2_0_0_0)
	{ after(grammarAccess.getXVariableDeclarationAccess().getTypeAssignment_2_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group_2_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XVariableDeclaration__Group_2_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group_2_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXVariableDeclarationAccess().getNameAssignment_2_0_0_1()); }
	(rule__XVariableDeclaration__NameAssignment_2_0_0_1)
	{ after(grammarAccess.getXVariableDeclarationAccess().getNameAssignment_2_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XVariableDeclaration__Group_3__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XVariableDeclaration__Group_3__0__Impl
	rule__XVariableDeclaration__Group_3__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group_3__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXVariableDeclarationAccess().getEqualsSignKeyword_3_0()); }
	'='
	{ after(grammarAccess.getXVariableDeclarationAccess().getEqualsSignKeyword_3_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group_3__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XVariableDeclaration__Group_3__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__Group_3__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXVariableDeclarationAccess().getRightAssignment_3_1()); }
	(rule__XVariableDeclaration__RightAssignment_3_1)
	{ after(grammarAccess.getXVariableDeclarationAccess().getRightAssignment_3_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmFormalParameter__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmFormalParameter__Group__0__Impl
	rule__JvmFormalParameter__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmFormalParameter__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmFormalParameterAccess().getParameterTypeAssignment_0()); }
	(rule__JvmFormalParameter__ParameterTypeAssignment_0)?
	{ after(grammarAccess.getJvmFormalParameterAccess().getParameterTypeAssignment_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmFormalParameter__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmFormalParameter__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmFormalParameter__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmFormalParameterAccess().getNameAssignment_1()); }
	(rule__JvmFormalParameter__NameAssignment_1)
	{ after(grammarAccess.getJvmFormalParameterAccess().getNameAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__FullJvmFormalParameter__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__FullJvmFormalParameter__Group__0__Impl
	rule__FullJvmFormalParameter__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__FullJvmFormalParameter__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getFullJvmFormalParameterAccess().getParameterTypeAssignment_0()); }
	(rule__FullJvmFormalParameter__ParameterTypeAssignment_0)
	{ after(grammarAccess.getFullJvmFormalParameterAccess().getParameterTypeAssignment_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__FullJvmFormalParameter__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__FullJvmFormalParameter__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__FullJvmFormalParameter__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getFullJvmFormalParameterAccess().getNameAssignment_1()); }
	(rule__FullJvmFormalParameter__NameAssignment_1)
	{ after(grammarAccess.getFullJvmFormalParameterAccess().getNameAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XFeatureCall__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group__0__Impl
	rule__XFeatureCall__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getXFeatureCallAction_0()); }
	()
	{ after(grammarAccess.getXFeatureCallAccess().getXFeatureCallAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group__1__Impl
	rule__XFeatureCall__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getGroup_1()); }
	(rule__XFeatureCall__Group_1__0)?
	{ after(grammarAccess.getXFeatureCallAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group__2__Impl
	rule__XFeatureCall__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getFeatureAssignment_2()); }
	(rule__XFeatureCall__FeatureAssignment_2)
	{ after(grammarAccess.getXFeatureCallAccess().getFeatureAssignment_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group__3__Impl
	rule__XFeatureCall__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getGroup_3()); }
	(rule__XFeatureCall__Group_3__0)?
	{ after(grammarAccess.getXFeatureCallAccess().getGroup_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group__4__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsAssignment_4()); }
	(rule__XFeatureCall__FeatureCallArgumentsAssignment_4)?
	{ after(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsAssignment_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XFeatureCall__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_1__0__Impl
	rule__XFeatureCall__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getLessThanSignKeyword_1_0()); }
	'<'
	{ after(grammarAccess.getXFeatureCallAccess().getLessThanSignKeyword_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_1__1__Impl
	rule__XFeatureCall__Group_1__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getTypeArgumentsAssignment_1_1()); }
	(rule__XFeatureCall__TypeArgumentsAssignment_1_1)
	{ after(grammarAccess.getXFeatureCallAccess().getTypeArgumentsAssignment_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_1__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_1__2__Impl
	rule__XFeatureCall__Group_1__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_1__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getGroup_1_2()); }
	(rule__XFeatureCall__Group_1_2__0)*
	{ after(grammarAccess.getXFeatureCallAccess().getGroup_1_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_1__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_1__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_1__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getGreaterThanSignKeyword_1_3()); }
	'>'
	{ after(grammarAccess.getXFeatureCallAccess().getGreaterThanSignKeyword_1_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XFeatureCall__Group_1_2__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_1_2__0__Impl
	rule__XFeatureCall__Group_1_2__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_1_2__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getCommaKeyword_1_2_0()); }
	','
	{ after(grammarAccess.getXFeatureCallAccess().getCommaKeyword_1_2_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_1_2__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_1_2__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_1_2__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getTypeArgumentsAssignment_1_2_1()); }
	(rule__XFeatureCall__TypeArgumentsAssignment_1_2_1)
	{ after(grammarAccess.getXFeatureCallAccess().getTypeArgumentsAssignment_1_2_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XFeatureCall__Group_3__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_3__0__Impl
	rule__XFeatureCall__Group_3__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_3__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getExplicitOperationCallAssignment_3_0()); }
	(rule__XFeatureCall__ExplicitOperationCallAssignment_3_0)
	{ after(grammarAccess.getXFeatureCallAccess().getExplicitOperationCallAssignment_3_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_3__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_3__1__Impl
	rule__XFeatureCall__Group_3__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_3__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getAlternatives_3_1()); }
	(rule__XFeatureCall__Alternatives_3_1)?
	{ after(grammarAccess.getXFeatureCallAccess().getAlternatives_3_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_3__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_3__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_3__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getRightParenthesisKeyword_3_2()); }
	')'
	{ after(grammarAccess.getXFeatureCallAccess().getRightParenthesisKeyword_3_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XFeatureCall__Group_3_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_3_1_1__0__Impl
	rule__XFeatureCall__Group_3_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_3_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsAssignment_3_1_1_0()); }
	(rule__XFeatureCall__FeatureCallArgumentsAssignment_3_1_1_0)
	{ after(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsAssignment_3_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_3_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_3_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_3_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getGroup_3_1_1_1()); }
	(rule__XFeatureCall__Group_3_1_1_1__0)*
	{ after(grammarAccess.getXFeatureCallAccess().getGroup_3_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XFeatureCall__Group_3_1_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_3_1_1_1__0__Impl
	rule__XFeatureCall__Group_3_1_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_3_1_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getCommaKeyword_3_1_1_1_0()); }
	','
	{ after(grammarAccess.getXFeatureCallAccess().getCommaKeyword_3_1_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_3_1_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFeatureCall__Group_3_1_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__Group_3_1_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsAssignment_3_1_1_1_1()); }
	(rule__XFeatureCall__FeatureCallArgumentsAssignment_3_1_1_1_1)
	{ after(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsAssignment_3_1_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XConstructorCall__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group__0__Impl
	rule__XConstructorCall__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getXConstructorCallAction_0()); }
	()
	{ after(grammarAccess.getXConstructorCallAccess().getXConstructorCallAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group__1__Impl
	rule__XConstructorCall__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getNewKeyword_1()); }
	'new'
	{ after(grammarAccess.getXConstructorCallAccess().getNewKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group__2__Impl
	rule__XConstructorCall__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getConstructorAssignment_2()); }
	(rule__XConstructorCall__ConstructorAssignment_2)
	{ after(grammarAccess.getXConstructorCallAccess().getConstructorAssignment_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group__3__Impl
	rule__XConstructorCall__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getGroup_3()); }
	(rule__XConstructorCall__Group_3__0)?
	{ after(grammarAccess.getXConstructorCallAccess().getGroup_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group__4__Impl
	rule__XConstructorCall__Group__5
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getGroup_4()); }
	(rule__XConstructorCall__Group_4__0)?
	{ after(grammarAccess.getXConstructorCallAccess().getGroup_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group__5
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group__5__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group__5__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getArgumentsAssignment_5()); }
	(rule__XConstructorCall__ArgumentsAssignment_5)?
	{ after(grammarAccess.getXConstructorCallAccess().getArgumentsAssignment_5()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XConstructorCall__Group_3__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_3__0__Impl
	rule__XConstructorCall__Group_3__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_3__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getLessThanSignKeyword_3_0()); }
	('<')
	{ after(grammarAccess.getXConstructorCallAccess().getLessThanSignKeyword_3_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_3__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_3__1__Impl
	rule__XConstructorCall__Group_3__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_3__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getTypeArgumentsAssignment_3_1()); }
	(rule__XConstructorCall__TypeArgumentsAssignment_3_1)
	{ after(grammarAccess.getXConstructorCallAccess().getTypeArgumentsAssignment_3_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_3__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_3__2__Impl
	rule__XConstructorCall__Group_3__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_3__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getGroup_3_2()); }
	(rule__XConstructorCall__Group_3_2__0)*
	{ after(grammarAccess.getXConstructorCallAccess().getGroup_3_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_3__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_3__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_3__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getGreaterThanSignKeyword_3_3()); }
	'>'
	{ after(grammarAccess.getXConstructorCallAccess().getGreaterThanSignKeyword_3_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XConstructorCall__Group_3_2__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_3_2__0__Impl
	rule__XConstructorCall__Group_3_2__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_3_2__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getCommaKeyword_3_2_0()); }
	','
	{ after(grammarAccess.getXConstructorCallAccess().getCommaKeyword_3_2_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_3_2__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_3_2__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_3_2__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getTypeArgumentsAssignment_3_2_1()); }
	(rule__XConstructorCall__TypeArgumentsAssignment_3_2_1)
	{ after(grammarAccess.getXConstructorCallAccess().getTypeArgumentsAssignment_3_2_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XConstructorCall__Group_4__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_4__0__Impl
	rule__XConstructorCall__Group_4__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_4__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getExplicitConstructorCallAssignment_4_0()); }
	(rule__XConstructorCall__ExplicitConstructorCallAssignment_4_0)
	{ after(grammarAccess.getXConstructorCallAccess().getExplicitConstructorCallAssignment_4_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_4__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_4__1__Impl
	rule__XConstructorCall__Group_4__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_4__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getAlternatives_4_1()); }
	(rule__XConstructorCall__Alternatives_4_1)?
	{ after(grammarAccess.getXConstructorCallAccess().getAlternatives_4_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_4__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_4__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_4__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getRightParenthesisKeyword_4_2()); }
	')'
	{ after(grammarAccess.getXConstructorCallAccess().getRightParenthesisKeyword_4_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XConstructorCall__Group_4_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_4_1_1__0__Impl
	rule__XConstructorCall__Group_4_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_4_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getArgumentsAssignment_4_1_1_0()); }
	(rule__XConstructorCall__ArgumentsAssignment_4_1_1_0)
	{ after(grammarAccess.getXConstructorCallAccess().getArgumentsAssignment_4_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_4_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_4_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_4_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getGroup_4_1_1_1()); }
	(rule__XConstructorCall__Group_4_1_1_1__0)*
	{ after(grammarAccess.getXConstructorCallAccess().getGroup_4_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XConstructorCall__Group_4_1_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_4_1_1_1__0__Impl
	rule__XConstructorCall__Group_4_1_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_4_1_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getCommaKeyword_4_1_1_1_0()); }
	','
	{ after(grammarAccess.getXConstructorCallAccess().getCommaKeyword_4_1_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_4_1_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XConstructorCall__Group_4_1_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__Group_4_1_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXConstructorCallAccess().getArgumentsAssignment_4_1_1_1_1()); }
	(rule__XConstructorCall__ArgumentsAssignment_4_1_1_1_1)
	{ after(grammarAccess.getXConstructorCallAccess().getArgumentsAssignment_4_1_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XBooleanLiteral__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBooleanLiteral__Group__0__Impl
	rule__XBooleanLiteral__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XBooleanLiteral__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBooleanLiteralAccess().getXBooleanLiteralAction_0()); }
	()
	{ after(grammarAccess.getXBooleanLiteralAccess().getXBooleanLiteralAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBooleanLiteral__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XBooleanLiteral__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XBooleanLiteral__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXBooleanLiteralAccess().getAlternatives_1()); }
	(rule__XBooleanLiteral__Alternatives_1)
	{ after(grammarAccess.getXBooleanLiteralAccess().getAlternatives_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XNullLiteral__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XNullLiteral__Group__0__Impl
	rule__XNullLiteral__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XNullLiteral__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXNullLiteralAccess().getXNullLiteralAction_0()); }
	()
	{ after(grammarAccess.getXNullLiteralAccess().getXNullLiteralAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XNullLiteral__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XNullLiteral__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XNullLiteral__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXNullLiteralAccess().getNullKeyword_1()); }
	'null'
	{ after(grammarAccess.getXNullLiteralAccess().getNullKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XNumberLiteral__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XNumberLiteral__Group__0__Impl
	rule__XNumberLiteral__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XNumberLiteral__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXNumberLiteralAccess().getXNumberLiteralAction_0()); }
	()
	{ after(grammarAccess.getXNumberLiteralAccess().getXNumberLiteralAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XNumberLiteral__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XNumberLiteral__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XNumberLiteral__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXNumberLiteralAccess().getValueAssignment_1()); }
	(rule__XNumberLiteral__ValueAssignment_1)
	{ after(grammarAccess.getXNumberLiteralAccess().getValueAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XStringLiteral__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XStringLiteral__Group__0__Impl
	rule__XStringLiteral__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XStringLiteral__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXStringLiteralAccess().getXStringLiteralAction_0()); }
	()
	{ after(grammarAccess.getXStringLiteralAccess().getXStringLiteralAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XStringLiteral__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XStringLiteral__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XStringLiteral__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXStringLiteralAccess().getValueAssignment_1()); }
	(rule__XStringLiteral__ValueAssignment_1)
	{ after(grammarAccess.getXStringLiteralAccess().getValueAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XTypeLiteral__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTypeLiteral__Group__0__Impl
	rule__XTypeLiteral__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTypeLiteralAccess().getXTypeLiteralAction_0()); }
	()
	{ after(grammarAccess.getXTypeLiteralAccess().getXTypeLiteralAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTypeLiteral__Group__1__Impl
	rule__XTypeLiteral__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTypeLiteralAccess().getTypeofKeyword_1()); }
	'typeof'
	{ after(grammarAccess.getXTypeLiteralAccess().getTypeofKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTypeLiteral__Group__2__Impl
	rule__XTypeLiteral__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTypeLiteralAccess().getLeftParenthesisKeyword_2()); }
	'('
	{ after(grammarAccess.getXTypeLiteralAccess().getLeftParenthesisKeyword_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTypeLiteral__Group__3__Impl
	rule__XTypeLiteral__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTypeLiteralAccess().getTypeAssignment_3()); }
	(rule__XTypeLiteral__TypeAssignment_3)
	{ after(grammarAccess.getXTypeLiteralAccess().getTypeAssignment_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__Group__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTypeLiteral__Group__4__Impl
	rule__XTypeLiteral__Group__5
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__Group__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTypeLiteralAccess().getArrayDimensionsAssignment_4()); }
	(rule__XTypeLiteral__ArrayDimensionsAssignment_4)*
	{ after(grammarAccess.getXTypeLiteralAccess().getArrayDimensionsAssignment_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__Group__5
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTypeLiteral__Group__5__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__Group__5__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTypeLiteralAccess().getRightParenthesisKeyword_5()); }
	')'
	{ after(grammarAccess.getXTypeLiteralAccess().getRightParenthesisKeyword_5()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XThrowExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XThrowExpression__Group__0__Impl
	rule__XThrowExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XThrowExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXThrowExpressionAccess().getXThrowExpressionAction_0()); }
	()
	{ after(grammarAccess.getXThrowExpressionAccess().getXThrowExpressionAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XThrowExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XThrowExpression__Group__1__Impl
	rule__XThrowExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XThrowExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXThrowExpressionAccess().getThrowKeyword_1()); }
	'throw'
	{ after(grammarAccess.getXThrowExpressionAccess().getThrowKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XThrowExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XThrowExpression__Group__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XThrowExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXThrowExpressionAccess().getExpressionAssignment_2()); }
	(rule__XThrowExpression__ExpressionAssignment_2)
	{ after(grammarAccess.getXThrowExpressionAccess().getExpressionAssignment_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XReturnExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XReturnExpression__Group__0__Impl
	rule__XReturnExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XReturnExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXReturnExpressionAccess().getXReturnExpressionAction_0()); }
	()
	{ after(grammarAccess.getXReturnExpressionAccess().getXReturnExpressionAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XReturnExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XReturnExpression__Group__1__Impl
	rule__XReturnExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XReturnExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXReturnExpressionAccess().getReturnKeyword_1()); }
	'return'
	{ after(grammarAccess.getXReturnExpressionAccess().getReturnKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XReturnExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XReturnExpression__Group__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XReturnExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXReturnExpressionAccess().getExpressionAssignment_2()); }
	(rule__XReturnExpression__ExpressionAssignment_2)?
	{ after(grammarAccess.getXReturnExpressionAccess().getExpressionAssignment_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XTryCatchFinallyExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTryCatchFinallyExpression__Group__0__Impl
	rule__XTryCatchFinallyExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getXTryCatchFinallyExpressionAction_0()); }
	()
	{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getXTryCatchFinallyExpressionAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTryCatchFinallyExpression__Group__1__Impl
	rule__XTryCatchFinallyExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getTryKeyword_1()); }
	'try'
	{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getTryKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTryCatchFinallyExpression__Group__2__Impl
	rule__XTryCatchFinallyExpression__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getExpressionAssignment_2()); }
	(rule__XTryCatchFinallyExpression__ExpressionAssignment_2)
	{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getExpressionAssignment_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTryCatchFinallyExpression__Group__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getAlternatives_3()); }
	(rule__XTryCatchFinallyExpression__Alternatives_3)
	{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getAlternatives_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XTryCatchFinallyExpression__Group_3_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTryCatchFinallyExpression__Group_3_0__0__Impl
	rule__XTryCatchFinallyExpression__Group_3_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group_3_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	(
		{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getCatchClausesAssignment_3_0_0()); }
		(rule__XTryCatchFinallyExpression__CatchClausesAssignment_3_0_0)
		{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getCatchClausesAssignment_3_0_0()); }
	)
	(
		{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getCatchClausesAssignment_3_0_0()); }
		(rule__XTryCatchFinallyExpression__CatchClausesAssignment_3_0_0)*
		{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getCatchClausesAssignment_3_0_0()); }
	)
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group_3_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTryCatchFinallyExpression__Group_3_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group_3_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getGroup_3_0_1()); }
	(rule__XTryCatchFinallyExpression__Group_3_0_1__0)?
	{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getGroup_3_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XTryCatchFinallyExpression__Group_3_0_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTryCatchFinallyExpression__Group_3_0_1__0__Impl
	rule__XTryCatchFinallyExpression__Group_3_0_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group_3_0_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyKeyword_3_0_1_0()); }
	('finally')
	{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyKeyword_3_0_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group_3_0_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTryCatchFinallyExpression__Group_3_0_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group_3_0_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyExpressionAssignment_3_0_1_1()); }
	(rule__XTryCatchFinallyExpression__FinallyExpressionAssignment_3_0_1_1)
	{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyExpressionAssignment_3_0_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XTryCatchFinallyExpression__Group_3_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTryCatchFinallyExpression__Group_3_1__0__Impl
	rule__XTryCatchFinallyExpression__Group_3_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group_3_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyKeyword_3_1_0()); }
	'finally'
	{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyKeyword_3_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group_3_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XTryCatchFinallyExpression__Group_3_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__Group_3_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyExpressionAssignment_3_1_1()); }
	(rule__XTryCatchFinallyExpression__FinallyExpressionAssignment_3_1_1)
	{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyExpressionAssignment_3_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSynchronizedExpression__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSynchronizedExpression__Group__0__Impl
	rule__XSynchronizedExpression__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSynchronizedExpressionAccess().getGroup_0()); }
	(rule__XSynchronizedExpression__Group_0__0)
	{ after(grammarAccess.getXSynchronizedExpressionAccess().getGroup_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSynchronizedExpression__Group__1__Impl
	rule__XSynchronizedExpression__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSynchronizedExpressionAccess().getParamAssignment_1()); }
	(rule__XSynchronizedExpression__ParamAssignment_1)
	{ after(grammarAccess.getXSynchronizedExpressionAccess().getParamAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSynchronizedExpression__Group__2__Impl
	rule__XSynchronizedExpression__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSynchronizedExpressionAccess().getRightParenthesisKeyword_2()); }
	')'
	{ after(grammarAccess.getXSynchronizedExpressionAccess().getRightParenthesisKeyword_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSynchronizedExpression__Group__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSynchronizedExpressionAccess().getExpressionAssignment_3()); }
	(rule__XSynchronizedExpression__ExpressionAssignment_3)
	{ after(grammarAccess.getXSynchronizedExpressionAccess().getExpressionAssignment_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSynchronizedExpression__Group_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSynchronizedExpression__Group_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSynchronizedExpressionAccess().getGroup_0_0()); }
	(rule__XSynchronizedExpression__Group_0_0__0)
	{ after(grammarAccess.getXSynchronizedExpressionAccess().getGroup_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XSynchronizedExpression__Group_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSynchronizedExpression__Group_0_0__0__Impl
	rule__XSynchronizedExpression__Group_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSynchronizedExpressionAccess().getXSynchronizedExpressionAction_0_0_0()); }
	()
	{ after(grammarAccess.getXSynchronizedExpressionAccess().getXSynchronizedExpressionAction_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSynchronizedExpression__Group_0_0__1__Impl
	rule__XSynchronizedExpression__Group_0_0__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSynchronizedExpressionAccess().getSynchronizedKeyword_0_0_1()); }
	'synchronized'
	{ after(grammarAccess.getXSynchronizedExpressionAccess().getSynchronizedKeyword_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group_0_0__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XSynchronizedExpression__Group_0_0__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__Group_0_0__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXSynchronizedExpressionAccess().getLeftParenthesisKeyword_0_0_2()); }
	'('
	{ after(grammarAccess.getXSynchronizedExpressionAccess().getLeftParenthesisKeyword_0_0_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XCatchClause__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCatchClause__Group__0__Impl
	rule__XCatchClause__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XCatchClause__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCatchClauseAccess().getCatchKeyword_0()); }
	('catch')
	{ after(grammarAccess.getXCatchClauseAccess().getCatchKeyword_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCatchClause__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCatchClause__Group__1__Impl
	rule__XCatchClause__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XCatchClause__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCatchClauseAccess().getLeftParenthesisKeyword_1()); }
	'('
	{ after(grammarAccess.getXCatchClauseAccess().getLeftParenthesisKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCatchClause__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCatchClause__Group__2__Impl
	rule__XCatchClause__Group__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XCatchClause__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCatchClauseAccess().getDeclaredParamAssignment_2()); }
	(rule__XCatchClause__DeclaredParamAssignment_2)
	{ after(grammarAccess.getXCatchClauseAccess().getDeclaredParamAssignment_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCatchClause__Group__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCatchClause__Group__3__Impl
	rule__XCatchClause__Group__4
;
finally {
	restoreStackSize(stackSize);
}

rule__XCatchClause__Group__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCatchClauseAccess().getRightParenthesisKeyword_3()); }
	')'
	{ after(grammarAccess.getXCatchClauseAccess().getRightParenthesisKeyword_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCatchClause__Group__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XCatchClause__Group__4__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XCatchClause__Group__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXCatchClauseAccess().getExpressionAssignment_4()); }
	(rule__XCatchClause__ExpressionAssignment_4)
	{ after(grammarAccess.getXCatchClauseAccess().getExpressionAssignment_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__QualifiedName__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__QualifiedName__Group__0__Impl
	rule__QualifiedName__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedName__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getQualifiedNameAccess().getValidIDParserRuleCall_0()); }
	ruleValidID
	{ after(grammarAccess.getQualifiedNameAccess().getValidIDParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedName__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__QualifiedName__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedName__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getQualifiedNameAccess().getGroup_1()); }
	(rule__QualifiedName__Group_1__0)*
	{ after(grammarAccess.getQualifiedNameAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__QualifiedName__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__QualifiedName__Group_1__0__Impl
	rule__QualifiedName__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedName__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getQualifiedNameAccess().getFullStopKeyword_1_0()); }
	('.')
	{ after(grammarAccess.getQualifiedNameAccess().getFullStopKeyword_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedName__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__QualifiedName__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedName__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getQualifiedNameAccess().getValidIDParserRuleCall_1_1()); }
	ruleValidID
	{ after(grammarAccess.getQualifiedNameAccess().getValidIDParserRuleCall_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__Number__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__Number__Group_1__0__Impl
	rule__Number__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Number__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getNumberAccess().getAlternatives_1_0()); }
	(rule__Number__Alternatives_1_0)
	{ after(grammarAccess.getNumberAccess().getAlternatives_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__Number__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__Number__Group_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Number__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getNumberAccess().getGroup_1_1()); }
	(rule__Number__Group_1_1__0)?
	{ after(grammarAccess.getNumberAccess().getGroup_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__Number__Group_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__Number__Group_1_1__0__Impl
	rule__Number__Group_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__Number__Group_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getNumberAccess().getFullStopKeyword_1_1_0()); }
	'.'
	{ after(grammarAccess.getNumberAccess().getFullStopKeyword_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__Number__Group_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__Number__Group_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__Number__Group_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getNumberAccess().getAlternatives_1_1_1()); }
	(rule__Number__Alternatives_1_1_1)
	{ after(grammarAccess.getNumberAccess().getAlternatives_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmTypeReference__Group_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmTypeReference__Group_0__0__Impl
	rule__JvmTypeReference__Group_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmTypeReference__Group_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmTypeReferenceAccess().getJvmParameterizedTypeReferenceParserRuleCall_0_0()); }
	ruleJvmParameterizedTypeReference
	{ after(grammarAccess.getJvmTypeReferenceAccess().getJvmParameterizedTypeReferenceParserRuleCall_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmTypeReference__Group_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmTypeReference__Group_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmTypeReference__Group_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmTypeReferenceAccess().getGroup_0_1()); }
	(rule__JvmTypeReference__Group_0_1__0)*
	{ after(grammarAccess.getJvmTypeReferenceAccess().getGroup_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmTypeReference__Group_0_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmTypeReference__Group_0_1__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmTypeReference__Group_0_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmTypeReferenceAccess().getGroup_0_1_0()); }
	(rule__JvmTypeReference__Group_0_1_0__0)
	{ after(grammarAccess.getJvmTypeReferenceAccess().getGroup_0_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmTypeReference__Group_0_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmTypeReference__Group_0_1_0__0__Impl
	rule__JvmTypeReference__Group_0_1_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmTypeReference__Group_0_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmTypeReferenceAccess().getJvmGenericArrayTypeReferenceComponentTypeAction_0_1_0_0()); }
	()
	{ after(grammarAccess.getJvmTypeReferenceAccess().getJvmGenericArrayTypeReferenceComponentTypeAction_0_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmTypeReference__Group_0_1_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmTypeReference__Group_0_1_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmTypeReference__Group_0_1_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmTypeReferenceAccess().getArrayBracketsParserRuleCall_0_1_0_1()); }
	ruleArrayBrackets
	{ after(grammarAccess.getJvmTypeReferenceAccess().getArrayBracketsParserRuleCall_0_1_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__ArrayBrackets__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__ArrayBrackets__Group__0__Impl
	rule__ArrayBrackets__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__ArrayBrackets__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getArrayBracketsAccess().getLeftSquareBracketKeyword_0()); }
	'['
	{ after(grammarAccess.getArrayBracketsAccess().getLeftSquareBracketKeyword_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__ArrayBrackets__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__ArrayBrackets__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__ArrayBrackets__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getArrayBracketsAccess().getRightSquareBracketKeyword_1()); }
	']'
	{ after(grammarAccess.getArrayBracketsAccess().getRightSquareBracketKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XFunctionTypeRef__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFunctionTypeRef__Group__0__Impl
	rule__XFunctionTypeRef__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFunctionTypeRefAccess().getGroup_0()); }
	(rule__XFunctionTypeRef__Group_0__0)?
	{ after(grammarAccess.getXFunctionTypeRefAccess().getGroup_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFunctionTypeRef__Group__1__Impl
	rule__XFunctionTypeRef__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFunctionTypeRefAccess().getEqualsSignGreaterThanSignKeyword_1()); }
	'=>'
	{ after(grammarAccess.getXFunctionTypeRefAccess().getEqualsSignGreaterThanSignKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFunctionTypeRef__Group__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFunctionTypeRefAccess().getReturnTypeAssignment_2()); }
	(rule__XFunctionTypeRef__ReturnTypeAssignment_2)
	{ after(grammarAccess.getXFunctionTypeRefAccess().getReturnTypeAssignment_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XFunctionTypeRef__Group_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFunctionTypeRef__Group_0__0__Impl
	rule__XFunctionTypeRef__Group_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFunctionTypeRefAccess().getLeftParenthesisKeyword_0_0()); }
	'('
	{ after(grammarAccess.getXFunctionTypeRefAccess().getLeftParenthesisKeyword_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFunctionTypeRef__Group_0__1__Impl
	rule__XFunctionTypeRef__Group_0__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFunctionTypeRefAccess().getGroup_0_1()); }
	(rule__XFunctionTypeRef__Group_0_1__0)?
	{ after(grammarAccess.getXFunctionTypeRefAccess().getGroup_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group_0__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFunctionTypeRef__Group_0__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group_0__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFunctionTypeRefAccess().getRightParenthesisKeyword_0_2()); }
	')'
	{ after(grammarAccess.getXFunctionTypeRefAccess().getRightParenthesisKeyword_0_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XFunctionTypeRef__Group_0_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFunctionTypeRef__Group_0_1__0__Impl
	rule__XFunctionTypeRef__Group_0_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group_0_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFunctionTypeRefAccess().getParamTypesAssignment_0_1_0()); }
	(rule__XFunctionTypeRef__ParamTypesAssignment_0_1_0)
	{ after(grammarAccess.getXFunctionTypeRefAccess().getParamTypesAssignment_0_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group_0_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFunctionTypeRef__Group_0_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group_0_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFunctionTypeRefAccess().getGroup_0_1_1()); }
	(rule__XFunctionTypeRef__Group_0_1_1__0)*
	{ after(grammarAccess.getXFunctionTypeRefAccess().getGroup_0_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XFunctionTypeRef__Group_0_1_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFunctionTypeRef__Group_0_1_1__0__Impl
	rule__XFunctionTypeRef__Group_0_1_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group_0_1_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFunctionTypeRefAccess().getCommaKeyword_0_1_1_0()); }
	','
	{ after(grammarAccess.getXFunctionTypeRefAccess().getCommaKeyword_0_1_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group_0_1_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XFunctionTypeRef__Group_0_1_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__Group_0_1_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXFunctionTypeRefAccess().getParamTypesAssignment_0_1_1_1()); }
	(rule__XFunctionTypeRef__ParamTypesAssignment_0_1_1_1)
	{ after(grammarAccess.getXFunctionTypeRefAccess().getParamTypesAssignment_0_1_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmParameterizedTypeReference__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group__0__Impl
	rule__JvmParameterizedTypeReference__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeAssignment_0()); }
	(rule__JvmParameterizedTypeReference__TypeAssignment_0)
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeAssignment_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1()); }
	(rule__JvmParameterizedTypeReference__Group_1__0)?
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmParameterizedTypeReference__Group_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1__0__Impl
	rule__JvmParameterizedTypeReference__Group_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getLessThanSignKeyword_1_0()); }
	('<')
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getLessThanSignKeyword_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1__1__Impl
	rule__JvmParameterizedTypeReference__Group_1__2
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsAssignment_1_1()); }
	(rule__JvmParameterizedTypeReference__ArgumentsAssignment_1_1)
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsAssignment_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1__2__Impl
	rule__JvmParameterizedTypeReference__Group_1__3
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_2()); }
	(rule__JvmParameterizedTypeReference__Group_1_2__0)*
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1__3__Impl
	rule__JvmParameterizedTypeReference__Group_1__4
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGreaterThanSignKeyword_1_3()); }
	'>'
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGreaterThanSignKeyword_1_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1__4
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1__4__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1__4__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_4()); }
	(rule__JvmParameterizedTypeReference__Group_1_4__0)*
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_4()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmParameterizedTypeReference__Group_1_2__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_2__0__Impl
	rule__JvmParameterizedTypeReference__Group_1_2__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_2__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getCommaKeyword_1_2_0()); }
	','
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getCommaKeyword_1_2_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_2__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_2__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_2__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsAssignment_1_2_1()); }
	(rule__JvmParameterizedTypeReference__ArgumentsAssignment_1_2_1)
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsAssignment_1_2_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmParameterizedTypeReference__Group_1_4__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4__0__Impl
	rule__JvmParameterizedTypeReference__Group_1_4__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_4_0()); }
	(rule__JvmParameterizedTypeReference__Group_1_4_0__0)
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_4_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4__1__Impl
	rule__JvmParameterizedTypeReference__Group_1_4__2
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeAssignment_1_4_1()); }
	(rule__JvmParameterizedTypeReference__TypeAssignment_1_4_1)
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeAssignment_1_4_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_4_2()); }
	(rule__JvmParameterizedTypeReference__Group_1_4_2__0)?
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_4_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmParameterizedTypeReference__Group_1_4_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4_0__0__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_4_0_0()); }
	(rule__JvmParameterizedTypeReference__Group_1_4_0_0__0)
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_4_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmParameterizedTypeReference__Group_1_4_0_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4_0_0__0__Impl
	rule__JvmParameterizedTypeReference__Group_1_4_0_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_0_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getJvmInnerTypeReferenceOuterAction_1_4_0_0_0()); }
	()
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getJvmInnerTypeReferenceOuterAction_1_4_0_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_0_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4_0_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_0_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getFullStopKeyword_1_4_0_0_1()); }
	'.'
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getFullStopKeyword_1_4_0_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmParameterizedTypeReference__Group_1_4_2__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4_2__0__Impl
	rule__JvmParameterizedTypeReference__Group_1_4_2__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_2__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getLessThanSignKeyword_1_4_2_0()); }
	('<')
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getLessThanSignKeyword_1_4_2_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_2__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4_2__1__Impl
	rule__JvmParameterizedTypeReference__Group_1_4_2__2
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_2__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsAssignment_1_4_2_1()); }
	(rule__JvmParameterizedTypeReference__ArgumentsAssignment_1_4_2_1)
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsAssignment_1_4_2_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_2__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4_2__2__Impl
	rule__JvmParameterizedTypeReference__Group_1_4_2__3
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_2__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_4_2_2()); }
	(rule__JvmParameterizedTypeReference__Group_1_4_2_2__0)*
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGroup_1_4_2_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_2__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4_2__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_2__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGreaterThanSignKeyword_1_4_2_3()); }
	'>'
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getGreaterThanSignKeyword_1_4_2_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmParameterizedTypeReference__Group_1_4_2_2__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4_2_2__0__Impl
	rule__JvmParameterizedTypeReference__Group_1_4_2_2__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_2_2__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getCommaKeyword_1_4_2_2_0()); }
	','
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getCommaKeyword_1_4_2_2_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_2_2__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmParameterizedTypeReference__Group_1_4_2_2__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__Group_1_4_2_2__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsAssignment_1_4_2_2_1()); }
	(rule__JvmParameterizedTypeReference__ArgumentsAssignment_1_4_2_2_1)
	{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsAssignment_1_4_2_2_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmWildcardTypeReference__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmWildcardTypeReference__Group__0__Impl
	rule__JvmWildcardTypeReference__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getJvmWildcardTypeReferenceAction_0()); }
	()
	{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getJvmWildcardTypeReferenceAction_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmWildcardTypeReference__Group__1__Impl
	rule__JvmWildcardTypeReference__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getQuestionMarkKeyword_1()); }
	'?'
	{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getQuestionMarkKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmWildcardTypeReference__Group__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getAlternatives_2()); }
	(rule__JvmWildcardTypeReference__Alternatives_2)?
	{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getAlternatives_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmWildcardTypeReference__Group_2_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmWildcardTypeReference__Group_2_0__0__Impl
	rule__JvmWildcardTypeReference__Group_2_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Group_2_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsAssignment_2_0_0()); }
	(rule__JvmWildcardTypeReference__ConstraintsAssignment_2_0_0)
	{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsAssignment_2_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Group_2_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmWildcardTypeReference__Group_2_0__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Group_2_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsAssignment_2_0_1()); }
	(rule__JvmWildcardTypeReference__ConstraintsAssignment_2_0_1)*
	{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsAssignment_2_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmWildcardTypeReference__Group_2_1__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmWildcardTypeReference__Group_2_1__0__Impl
	rule__JvmWildcardTypeReference__Group_2_1__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Group_2_1__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsAssignment_2_1_0()); }
	(rule__JvmWildcardTypeReference__ConstraintsAssignment_2_1_0)
	{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsAssignment_2_1_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Group_2_1__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmWildcardTypeReference__Group_2_1__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__Group_2_1__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsAssignment_2_1_1()); }
	(rule__JvmWildcardTypeReference__ConstraintsAssignment_2_1_1)*
	{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsAssignment_2_1_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmUpperBound__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmUpperBound__Group__0__Impl
	rule__JvmUpperBound__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmUpperBound__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmUpperBoundAccess().getExtendsKeyword_0()); }
	'extends'
	{ after(grammarAccess.getJvmUpperBoundAccess().getExtendsKeyword_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmUpperBound__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmUpperBound__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmUpperBound__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmUpperBoundAccess().getTypeReferenceAssignment_1()); }
	(rule__JvmUpperBound__TypeReferenceAssignment_1)
	{ after(grammarAccess.getJvmUpperBoundAccess().getTypeReferenceAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmUpperBoundAnded__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmUpperBoundAnded__Group__0__Impl
	rule__JvmUpperBoundAnded__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmUpperBoundAnded__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmUpperBoundAndedAccess().getAmpersandKeyword_0()); }
	'&'
	{ after(grammarAccess.getJvmUpperBoundAndedAccess().getAmpersandKeyword_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmUpperBoundAnded__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmUpperBoundAnded__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmUpperBoundAnded__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmUpperBoundAndedAccess().getTypeReferenceAssignment_1()); }
	(rule__JvmUpperBoundAnded__TypeReferenceAssignment_1)
	{ after(grammarAccess.getJvmUpperBoundAndedAccess().getTypeReferenceAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmLowerBound__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmLowerBound__Group__0__Impl
	rule__JvmLowerBound__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmLowerBound__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmLowerBoundAccess().getSuperKeyword_0()); }
	'super'
	{ after(grammarAccess.getJvmLowerBoundAccess().getSuperKeyword_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmLowerBound__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmLowerBound__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmLowerBound__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmLowerBoundAccess().getTypeReferenceAssignment_1()); }
	(rule__JvmLowerBound__TypeReferenceAssignment_1)
	{ after(grammarAccess.getJvmLowerBoundAccess().getTypeReferenceAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__JvmLowerBoundAnded__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmLowerBoundAnded__Group__0__Impl
	rule__JvmLowerBoundAnded__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmLowerBoundAnded__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmLowerBoundAndedAccess().getAmpersandKeyword_0()); }
	'&'
	{ after(grammarAccess.getJvmLowerBoundAndedAccess().getAmpersandKeyword_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmLowerBoundAnded__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__JvmLowerBoundAnded__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmLowerBoundAnded__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getJvmLowerBoundAndedAccess().getTypeReferenceAssignment_1()); }
	(rule__JvmLowerBoundAnded__TypeReferenceAssignment_1)
	{ after(grammarAccess.getJvmLowerBoundAndedAccess().getTypeReferenceAssignment_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__QualifiedNameWithWildcard__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__QualifiedNameWithWildcard__Group__0__Impl
	rule__QualifiedNameWithWildcard__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedNameWithWildcard__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getQualifiedNameWithWildcardAccess().getQualifiedNameParserRuleCall_0()); }
	ruleQualifiedName
	{ after(grammarAccess.getQualifiedNameWithWildcardAccess().getQualifiedNameParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedNameWithWildcard__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__QualifiedNameWithWildcard__Group__1__Impl
	rule__QualifiedNameWithWildcard__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedNameWithWildcard__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getQualifiedNameWithWildcardAccess().getFullStopKeyword_1()); }
	'.'
	{ after(grammarAccess.getQualifiedNameWithWildcardAccess().getFullStopKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedNameWithWildcard__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__QualifiedNameWithWildcard__Group__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedNameWithWildcard__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getQualifiedNameWithWildcardAccess().getAsteriskKeyword_2()); }
	'*'
	{ after(grammarAccess.getQualifiedNameWithWildcardAccess().getAsteriskKeyword_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XImportDeclaration__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XImportDeclaration__Group__0__Impl
	rule__XImportDeclaration__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXImportDeclarationAccess().getImportKeyword_0()); }
	'import'
	{ after(grammarAccess.getXImportDeclarationAccess().getImportKeyword_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XImportDeclaration__Group__1__Impl
	rule__XImportDeclaration__Group__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXImportDeclarationAccess().getAlternatives_1()); }
	(rule__XImportDeclaration__Alternatives_1)
	{ after(grammarAccess.getXImportDeclarationAccess().getAlternatives_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XImportDeclaration__Group__2__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXImportDeclarationAccess().getSemicolonKeyword_2()); }
	(';')?
	{ after(grammarAccess.getXImportDeclarationAccess().getSemicolonKeyword_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XImportDeclaration__Group_1_0__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XImportDeclaration__Group_1_0__0__Impl
	rule__XImportDeclaration__Group_1_0__1
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group_1_0__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXImportDeclarationAccess().getStaticAssignment_1_0_0()); }
	(rule__XImportDeclaration__StaticAssignment_1_0_0)
	{ after(grammarAccess.getXImportDeclarationAccess().getStaticAssignment_1_0_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group_1_0__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XImportDeclaration__Group_1_0__1__Impl
	rule__XImportDeclaration__Group_1_0__2
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group_1_0__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXImportDeclarationAccess().getExtensionAssignment_1_0_1()); }
	(rule__XImportDeclaration__ExtensionAssignment_1_0_1)?
	{ after(grammarAccess.getXImportDeclarationAccess().getExtensionAssignment_1_0_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group_1_0__2
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XImportDeclaration__Group_1_0__2__Impl
	rule__XImportDeclaration__Group_1_0__3
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group_1_0__2__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXImportDeclarationAccess().getImportedTypeAssignment_1_0_2()); }
	(rule__XImportDeclaration__ImportedTypeAssignment_1_0_2)
	{ after(grammarAccess.getXImportDeclarationAccess().getImportedTypeAssignment_1_0_2()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group_1_0__3
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__XImportDeclaration__Group_1_0__3__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__Group_1_0__3__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getXImportDeclarationAccess().getAlternatives_1_0_3()); }
	(rule__XImportDeclaration__Alternatives_1_0_3)
	{ after(grammarAccess.getXImportDeclarationAccess().getAlternatives_1_0_3()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__QualifiedNameInStaticImport__Group__0
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__QualifiedNameInStaticImport__Group__0__Impl
	rule__QualifiedNameInStaticImport__Group__1
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedNameInStaticImport__Group__0__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getQualifiedNameInStaticImportAccess().getValidIDParserRuleCall_0()); }
	ruleValidID
	{ after(grammarAccess.getQualifiedNameInStaticImportAccess().getValidIDParserRuleCall_0()); }
)
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedNameInStaticImport__Group__1
	@init {
		int stackSize = keepStackSize();
	}
:
	rule__QualifiedNameInStaticImport__Group__1__Impl
;
finally {
	restoreStackSize(stackSize);
}

rule__QualifiedNameInStaticImport__Group__1__Impl
	@init {
		int stackSize = keepStackSize();
	}
:
(
	{ before(grammarAccess.getQualifiedNameInStaticImportAccess().getFullStopKeyword_1()); }
	'.'
	{ after(grammarAccess.getQualifiedNameInStaticImportAccess().getFullStopKeyword_1()); }
)
;
finally {
	restoreStackSize(stackSize);
}


rule__XAssignment__FeatureAssignment_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXAssignmentAccess().getFeatureJvmIdentifiableElementCrossReference_0_1_0()); }
		(
			{ before(grammarAccess.getXAssignmentAccess().getFeatureJvmIdentifiableElementFeatureCallIDParserRuleCall_0_1_0_1()); }
			ruleFeatureCallID
			{ after(grammarAccess.getXAssignmentAccess().getFeatureJvmIdentifiableElementFeatureCallIDParserRuleCall_0_1_0_1()); }
		)
		{ after(grammarAccess.getXAssignmentAccess().getFeatureJvmIdentifiableElementCrossReference_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__ValueAssignment_0_3
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXAssignmentAccess().getValueXAssignmentParserRuleCall_0_3_0()); }
		ruleXAssignment
		{ after(grammarAccess.getXAssignmentAccess().getValueXAssignmentParserRuleCall_0_3_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__FeatureAssignment_1_1_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXAssignmentAccess().getFeatureJvmIdentifiableElementCrossReference_1_1_0_0_1_0()); }
		(
			{ before(grammarAccess.getXAssignmentAccess().getFeatureJvmIdentifiableElementOpMultiAssignParserRuleCall_1_1_0_0_1_0_1()); }
			ruleOpMultiAssign
			{ after(grammarAccess.getXAssignmentAccess().getFeatureJvmIdentifiableElementOpMultiAssignParserRuleCall_1_1_0_0_1_0_1()); }
		)
		{ after(grammarAccess.getXAssignmentAccess().getFeatureJvmIdentifiableElementCrossReference_1_1_0_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAssignment__RightOperandAssignment_1_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXAssignmentAccess().getRightOperandXAssignmentParserRuleCall_1_1_1_0()); }
		ruleXAssignment
		{ after(grammarAccess.getXAssignmentAccess().getRightOperandXAssignmentParserRuleCall_1_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__FeatureAssignment_1_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXOrExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
		(
			{ before(grammarAccess.getXOrExpressionAccess().getFeatureJvmIdentifiableElementOpOrParserRuleCall_1_0_0_1_0_1()); }
			ruleOpOr
			{ after(grammarAccess.getXOrExpressionAccess().getFeatureJvmIdentifiableElementOpOrParserRuleCall_1_0_0_1_0_1()); }
		)
		{ after(grammarAccess.getXOrExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XOrExpression__RightOperandAssignment_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXOrExpressionAccess().getRightOperandXAndExpressionParserRuleCall_1_1_0()); }
		ruleXAndExpression
		{ after(grammarAccess.getXOrExpressionAccess().getRightOperandXAndExpressionParserRuleCall_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__FeatureAssignment_1_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXAndExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
		(
			{ before(grammarAccess.getXAndExpressionAccess().getFeatureJvmIdentifiableElementOpAndParserRuleCall_1_0_0_1_0_1()); }
			ruleOpAnd
			{ after(grammarAccess.getXAndExpressionAccess().getFeatureJvmIdentifiableElementOpAndParserRuleCall_1_0_0_1_0_1()); }
		)
		{ after(grammarAccess.getXAndExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAndExpression__RightOperandAssignment_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXAndExpressionAccess().getRightOperandXEqualityExpressionParserRuleCall_1_1_0()); }
		ruleXEqualityExpression
		{ after(grammarAccess.getXAndExpressionAccess().getRightOperandXEqualityExpressionParserRuleCall_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__FeatureAssignment_1_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXEqualityExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
		(
			{ before(grammarAccess.getXEqualityExpressionAccess().getFeatureJvmIdentifiableElementOpEqualityParserRuleCall_1_0_0_1_0_1()); }
			ruleOpEquality
			{ after(grammarAccess.getXEqualityExpressionAccess().getFeatureJvmIdentifiableElementOpEqualityParserRuleCall_1_0_0_1_0_1()); }
		)
		{ after(grammarAccess.getXEqualityExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XEqualityExpression__RightOperandAssignment_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXEqualityExpressionAccess().getRightOperandXRelationalExpressionParserRuleCall_1_1_0()); }
		ruleXRelationalExpression
		{ after(grammarAccess.getXEqualityExpressionAccess().getRightOperandXRelationalExpressionParserRuleCall_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__TypeAssignment_1_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXRelationalExpressionAccess().getTypeJvmTypeReferenceParserRuleCall_1_0_1_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getXRelationalExpressionAccess().getTypeJvmTypeReferenceParserRuleCall_1_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__FeatureAssignment_1_1_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXRelationalExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_1_0_0_1_0()); }
		(
			{ before(grammarAccess.getXRelationalExpressionAccess().getFeatureJvmIdentifiableElementOpCompareParserRuleCall_1_1_0_0_1_0_1()); }
			ruleOpCompare
			{ after(grammarAccess.getXRelationalExpressionAccess().getFeatureJvmIdentifiableElementOpCompareParserRuleCall_1_1_0_0_1_0_1()); }
		)
		{ after(grammarAccess.getXRelationalExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_1_0_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XRelationalExpression__RightOperandAssignment_1_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXRelationalExpressionAccess().getRightOperandXOtherOperatorExpressionParserRuleCall_1_1_1_0()); }
		ruleXOtherOperatorExpression
		{ after(grammarAccess.getXRelationalExpressionAccess().getRightOperandXOtherOperatorExpressionParserRuleCall_1_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__FeatureAssignment_1_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXOtherOperatorExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
		(
			{ before(grammarAccess.getXOtherOperatorExpressionAccess().getFeatureJvmIdentifiableElementOpOtherParserRuleCall_1_0_0_1_0_1()); }
			ruleOpOther
			{ after(grammarAccess.getXOtherOperatorExpressionAccess().getFeatureJvmIdentifiableElementOpOtherParserRuleCall_1_0_0_1_0_1()); }
		)
		{ after(grammarAccess.getXOtherOperatorExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XOtherOperatorExpression__RightOperandAssignment_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXOtherOperatorExpressionAccess().getRightOperandXAdditiveExpressionParserRuleCall_1_1_0()); }
		ruleXAdditiveExpression
		{ after(grammarAccess.getXOtherOperatorExpressionAccess().getRightOperandXAdditiveExpressionParserRuleCall_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__FeatureAssignment_1_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXAdditiveExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
		(
			{ before(grammarAccess.getXAdditiveExpressionAccess().getFeatureJvmIdentifiableElementOpAddParserRuleCall_1_0_0_1_0_1()); }
			ruleOpAdd
			{ after(grammarAccess.getXAdditiveExpressionAccess().getFeatureJvmIdentifiableElementOpAddParserRuleCall_1_0_0_1_0_1()); }
		)
		{ after(grammarAccess.getXAdditiveExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XAdditiveExpression__RightOperandAssignment_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXAdditiveExpressionAccess().getRightOperandXMultiplicativeExpressionParserRuleCall_1_1_0()); }
		ruleXMultiplicativeExpression
		{ after(grammarAccess.getXAdditiveExpressionAccess().getRightOperandXMultiplicativeExpressionParserRuleCall_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__FeatureAssignment_1_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMultiplicativeExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
		(
			{ before(grammarAccess.getXMultiplicativeExpressionAccess().getFeatureJvmIdentifiableElementOpMultiParserRuleCall_1_0_0_1_0_1()); }
			ruleOpMulti
			{ after(grammarAccess.getXMultiplicativeExpressionAccess().getFeatureJvmIdentifiableElementOpMultiParserRuleCall_1_0_0_1_0_1()); }
		)
		{ after(grammarAccess.getXMultiplicativeExpressionAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMultiplicativeExpression__RightOperandAssignment_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMultiplicativeExpressionAccess().getRightOperandXUnaryOperationParserRuleCall_1_1_0()); }
		ruleXUnaryOperation
		{ after(grammarAccess.getXMultiplicativeExpressionAccess().getRightOperandXUnaryOperationParserRuleCall_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XUnaryOperation__FeatureAssignment_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXUnaryOperationAccess().getFeatureJvmIdentifiableElementCrossReference_0_1_0()); }
		(
			{ before(grammarAccess.getXUnaryOperationAccess().getFeatureJvmIdentifiableElementOpUnaryParserRuleCall_0_1_0_1()); }
			ruleOpUnary
			{ after(grammarAccess.getXUnaryOperationAccess().getFeatureJvmIdentifiableElementOpUnaryParserRuleCall_0_1_0_1()); }
		)
		{ after(grammarAccess.getXUnaryOperationAccess().getFeatureJvmIdentifiableElementCrossReference_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XUnaryOperation__OperandAssignment_0_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXUnaryOperationAccess().getOperandXUnaryOperationParserRuleCall_0_2_0()); }
		ruleXUnaryOperation
		{ after(grammarAccess.getXUnaryOperationAccess().getOperandXUnaryOperationParserRuleCall_0_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCastedExpression__TypeAssignment_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXCastedExpressionAccess().getTypeJvmTypeReferenceParserRuleCall_1_1_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getXCastedExpressionAccess().getTypeJvmTypeReferenceParserRuleCall_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XPostfixOperation__FeatureAssignment_1_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXPostfixOperationAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_1_0()); }
		(
			{ before(grammarAccess.getXPostfixOperationAccess().getFeatureJvmIdentifiableElementOpPostfixParserRuleCall_1_0_1_0_1()); }
			ruleOpPostfix
			{ after(grammarAccess.getXPostfixOperationAccess().getFeatureJvmIdentifiableElementOpPostfixParserRuleCall_1_0_1_0_1()); }
		)
		{ after(grammarAccess.getXPostfixOperationAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__ExplicitStaticAssignment_1_0_0_0_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticColonColonKeyword_1_0_0_0_1_1_0()); }
		(
			{ before(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticColonColonKeyword_1_0_0_0_1_1_0()); }
			'::'
			{ after(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticColonColonKeyword_1_0_0_0_1_1_0()); }
		)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticColonColonKeyword_1_0_0_0_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__FeatureAssignment_1_0_0_0_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_0_2_0()); }
		(
			{ before(grammarAccess.getXMemberFeatureCallAccess().getFeatureJvmIdentifiableElementFeatureCallIDParserRuleCall_1_0_0_0_2_0_1()); }
			ruleFeatureCallID
			{ after(grammarAccess.getXMemberFeatureCallAccess().getFeatureJvmIdentifiableElementFeatureCallIDParserRuleCall_1_0_0_0_2_0_1()); }
		)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getFeatureJvmIdentifiableElementCrossReference_1_0_0_0_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__ValueAssignment_1_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getValueXAssignmentParserRuleCall_1_0_1_0()); }
		ruleXAssignment
		{ after(grammarAccess.getXMemberFeatureCallAccess().getValueXAssignmentParserRuleCall_1_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__NullSafeAssignment_1_1_0_0_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getNullSafeQuestionMarkFullStopKeyword_1_1_0_0_1_1_0()); }
		(
			{ before(grammarAccess.getXMemberFeatureCallAccess().getNullSafeQuestionMarkFullStopKeyword_1_1_0_0_1_1_0()); }
			'?.'
			{ after(grammarAccess.getXMemberFeatureCallAccess().getNullSafeQuestionMarkFullStopKeyword_1_1_0_0_1_1_0()); }
		)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getNullSafeQuestionMarkFullStopKeyword_1_1_0_0_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__ExplicitStaticAssignment_1_1_0_0_1_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticColonColonKeyword_1_1_0_0_1_2_0()); }
		(
			{ before(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticColonColonKeyword_1_1_0_0_1_2_0()); }
			'::'
			{ after(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticColonColonKeyword_1_1_0_0_1_2_0()); }
		)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getExplicitStaticColonColonKeyword_1_1_0_0_1_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__TypeArgumentsAssignment_1_1_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_1_1_0()); }
		ruleJvmArgumentTypeReference
		{ after(grammarAccess.getXMemberFeatureCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__TypeArgumentsAssignment_1_1_1_2_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_1_2_1_0()); }
		ruleJvmArgumentTypeReference
		{ after(grammarAccess.getXMemberFeatureCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_1_2_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__FeatureAssignment_1_1_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getFeatureJvmIdentifiableElementCrossReference_1_1_2_0()); }
		(
			{ before(grammarAccess.getXMemberFeatureCallAccess().getFeatureJvmIdentifiableElementIdOrSuperParserRuleCall_1_1_2_0_1()); }
			ruleIdOrSuper
			{ after(grammarAccess.getXMemberFeatureCallAccess().getFeatureJvmIdentifiableElementIdOrSuperParserRuleCall_1_1_2_0_1()); }
		)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getFeatureJvmIdentifiableElementCrossReference_1_1_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__ExplicitOperationCallAssignment_1_1_3_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getExplicitOperationCallLeftParenthesisKeyword_1_1_3_0_0()); }
		(
			{ before(grammarAccess.getXMemberFeatureCallAccess().getExplicitOperationCallLeftParenthesisKeyword_1_1_3_0_0()); }
			'('
			{ after(grammarAccess.getXMemberFeatureCallAccess().getExplicitOperationCallLeftParenthesisKeyword_1_1_3_0_0()); }
		)
		{ after(grammarAccess.getXMemberFeatureCallAccess().getExplicitOperationCallLeftParenthesisKeyword_1_1_3_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__MemberCallArgumentsAssignment_1_1_3_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsXShortClosureParserRuleCall_1_1_3_1_0_0()); }
		ruleXShortClosure
		{ after(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsXShortClosureParserRuleCall_1_1_3_1_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__MemberCallArgumentsAssignment_1_1_3_1_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsXExpressionParserRuleCall_1_1_3_1_1_0_0()); }
		ruleXExpression
		{ after(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsXExpressionParserRuleCall_1_1_3_1_1_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__MemberCallArgumentsAssignment_1_1_3_1_1_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsXExpressionParserRuleCall_1_1_3_1_1_1_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsXExpressionParserRuleCall_1_1_3_1_1_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XMemberFeatureCall__MemberCallArgumentsAssignment_1_1_4
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsXClosureParserRuleCall_1_1_4_0()); }
		ruleXClosure
		{ after(grammarAccess.getXMemberFeatureCallAccess().getMemberCallArgumentsXClosureParserRuleCall_1_1_4_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__ElementsAssignment_3_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXSetLiteralAccess().getElementsXExpressionParserRuleCall_3_0_0()); }
		ruleXExpression
		{ after(grammarAccess.getXSetLiteralAccess().getElementsXExpressionParserRuleCall_3_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSetLiteral__ElementsAssignment_3_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXSetLiteralAccess().getElementsXExpressionParserRuleCall_3_1_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXSetLiteralAccess().getElementsXExpressionParserRuleCall_3_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__ElementsAssignment_3_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXListLiteralAccess().getElementsXExpressionParserRuleCall_3_0_0()); }
		ruleXExpression
		{ after(grammarAccess.getXListLiteralAccess().getElementsXExpressionParserRuleCall_3_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XListLiteral__ElementsAssignment_3_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXListLiteralAccess().getElementsXExpressionParserRuleCall_3_1_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXListLiteralAccess().getElementsXExpressionParserRuleCall_3_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__DeclaredFormalParametersAssignment_1_0_0_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXClosureAccess().getDeclaredFormalParametersJvmFormalParameterParserRuleCall_1_0_0_0_0()); }
		ruleJvmFormalParameter
		{ after(grammarAccess.getXClosureAccess().getDeclaredFormalParametersJvmFormalParameterParserRuleCall_1_0_0_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__DeclaredFormalParametersAssignment_1_0_0_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXClosureAccess().getDeclaredFormalParametersJvmFormalParameterParserRuleCall_1_0_0_1_1_0()); }
		ruleJvmFormalParameter
		{ after(grammarAccess.getXClosureAccess().getDeclaredFormalParametersJvmFormalParameterParserRuleCall_1_0_0_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__ExplicitSyntaxAssignment_1_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXClosureAccess().getExplicitSyntaxVerticalLineKeyword_1_0_1_0()); }
		(
			{ before(grammarAccess.getXClosureAccess().getExplicitSyntaxVerticalLineKeyword_1_0_1_0()); }
			'|'
			{ after(grammarAccess.getXClosureAccess().getExplicitSyntaxVerticalLineKeyword_1_0_1_0()); }
		)
		{ after(grammarAccess.getXClosureAccess().getExplicitSyntaxVerticalLineKeyword_1_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XClosure__ExpressionAssignment_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXClosureAccess().getExpressionXExpressionInClosureParserRuleCall_2_0()); }
		ruleXExpressionInClosure
		{ after(grammarAccess.getXClosureAccess().getExpressionXExpressionInClosureParserRuleCall_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XExpressionInClosure__ExpressionsAssignment_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXExpressionInClosureAccess().getExpressionsXExpressionOrVarDeclarationParserRuleCall_1_0_0()); }
		ruleXExpressionOrVarDeclaration
		{ after(grammarAccess.getXExpressionInClosureAccess().getExpressionsXExpressionOrVarDeclarationParserRuleCall_1_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__DeclaredFormalParametersAssignment_0_0_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXShortClosureAccess().getDeclaredFormalParametersJvmFormalParameterParserRuleCall_0_0_1_0_0()); }
		ruleJvmFormalParameter
		{ after(grammarAccess.getXShortClosureAccess().getDeclaredFormalParametersJvmFormalParameterParserRuleCall_0_0_1_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__DeclaredFormalParametersAssignment_0_0_1_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXShortClosureAccess().getDeclaredFormalParametersJvmFormalParameterParserRuleCall_0_0_1_1_1_0()); }
		ruleJvmFormalParameter
		{ after(grammarAccess.getXShortClosureAccess().getDeclaredFormalParametersJvmFormalParameterParserRuleCall_0_0_1_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__ExplicitSyntaxAssignment_0_0_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXShortClosureAccess().getExplicitSyntaxVerticalLineKeyword_0_0_2_0()); }
		(
			{ before(grammarAccess.getXShortClosureAccess().getExplicitSyntaxVerticalLineKeyword_0_0_2_0()); }
			'|'
			{ after(grammarAccess.getXShortClosureAccess().getExplicitSyntaxVerticalLineKeyword_0_0_2_0()); }
		)
		{ after(grammarAccess.getXShortClosureAccess().getExplicitSyntaxVerticalLineKeyword_0_0_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XShortClosure__ExpressionAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXShortClosureAccess().getExpressionXExpressionParserRuleCall_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXShortClosureAccess().getExpressionXExpressionParserRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__IfAssignment_3
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXIfExpressionAccess().getIfXExpressionParserRuleCall_3_0()); }
		ruleXExpression
		{ after(grammarAccess.getXIfExpressionAccess().getIfXExpressionParserRuleCall_3_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__ThenAssignment_5
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXIfExpressionAccess().getThenXExpressionParserRuleCall_5_0()); }
		ruleXExpression
		{ after(grammarAccess.getXIfExpressionAccess().getThenXExpressionParserRuleCall_5_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XIfExpression__ElseAssignment_6_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXIfExpressionAccess().getElseXExpressionParserRuleCall_6_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXIfExpressionAccess().getElseXExpressionParserRuleCall_6_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__DeclaredParamAssignment_2_0_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXSwitchExpressionAccess().getDeclaredParamJvmFormalParameterParserRuleCall_2_0_0_0_1_0()); }
		ruleJvmFormalParameter
		{ after(grammarAccess.getXSwitchExpressionAccess().getDeclaredParamJvmFormalParameterParserRuleCall_2_0_0_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__SwitchAssignment_2_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXSwitchExpressionAccess().getSwitchXExpressionParserRuleCall_2_0_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXSwitchExpressionAccess().getSwitchXExpressionParserRuleCall_2_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__DeclaredParamAssignment_2_1_0_0_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXSwitchExpressionAccess().getDeclaredParamJvmFormalParameterParserRuleCall_2_1_0_0_0_0()); }
		ruleJvmFormalParameter
		{ after(grammarAccess.getXSwitchExpressionAccess().getDeclaredParamJvmFormalParameterParserRuleCall_2_1_0_0_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__SwitchAssignment_2_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXSwitchExpressionAccess().getSwitchXExpressionParserRuleCall_2_1_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXSwitchExpressionAccess().getSwitchXExpressionParserRuleCall_2_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__CasesAssignment_4
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXSwitchExpressionAccess().getCasesXCasePartParserRuleCall_4_0()); }
		ruleXCasePart
		{ after(grammarAccess.getXSwitchExpressionAccess().getCasesXCasePartParserRuleCall_4_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSwitchExpression__DefaultAssignment_5_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXSwitchExpressionAccess().getDefaultXExpressionParserRuleCall_5_2_0()); }
		ruleXExpression
		{ after(grammarAccess.getXSwitchExpressionAccess().getDefaultXExpressionParserRuleCall_5_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__TypeGuardAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXCasePartAccess().getTypeGuardJvmTypeReferenceParserRuleCall_1_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getXCasePartAccess().getTypeGuardJvmTypeReferenceParserRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__CaseAssignment_2_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXCasePartAccess().getCaseXExpressionParserRuleCall_2_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXCasePartAccess().getCaseXExpressionParserRuleCall_2_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__ThenAssignment_3_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXCasePartAccess().getThenXExpressionParserRuleCall_3_0_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXCasePartAccess().getThenXExpressionParserRuleCall_3_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCasePart__FallThroughAssignment_3_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXCasePartAccess().getFallThroughCommaKeyword_3_1_0()); }
		(
			{ before(grammarAccess.getXCasePartAccess().getFallThroughCommaKeyword_3_1_0()); }
			','
			{ after(grammarAccess.getXCasePartAccess().getFallThroughCommaKeyword_3_1_0()); }
		)
		{ after(grammarAccess.getXCasePartAccess().getFallThroughCommaKeyword_3_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__DeclaredParamAssignment_0_0_3
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXForLoopExpressionAccess().getDeclaredParamJvmFormalParameterParserRuleCall_0_0_3_0()); }
		ruleJvmFormalParameter
		{ after(grammarAccess.getXForLoopExpressionAccess().getDeclaredParamJvmFormalParameterParserRuleCall_0_0_3_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__ForExpressionAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXForLoopExpressionAccess().getForExpressionXExpressionParserRuleCall_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXForLoopExpressionAccess().getForExpressionXExpressionParserRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XForLoopExpression__EachExpressionAssignment_3
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXForLoopExpressionAccess().getEachExpressionXExpressionParserRuleCall_3_0()); }
		ruleXExpression
		{ after(grammarAccess.getXForLoopExpressionAccess().getEachExpressionXExpressionParserRuleCall_3_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__InitExpressionsAssignment_3_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXBasicForLoopExpressionAccess().getInitExpressionsXExpressionOrVarDeclarationParserRuleCall_3_0_0()); }
		ruleXExpressionOrVarDeclaration
		{ after(grammarAccess.getXBasicForLoopExpressionAccess().getInitExpressionsXExpressionOrVarDeclarationParserRuleCall_3_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__InitExpressionsAssignment_3_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXBasicForLoopExpressionAccess().getInitExpressionsXExpressionOrVarDeclarationParserRuleCall_3_1_1_0()); }
		ruleXExpressionOrVarDeclaration
		{ after(grammarAccess.getXBasicForLoopExpressionAccess().getInitExpressionsXExpressionOrVarDeclarationParserRuleCall_3_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__ExpressionAssignment_5
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXBasicForLoopExpressionAccess().getExpressionXExpressionParserRuleCall_5_0()); }
		ruleXExpression
		{ after(grammarAccess.getXBasicForLoopExpressionAccess().getExpressionXExpressionParserRuleCall_5_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__UpdateExpressionsAssignment_7_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXBasicForLoopExpressionAccess().getUpdateExpressionsXExpressionParserRuleCall_7_0_0()); }
		ruleXExpression
		{ after(grammarAccess.getXBasicForLoopExpressionAccess().getUpdateExpressionsXExpressionParserRuleCall_7_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__UpdateExpressionsAssignment_7_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXBasicForLoopExpressionAccess().getUpdateExpressionsXExpressionParserRuleCall_7_1_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXBasicForLoopExpressionAccess().getUpdateExpressionsXExpressionParserRuleCall_7_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBasicForLoopExpression__EachExpressionAssignment_9
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXBasicForLoopExpressionAccess().getEachExpressionXExpressionParserRuleCall_9_0()); }
		ruleXExpression
		{ after(grammarAccess.getXBasicForLoopExpressionAccess().getEachExpressionXExpressionParserRuleCall_9_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__PredicateAssignment_3
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXWhileExpressionAccess().getPredicateXExpressionParserRuleCall_3_0()); }
		ruleXExpression
		{ after(grammarAccess.getXWhileExpressionAccess().getPredicateXExpressionParserRuleCall_3_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XWhileExpression__BodyAssignment_5
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXWhileExpressionAccess().getBodyXExpressionParserRuleCall_5_0()); }
		ruleXExpression
		{ after(grammarAccess.getXWhileExpressionAccess().getBodyXExpressionParserRuleCall_5_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__BodyAssignment_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXDoWhileExpressionAccess().getBodyXExpressionParserRuleCall_2_0()); }
		ruleXExpression
		{ after(grammarAccess.getXDoWhileExpressionAccess().getBodyXExpressionParserRuleCall_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XDoWhileExpression__PredicateAssignment_5
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXDoWhileExpressionAccess().getPredicateXExpressionParserRuleCall_5_0()); }
		ruleXExpression
		{ after(grammarAccess.getXDoWhileExpressionAccess().getPredicateXExpressionParserRuleCall_5_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBlockExpression__ExpressionsAssignment_2_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXBlockExpressionAccess().getExpressionsXExpressionOrVarDeclarationParserRuleCall_2_0_0()); }
		ruleXExpressionOrVarDeclaration
		{ after(grammarAccess.getXBlockExpressionAccess().getExpressionsXExpressionOrVarDeclarationParserRuleCall_2_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__WriteableAssignment_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXVariableDeclarationAccess().getWriteableVarKeyword_1_0_0()); }
		(
			{ before(grammarAccess.getXVariableDeclarationAccess().getWriteableVarKeyword_1_0_0()); }
			'var'
			{ after(grammarAccess.getXVariableDeclarationAccess().getWriteableVarKeyword_1_0_0()); }
		)
		{ after(grammarAccess.getXVariableDeclarationAccess().getWriteableVarKeyword_1_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__TypeAssignment_2_0_0_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXVariableDeclarationAccess().getTypeJvmTypeReferenceParserRuleCall_2_0_0_0_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getXVariableDeclarationAccess().getTypeJvmTypeReferenceParserRuleCall_2_0_0_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__NameAssignment_2_0_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXVariableDeclarationAccess().getNameValidIDParserRuleCall_2_0_0_1_0()); }
		ruleValidID
		{ after(grammarAccess.getXVariableDeclarationAccess().getNameValidIDParserRuleCall_2_0_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__NameAssignment_2_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXVariableDeclarationAccess().getNameValidIDParserRuleCall_2_1_0()); }
		ruleValidID
		{ after(grammarAccess.getXVariableDeclarationAccess().getNameValidIDParserRuleCall_2_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XVariableDeclaration__RightAssignment_3_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXVariableDeclarationAccess().getRightXExpressionParserRuleCall_3_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXVariableDeclarationAccess().getRightXExpressionParserRuleCall_3_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmFormalParameter__ParameterTypeAssignment_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmFormalParameterAccess().getParameterTypeJvmTypeReferenceParserRuleCall_0_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getJvmFormalParameterAccess().getParameterTypeJvmTypeReferenceParserRuleCall_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmFormalParameter__NameAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmFormalParameterAccess().getNameValidIDParserRuleCall_1_0()); }
		ruleValidID
		{ after(grammarAccess.getJvmFormalParameterAccess().getNameValidIDParserRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__FullJvmFormalParameter__ParameterTypeAssignment_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getFullJvmFormalParameterAccess().getParameterTypeJvmTypeReferenceParserRuleCall_0_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getFullJvmFormalParameterAccess().getParameterTypeJvmTypeReferenceParserRuleCall_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__FullJvmFormalParameter__NameAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getFullJvmFormalParameterAccess().getNameValidIDParserRuleCall_1_0()); }
		ruleValidID
		{ after(grammarAccess.getFullJvmFormalParameterAccess().getNameValidIDParserRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__TypeArgumentsAssignment_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFeatureCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_0()); }
		ruleJvmArgumentTypeReference
		{ after(grammarAccess.getXFeatureCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__TypeArgumentsAssignment_1_2_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFeatureCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_2_1_0()); }
		ruleJvmArgumentTypeReference
		{ after(grammarAccess.getXFeatureCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_1_2_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__FeatureAssignment_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFeatureCallAccess().getFeatureJvmIdentifiableElementCrossReference_2_0()); }
		(
			{ before(grammarAccess.getXFeatureCallAccess().getFeatureJvmIdentifiableElementIdOrSuperParserRuleCall_2_0_1()); }
			ruleIdOrSuper
			{ after(grammarAccess.getXFeatureCallAccess().getFeatureJvmIdentifiableElementIdOrSuperParserRuleCall_2_0_1()); }
		)
		{ after(grammarAccess.getXFeatureCallAccess().getFeatureJvmIdentifiableElementCrossReference_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__ExplicitOperationCallAssignment_3_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFeatureCallAccess().getExplicitOperationCallLeftParenthesisKeyword_3_0_0()); }
		(
			{ before(grammarAccess.getXFeatureCallAccess().getExplicitOperationCallLeftParenthesisKeyword_3_0_0()); }
			'('
			{ after(grammarAccess.getXFeatureCallAccess().getExplicitOperationCallLeftParenthesisKeyword_3_0_0()); }
		)
		{ after(grammarAccess.getXFeatureCallAccess().getExplicitOperationCallLeftParenthesisKeyword_3_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__FeatureCallArgumentsAssignment_3_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsXShortClosureParserRuleCall_3_1_0_0()); }
		ruleXShortClosure
		{ after(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsXShortClosureParserRuleCall_3_1_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__FeatureCallArgumentsAssignment_3_1_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsXExpressionParserRuleCall_3_1_1_0_0()); }
		ruleXExpression
		{ after(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsXExpressionParserRuleCall_3_1_1_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__FeatureCallArgumentsAssignment_3_1_1_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsXExpressionParserRuleCall_3_1_1_1_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsXExpressionParserRuleCall_3_1_1_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFeatureCall__FeatureCallArgumentsAssignment_4
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsXClosureParserRuleCall_4_0()); }
		ruleXClosure
		{ after(grammarAccess.getXFeatureCallAccess().getFeatureCallArgumentsXClosureParserRuleCall_4_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__ConstructorAssignment_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXConstructorCallAccess().getConstructorJvmConstructorCrossReference_2_0()); }
		(
			{ before(grammarAccess.getXConstructorCallAccess().getConstructorJvmConstructorQualifiedNameParserRuleCall_2_0_1()); }
			ruleQualifiedName
			{ after(grammarAccess.getXConstructorCallAccess().getConstructorJvmConstructorQualifiedNameParserRuleCall_2_0_1()); }
		)
		{ after(grammarAccess.getXConstructorCallAccess().getConstructorJvmConstructorCrossReference_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__TypeArgumentsAssignment_3_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXConstructorCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_3_1_0()); }
		ruleJvmArgumentTypeReference
		{ after(grammarAccess.getXConstructorCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_3_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__TypeArgumentsAssignment_3_2_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXConstructorCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_3_2_1_0()); }
		ruleJvmArgumentTypeReference
		{ after(grammarAccess.getXConstructorCallAccess().getTypeArgumentsJvmArgumentTypeReferenceParserRuleCall_3_2_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__ExplicitConstructorCallAssignment_4_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXConstructorCallAccess().getExplicitConstructorCallLeftParenthesisKeyword_4_0_0()); }
		(
			{ before(grammarAccess.getXConstructorCallAccess().getExplicitConstructorCallLeftParenthesisKeyword_4_0_0()); }
			'('
			{ after(grammarAccess.getXConstructorCallAccess().getExplicitConstructorCallLeftParenthesisKeyword_4_0_0()); }
		)
		{ after(grammarAccess.getXConstructorCallAccess().getExplicitConstructorCallLeftParenthesisKeyword_4_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__ArgumentsAssignment_4_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXConstructorCallAccess().getArgumentsXShortClosureParserRuleCall_4_1_0_0()); }
		ruleXShortClosure
		{ after(grammarAccess.getXConstructorCallAccess().getArgumentsXShortClosureParserRuleCall_4_1_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__ArgumentsAssignment_4_1_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXConstructorCallAccess().getArgumentsXExpressionParserRuleCall_4_1_1_0_0()); }
		ruleXExpression
		{ after(grammarAccess.getXConstructorCallAccess().getArgumentsXExpressionParserRuleCall_4_1_1_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__ArgumentsAssignment_4_1_1_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXConstructorCallAccess().getArgumentsXExpressionParserRuleCall_4_1_1_1_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXConstructorCallAccess().getArgumentsXExpressionParserRuleCall_4_1_1_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XConstructorCall__ArgumentsAssignment_5
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXConstructorCallAccess().getArgumentsXClosureParserRuleCall_5_0()); }
		ruleXClosure
		{ after(grammarAccess.getXConstructorCallAccess().getArgumentsXClosureParserRuleCall_5_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XBooleanLiteral__IsTrueAssignment_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXBooleanLiteralAccess().getIsTrueTrueKeyword_1_1_0()); }
		(
			{ before(grammarAccess.getXBooleanLiteralAccess().getIsTrueTrueKeyword_1_1_0()); }
			'true'
			{ after(grammarAccess.getXBooleanLiteralAccess().getIsTrueTrueKeyword_1_1_0()); }
		)
		{ after(grammarAccess.getXBooleanLiteralAccess().getIsTrueTrueKeyword_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XNumberLiteral__ValueAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXNumberLiteralAccess().getValueNumberParserRuleCall_1_0()); }
		ruleNumber
		{ after(grammarAccess.getXNumberLiteralAccess().getValueNumberParserRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XStringLiteral__ValueAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXStringLiteralAccess().getValueSTRINGTerminalRuleCall_1_0()); }
		RULE_STRING
		{ after(grammarAccess.getXStringLiteralAccess().getValueSTRINGTerminalRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__TypeAssignment_3
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXTypeLiteralAccess().getTypeJvmTypeCrossReference_3_0()); }
		(
			{ before(grammarAccess.getXTypeLiteralAccess().getTypeJvmTypeQualifiedNameParserRuleCall_3_0_1()); }
			ruleQualifiedName
			{ after(grammarAccess.getXTypeLiteralAccess().getTypeJvmTypeQualifiedNameParserRuleCall_3_0_1()); }
		)
		{ after(grammarAccess.getXTypeLiteralAccess().getTypeJvmTypeCrossReference_3_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTypeLiteral__ArrayDimensionsAssignment_4
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXTypeLiteralAccess().getArrayDimensionsArrayBracketsParserRuleCall_4_0()); }
		ruleArrayBrackets
		{ after(grammarAccess.getXTypeLiteralAccess().getArrayDimensionsArrayBracketsParserRuleCall_4_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XThrowExpression__ExpressionAssignment_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXThrowExpressionAccess().getExpressionXExpressionParserRuleCall_2_0()); }
		ruleXExpression
		{ after(grammarAccess.getXThrowExpressionAccess().getExpressionXExpressionParserRuleCall_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XReturnExpression__ExpressionAssignment_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXReturnExpressionAccess().getExpressionXExpressionParserRuleCall_2_0()); }
		ruleXExpression
		{ after(grammarAccess.getXReturnExpressionAccess().getExpressionXExpressionParserRuleCall_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__ExpressionAssignment_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getExpressionXExpressionParserRuleCall_2_0()); }
		ruleXExpression
		{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getExpressionXExpressionParserRuleCall_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__CatchClausesAssignment_3_0_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getCatchClausesXCatchClauseParserRuleCall_3_0_0_0()); }
		ruleXCatchClause
		{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getCatchClausesXCatchClauseParserRuleCall_3_0_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__FinallyExpressionAssignment_3_0_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyExpressionXExpressionParserRuleCall_3_0_1_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyExpressionXExpressionParserRuleCall_3_0_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XTryCatchFinallyExpression__FinallyExpressionAssignment_3_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyExpressionXExpressionParserRuleCall_3_1_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXTryCatchFinallyExpressionAccess().getFinallyExpressionXExpressionParserRuleCall_3_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__ParamAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXSynchronizedExpressionAccess().getParamXExpressionParserRuleCall_1_0()); }
		ruleXExpression
		{ after(grammarAccess.getXSynchronizedExpressionAccess().getParamXExpressionParserRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XSynchronizedExpression__ExpressionAssignment_3
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXSynchronizedExpressionAccess().getExpressionXExpressionParserRuleCall_3_0()); }
		ruleXExpression
		{ after(grammarAccess.getXSynchronizedExpressionAccess().getExpressionXExpressionParserRuleCall_3_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCatchClause__DeclaredParamAssignment_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXCatchClauseAccess().getDeclaredParamFullJvmFormalParameterParserRuleCall_2_0()); }
		ruleFullJvmFormalParameter
		{ after(grammarAccess.getXCatchClauseAccess().getDeclaredParamFullJvmFormalParameterParserRuleCall_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XCatchClause__ExpressionAssignment_4
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXCatchClauseAccess().getExpressionXExpressionParserRuleCall_4_0()); }
		ruleXExpression
		{ after(grammarAccess.getXCatchClauseAccess().getExpressionXExpressionParserRuleCall_4_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__ParamTypesAssignment_0_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFunctionTypeRefAccess().getParamTypesJvmTypeReferenceParserRuleCall_0_1_0_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getXFunctionTypeRefAccess().getParamTypesJvmTypeReferenceParserRuleCall_0_1_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__ParamTypesAssignment_0_1_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFunctionTypeRefAccess().getParamTypesJvmTypeReferenceParserRuleCall_0_1_1_1_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getXFunctionTypeRefAccess().getParamTypesJvmTypeReferenceParserRuleCall_0_1_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XFunctionTypeRef__ReturnTypeAssignment_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXFunctionTypeRefAccess().getReturnTypeJvmTypeReferenceParserRuleCall_2_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getXFunctionTypeRefAccess().getReturnTypeJvmTypeReferenceParserRuleCall_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__TypeAssignment_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeJvmTypeCrossReference_0_0()); }
		(
			{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeJvmTypeQualifiedNameParserRuleCall_0_0_1()); }
			ruleQualifiedName
			{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeJvmTypeQualifiedNameParserRuleCall_0_0_1()); }
		)
		{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeJvmTypeCrossReference_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__ArgumentsAssignment_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_0()); }
		ruleJvmArgumentTypeReference
		{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsJvmArgumentTypeReferenceParserRuleCall_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__ArgumentsAssignment_1_2_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsJvmArgumentTypeReferenceParserRuleCall_1_2_1_0()); }
		ruleJvmArgumentTypeReference
		{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsJvmArgumentTypeReferenceParserRuleCall_1_2_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__TypeAssignment_1_4_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeJvmTypeCrossReference_1_4_1_0()); }
		(
			{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeJvmTypeValidIDParserRuleCall_1_4_1_0_1()); }
			ruleValidID
			{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeJvmTypeValidIDParserRuleCall_1_4_1_0_1()); }
		)
		{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getTypeJvmTypeCrossReference_1_4_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__ArgumentsAssignment_1_4_2_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsJvmArgumentTypeReferenceParserRuleCall_1_4_2_1_0()); }
		ruleJvmArgumentTypeReference
		{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsJvmArgumentTypeReferenceParserRuleCall_1_4_2_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmParameterizedTypeReference__ArgumentsAssignment_1_4_2_2_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsJvmArgumentTypeReferenceParserRuleCall_1_4_2_2_1_0()); }
		ruleJvmArgumentTypeReference
		{ after(grammarAccess.getJvmParameterizedTypeReferenceAccess().getArgumentsJvmArgumentTypeReferenceParserRuleCall_1_4_2_2_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__ConstraintsAssignment_2_0_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsJvmUpperBoundParserRuleCall_2_0_0_0()); }
		ruleJvmUpperBound
		{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsJvmUpperBoundParserRuleCall_2_0_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__ConstraintsAssignment_2_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsJvmUpperBoundAndedParserRuleCall_2_0_1_0()); }
		ruleJvmUpperBoundAnded
		{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsJvmUpperBoundAndedParserRuleCall_2_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__ConstraintsAssignment_2_1_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsJvmLowerBoundParserRuleCall_2_1_0_0()); }
		ruleJvmLowerBound
		{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsJvmLowerBoundParserRuleCall_2_1_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmWildcardTypeReference__ConstraintsAssignment_2_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsJvmLowerBoundAndedParserRuleCall_2_1_1_0()); }
		ruleJvmLowerBoundAnded
		{ after(grammarAccess.getJvmWildcardTypeReferenceAccess().getConstraintsJvmLowerBoundAndedParserRuleCall_2_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmUpperBound__TypeReferenceAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmUpperBoundAccess().getTypeReferenceJvmTypeReferenceParserRuleCall_1_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getJvmUpperBoundAccess().getTypeReferenceJvmTypeReferenceParserRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmUpperBoundAnded__TypeReferenceAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmUpperBoundAndedAccess().getTypeReferenceJvmTypeReferenceParserRuleCall_1_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getJvmUpperBoundAndedAccess().getTypeReferenceJvmTypeReferenceParserRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmLowerBound__TypeReferenceAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmLowerBoundAccess().getTypeReferenceJvmTypeReferenceParserRuleCall_1_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getJvmLowerBoundAccess().getTypeReferenceJvmTypeReferenceParserRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__JvmLowerBoundAnded__TypeReferenceAssignment_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getJvmLowerBoundAndedAccess().getTypeReferenceJvmTypeReferenceParserRuleCall_1_0()); }
		ruleJvmTypeReference
		{ after(grammarAccess.getJvmLowerBoundAndedAccess().getTypeReferenceJvmTypeReferenceParserRuleCall_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__StaticAssignment_1_0_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getStaticStaticKeyword_1_0_0_0()); }
		(
			{ before(grammarAccess.getXImportDeclarationAccess().getStaticStaticKeyword_1_0_0_0()); }
			'static'
			{ after(grammarAccess.getXImportDeclarationAccess().getStaticStaticKeyword_1_0_0_0()); }
		)
		{ after(grammarAccess.getXImportDeclarationAccess().getStaticStaticKeyword_1_0_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__ExtensionAssignment_1_0_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getExtensionExtensionKeyword_1_0_1_0()); }
		(
			{ before(grammarAccess.getXImportDeclarationAccess().getExtensionExtensionKeyword_1_0_1_0()); }
			'extension'
			{ after(grammarAccess.getXImportDeclarationAccess().getExtensionExtensionKeyword_1_0_1_0()); }
		)
		{ after(grammarAccess.getXImportDeclarationAccess().getExtensionExtensionKeyword_1_0_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__ImportedTypeAssignment_1_0_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getImportedTypeJvmDeclaredTypeCrossReference_1_0_2_0()); }
		(
			{ before(grammarAccess.getXImportDeclarationAccess().getImportedTypeJvmDeclaredTypeQualifiedNameInStaticImportParserRuleCall_1_0_2_0_1()); }
			ruleQualifiedNameInStaticImport
			{ after(grammarAccess.getXImportDeclarationAccess().getImportedTypeJvmDeclaredTypeQualifiedNameInStaticImportParserRuleCall_1_0_2_0_1()); }
		)
		{ after(grammarAccess.getXImportDeclarationAccess().getImportedTypeJvmDeclaredTypeCrossReference_1_0_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__WildcardAssignment_1_0_3_0
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getWildcardAsteriskKeyword_1_0_3_0_0()); }
		(
			{ before(grammarAccess.getXImportDeclarationAccess().getWildcardAsteriskKeyword_1_0_3_0_0()); }
			'*'
			{ after(grammarAccess.getXImportDeclarationAccess().getWildcardAsteriskKeyword_1_0_3_0_0()); }
		)
		{ after(grammarAccess.getXImportDeclarationAccess().getWildcardAsteriskKeyword_1_0_3_0_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__MemberNameAssignment_1_0_3_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getMemberNameValidIDParserRuleCall_1_0_3_1_0()); }
		ruleValidID
		{ after(grammarAccess.getXImportDeclarationAccess().getMemberNameValidIDParserRuleCall_1_0_3_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__ImportedTypeAssignment_1_1
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getImportedTypeJvmDeclaredTypeCrossReference_1_1_0()); }
		(
			{ before(grammarAccess.getXImportDeclarationAccess().getImportedTypeJvmDeclaredTypeQualifiedNameParserRuleCall_1_1_0_1()); }
			ruleQualifiedName
			{ after(grammarAccess.getXImportDeclarationAccess().getImportedTypeJvmDeclaredTypeQualifiedNameParserRuleCall_1_1_0_1()); }
		)
		{ after(grammarAccess.getXImportDeclarationAccess().getImportedTypeJvmDeclaredTypeCrossReference_1_1_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

rule__XImportDeclaration__ImportedNamespaceAssignment_1_2
	@init {
		int stackSize = keepStackSize();
	}
:
	(
		{ before(grammarAccess.getXImportDeclarationAccess().getImportedNamespaceQualifiedNameWithWildcardParserRuleCall_1_2_0()); }
		ruleQualifiedNameWithWildcard
		{ after(grammarAccess.getXImportDeclarationAccess().getImportedNamespaceQualifiedNameWithWildcardParserRuleCall_1_2_0()); }
	)
;
finally {
	restoreStackSize(stackSize);
}

RULE_HEX : ('0x'|'0X') ('0'..'9'|'a'..'f'|'A'..'F'|'_')+ ('#' (('b'|'B') ('i'|'I')|('l'|'L')))?;

RULE_INT : '0'..'9' ('0'..'9'|'_')*;

RULE_DECIMAL : RULE_INT (('e'|'E') ('+'|'-')? RULE_INT)? (('b'|'B') ('i'|'I'|'d'|'D')|('l'|'L'|'d'|'D'|'f'|'F'))?;

RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'$'|'_') ('a'..'z'|'A'..'Z'|'$'|'_'|'0'..'9')*;

RULE_STRING : ('"' ('\\' .|~(('\\'|'"')))* '"'?|'\'' ('\\' .|~(('\\'|'\'')))* '\''?);

RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

RULE_WS : (' '|'\t'|'\r'|'\n')+;

RULE_ANY_OTHER : .;
