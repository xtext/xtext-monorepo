/*******************************************************************************
 * Copyright (c) 2011, 2022 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.parsetree.transientvalues;

import java.util.List;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EStructuralFeature;
import org.eclipse.xtext.serializer.sequencer.TransientValueService;

/**
 * @author Moritz Eysholdt - Initial contribution and API
 */
public class TransientHandlerSerializer extends TransientValueService {

	@Override
	public ListTransient isListTransient(EObject semanticObject, EStructuralFeature feature) {
		if ("TestList".equals(semanticObject.eClass().getName()))
			return ListTransient.SOME;
		return super.isListTransient(semanticObject, feature);
	}

	@Override
	public boolean isValueInListTransient(EObject semanticObject, int index, EStructuralFeature feature) {
		if ("item".equals(feature.getName())) {
			List<?> l = (List<?>) semanticObject.eGet(feature);
			return ((Integer) l.get(index) % 2) == 0;
		}
		return super.isValueInListTransient(semanticObject, index, feature);
	}

	@Override
	public ValueTransient isValueTransient(EObject semanticObject, EStructuralFeature feature) {
		final String n = feature.getName();
		if ("required1".equals(n) || "required2".equals(n))
			return ValueTransient.PREFERABLY;
		if ("opt1".equals(n) || "opt2".equals(n))
			return ValueTransient.YES;
		return super.isValueTransient(semanticObject, feature);
	}

}
