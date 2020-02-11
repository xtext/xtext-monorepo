/*******************************************************************************
 * Copyright (c) 2012, 2017 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package testdata;

/**
 * @author Jan Koehnlein
 * @since 2.3
 */
public interface SugarConflict {
	void getFoo();
	void foo();
	
	void bar();
	void getBar();
	
	Object getFooBar();
	boolean isFooBar();
	
	boolean isZonk();
	Object getZonk();
	
	boolean isBaz();
	Object getBaz();
	Object baz();
	String baz = "baz";
	
}
