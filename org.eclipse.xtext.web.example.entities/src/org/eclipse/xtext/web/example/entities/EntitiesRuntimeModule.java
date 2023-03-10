/*******************************************************************************
 * Copyright (c) 2015, 2019 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.web.example.entities;

import org.eclipse.xtext.web.example.entities.jvmmodel.EntitiesJvmModelInferrer;
import org.eclipse.xtext.xbase.jvmmodel.IJvmModelInferrer;

/**
 * Use this class to register components to be used at runtime / without the
 * Equinox extension registry.
 */
public class EntitiesRuntimeModule extends AbstractEntitiesRuntimeModule {
	public Class<? extends IJvmModelInferrer> bindIJvmModelInferrer() {
		return EntitiesJvmModelInferrer.class;
	}
}
