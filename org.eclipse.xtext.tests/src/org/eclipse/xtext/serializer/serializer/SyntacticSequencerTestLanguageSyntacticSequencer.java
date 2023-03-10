/*******************************************************************************
 * Copyright (c) 2010, 2022 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.serializer.serializer;

import java.util.List;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.IGrammarAccess;
import org.eclipse.xtext.RuleCall;
import org.eclipse.xtext.nodemodel.ICompositeNode;
import org.eclipse.xtext.nodemodel.INode;
import org.eclipse.xtext.serializer.analysis.ISyntacticSequencerPDAProvider.ISynNavigable;
import org.eclipse.xtext.serializer.services.SyntacticSequencerTestLanguageGrammarAccess;

import com.google.inject.Inject;

public class SyntacticSequencerTestLanguageSyntacticSequencer extends
		AbstractSyntacticSequencerTestLanguageSyntacticSequencer {

	private SyntacticSequencerTestLanguageGrammarAccess ga;

	@Inject
	protected void asetGa(IGrammarAccess ga) {
		this.ga = (SyntacticSequencerTestLanguageGrammarAccess) ga;
	}

	@Override
	protected String getKW1Token(EObject semanticObject, RuleCall ruleCall, INode node) {
		return "matched 1";
	}

	/**
	 * terminal BOOLEAN_TERMINAL_ID: '%1' ID;
	 */
	@Override
	protected String getBOOLEAN_TERMINAL_IDToken(EObject semanticObject, RuleCall ruleCall, INode node) {
		return "%1matched";
	}

	/**
	 * BooleanDatatypeID: ID;
	 */
	@Override
	protected String getBooleanDatatypeIDToken(EObject semanticObject, RuleCall ruleCall, INode node) {
		return "foomatched";
	}

	/**
	 * Syntax: 'kw2' | KW1
	 */
	@Override
	protected void emit_AlternativeTransition_KW1ParserRuleCall_1_0_or_Kw2Keyword_1_1(EObject semanticObject,
			ISynNavigable transition, List<INode> nodes) {
		ICompositeNode node = (ICompositeNode) nodes.get(0);
		acceptUnassignedDatatype(ga.getAlternativeTransitionAccess().getKW1ParserRuleCall_1_0(), "matched 5", node);
	}

	/**
	 * Syntax: KW1+
	 */
	@Override
	protected void emit_MandatoryManyTransition_KW1ParserRuleCall_1_p(EObject semanticObject, ISynNavigable transition,
			List<INode> nodes) {
		ICompositeNode node = (ICompositeNode) nodes.get(0);
		acceptUnassignedDatatype(ga.getMandatoryManyTransitionAccess().getKW1ParserRuleCall_1(), "matched 4", node);
	}

	/**
	 * Syntax: KW1*
	 */
	@Override
	protected void emit_OptionalManyTransition_KW1ParserRuleCall_1_a(EObject semanticObject, ISynNavigable transition,
			List<INode> nodes) {
		ICompositeNode node = (ICompositeNode) nodes.get(0);
		acceptUnassignedDatatype(ga.getOptionalManyTransitionAccess().getKW1ParserRuleCall_1(), "matched 3", node);
	}

	/**
	 * Syntax: KW1?
	 */
	@Override
	protected void emit_OptionalSingleTransition_KW1ParserRuleCall_1_q(EObject semanticObject,
			ISynNavigable transition, List<INode> nodes) {
		ICompositeNode node = (ICompositeNode) nodes.get(0);
		acceptUnassignedDatatype(ga.getOptionalSingleTransitionAccess().getKW1ParserRuleCall_1(), "matched 2", node);
	}

}
