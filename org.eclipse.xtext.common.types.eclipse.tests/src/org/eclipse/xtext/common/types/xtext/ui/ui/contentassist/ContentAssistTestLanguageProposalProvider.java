/*******************************************************************************
 * Copyright (c) 2010, 2022 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.common.types.xtext.ui.ui.contentassist;

import java.util.Collection;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.xtext.Assignment;
import org.eclipse.xtext.common.types.JvmType;
import org.eclipse.xtext.common.types.access.IJvmTypeProvider;
import org.eclipse.xtext.common.types.xtext.ui.ITypesProposalProvider;
import org.eclipse.xtext.common.types.xtext.ui.contentAssistTestLanguage.ContentAssistTestLanguagePackage;
import org.eclipse.xtext.ui.editor.contentassist.ContentAssistContext;
import org.eclipse.xtext.ui.editor.contentassist.ICompletionProposalAcceptor;

import com.google.inject.Inject;
/**
 * See https://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#content-assist
 * on how to customize the content assistant.
 */
public class ContentAssistTestLanguageProposalProvider extends AbstractContentAssistTestLanguageProposalProvider {

	@Inject
	private ITypesProposalProvider typesProposalProvider;
	
	@Inject
	private IJvmTypeProvider.Factory typeProviderFactory;
	
	@Override
	public void completeReferenceHolder_CustomizedReference(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		typesProposalProvider.createTypeProposals(this, context, ContentAssistTestLanguagePackage.Literals.REFERENCE_HOLDER__CUSTOMIZED_REFERENCE, acceptor);
	}
	
	@Override
	public void completeReferenceHolder_SubtypeReference(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
		ResourceSet resourceSet = model.eResource().getResourceSet();
		IJvmTypeProvider typeProvider = typeProviderFactory.findOrCreateTypeProvider(resourceSet);
		JvmType superType = typeProvider.findTypeByName(Collection.class.getName());
		typesProposalProvider.createSubTypeProposals(superType, this, context, ContentAssistTestLanguagePackage.Literals.REFERENCE_HOLDER__SUBTYPE_REFERENCE, acceptor);
	}
	
}
