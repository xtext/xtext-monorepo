/*******************************************************************************
 * Copyright (c) 2012, 2019 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtend.core.tests.smoke

import org.eclipse.xtend.lib.annotations.Data

@Data
class Case_0 {
	int id

	def String foo(String a, String b) {
		var list = newArrayList()
		for(i: 0..list.size - 1) {
			println(i.toString + " " + list.get(i))
		}
		if (isUpper(a)) {
			another(a,b+'holla')
		} else {
			var x = a;
			for (y : b.toCharArray) {
				x = x+y
			}
			x
		}
	}
	
	def isUpper(String s) {
		s.toUpperCase == s
	}
		
	def another(String x, String y) { 
		y+x
	}
	

}