/*******************************************************************************
 * Copyright (c) 2012 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.resource.containers;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.xtext.resource.LiveContainerTestLanguageInjectorProvider;
import org.eclipse.xtext.resource.liveContainerTestLanguage.LiveContainerTestLanguagePackage;
import org.eclipse.xtext.testing.InjectWith;

/**
 * @author Moritz Eysholdt - Initial contribution and API
 */
@InjectWith(LiveContainerTestLanguageInjectorProvider.class)
public class LiveContainerTest extends AbstractLiveContainerTest {

	@Override
	protected EClass getModelRootType() {
		return LiveContainerTestLanguagePackage.Literals.MODEL;
	}

}