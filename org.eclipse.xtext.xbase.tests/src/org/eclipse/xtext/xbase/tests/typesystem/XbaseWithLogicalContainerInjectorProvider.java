/*******************************************************************************
 * Copyright (c) 2013, 2016 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.xbase.tests.typesystem;

import org.eclipse.xtext.validation.IResourceValidator;
import org.eclipse.xtext.xbase.annotations.validation.DerivedStateAwareResourceValidator;
import org.eclipse.xtext.xbase.tests.XbaseInjectorProvider;
import org.eclipse.xtext.xbase.typesystem.internal.DefaultBatchTypeResolver;
import org.eclipse.xtext.xbase.typesystem.internal.DefaultReentrantTypeResolver;
import org.eclipse.xtext.xbase.typesystem.internal.LogicalContainerAwareBatchTypeResolver;
import org.eclipse.xtext.xbase.typesystem.internal.LogicalContainerAwareReentrantTypeResolver;

import com.google.inject.Guice;
import com.google.inject.Injector;

/**
 * An injector provider for plain Xbase tests with the reworked type system infrastructure.
 * 
 * @author Sebastian Zarnekow - Initial contribution and API
 */
public class XbaseWithLogicalContainerInjectorProvider extends XbaseInjectorProvider {

	@Override
	protected Injector internalCreateInjector() {
		return new XbaseWithLogicalContainerTestStandaloneSetup().createInjectorAndDoEMFRegistration();
	}

	public static class XbaseWithLogicalContainerTestStandaloneSetup extends XbaseTestStandaloneSetup {
		@Override
		public Injector createInjector() {
			return Guice.createInjector(new XbaseWithLogicalContainerRuntimeModule());
		}
	}

	public static class XbaseWithLogicalContainerRuntimeModule extends XbaseTestRuntimeModule {

		public Class<? extends DefaultBatchTypeResolver> bindDefaultBatchTypeResolver() {
			return LogicalContainerAwareBatchTypeResolver.class; 
		}
		
		public Class<? extends DefaultReentrantTypeResolver> bindReentrantTypeResolver() {
			return LogicalContainerAwareReentrantTypeResolver.class;
		}
		
		public Class<? extends IResourceValidator> bindIResourceValidator() {
			return DerivedStateAwareResourceValidator.class;
		}
	}

}
