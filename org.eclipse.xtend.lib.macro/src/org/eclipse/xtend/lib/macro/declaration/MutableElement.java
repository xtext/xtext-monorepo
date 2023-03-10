/*******************************************************************************
 * Copyright (c) 2014, 2016 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtend.lib.macro.declaration;

import com.google.common.annotations.Beta;

/**
 * 
 * @author Anton Kosyakov
 * @noimplement This interface is not intended to be implemented by clients.
 */
@Beta
public interface MutableElement extends Element {

	/**
	 * Removes this element from its container and renders it invalid.
	 * @throws IllegalStateException if this element has already been removed or it was not possible to remove
	 */
	public void remove();

}
