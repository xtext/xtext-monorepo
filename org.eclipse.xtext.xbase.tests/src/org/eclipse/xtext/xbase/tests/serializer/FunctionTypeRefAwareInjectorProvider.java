/*******************************************************************************
 * Copyright (c) 2010 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.xbase.tests.serializer;

import org.eclipse.xtext.xbase.XbaseStandaloneSetup;
import org.eclipse.xtext.xbase.tests.XbaseInjectorProvider;

import com.google.inject.Guice;
import com.google.inject.Injector;

/**
 * @author Sebastian Zarnekow - Initial contribution and API
 */
public class FunctionTypeRefAwareInjectorProvider extends XbaseInjectorProvider {
	@Override
	protected Injector internalCreateInjector() {
		return new FunctionTypeRefAwareTestStandaloneSetup().createInjectorAndDoEMFRegistration();
	}

	public static class FunctionTypeRefAwareTestStandaloneSetup extends XbaseStandaloneSetup {
		@Override
		public Injector createInjector() {
			return Guice.createInjector(new XbaseTestRuntimeModule() {
				@Override
				public void configure(com.google.inject.Binder binder) {
					super.configure(binder);
					binder.bind(SerializerTester.class).to(XFunctionTypeRefAwareSerializerTester.class);
				}
				
			});
		}
	}

}