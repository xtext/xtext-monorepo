/*******************************************************************************
 * Copyright (c) 2012 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.junit4;

import org.eclipse.emf.ecore.EValidator;
import org.eclipse.xtext.XtextPackage;
import org.eclipse.xtext.junit4.internal.XtextInjectorProvider;
import org.eclipse.xtext.validation.CompositeEValidator;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;

/**
 * @author Jan Koehnlein - Initial contribution and API
 */
@RunWith(XtextRunner.class)
@InjectWith(XtextInjectorProvider.class)
@Deprecated(forRemoval = true)
public class Bug367679Test {
	
	@Test 
	public void testValidatorExists_0() {
		assertValidatorExists();
	}

	@Test 
	public void testValidatorExists_1() {
		assertValidatorExists();
	}

	protected void assertValidatorExists() {
		EValidator eValidator = EValidator.Registry.INSTANCE.getEValidator(XtextPackage.eINSTANCE);
		Assert.assertNotNull(eValidator);
		Assert.assertTrue(eValidator instanceof CompositeEValidator);
	}

}
