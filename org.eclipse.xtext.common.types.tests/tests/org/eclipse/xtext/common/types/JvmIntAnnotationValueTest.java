/*******************************************************************************
 * Copyright (c) 2010 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.common.types;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

/**
 * @author Sebastian Zarnekow - Initial contribution and API
 */
public class JvmIntAnnotationValueTest extends Assert {

	private JvmIntAnnotationValue intAnnotationValue;

	@Before
	public void setUp() throws Exception {
		intAnnotationValue = TypesFactory.eINSTANCE.createJvmIntAnnotationValue();
	}	
	
	@Test public void testMultiValue() {
		intAnnotationValue.getValues().add(1);
		intAnnotationValue.getValues().add(1);
		assertEquals(2, intAnnotationValue.getValues().size());
	}
}
