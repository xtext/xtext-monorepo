/*******************************************************************************
 * Copyright (c) 2012, 2019 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtend.core.tests.smoke

import com.google.inject.Inject
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EcoreFactory
import org.eclipse.xtend.core.tests.AbstractXtendTestCase
import org.eclipse.xtext.common.types.JvmConstructor
import org.eclipse.xtext.common.types.JvmDeclaredType
import org.eclipse.xtext.common.types.JvmGenericType
import org.eclipse.xtext.resource.DerivedStateAwareResource
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.xtext.xbase.jvmmodel.JvmModelAssociator
import org.eclipse.xtext.xbase.jvmmodel.JvmTypesBuilder
import org.junit.Test
import org.junit.Ignore

@Ignore
class Case_14_Test extends AbstractXtendTestCase {

       @Inject extension JvmTypesBuilder
       @Inject JvmModelAssociator assoc
       @Inject XtextResourceSet resourceSet
       @Inject DerivedStateAwareResource resource

       @Test
       def void testInference() {
               assoc.inferrerProvider = [[obj, acceptor, preIndexing|
                       val firstType = obj.toClass('foo.Bar')
                       val secondType = obj.toClass('foo.Baz')
                       assertNull(secondType.eResource)
                       acceptor.accept (firstType) [
                               ^abstract = true
                               assertNotNull(firstType.eResource)
                               assertNotNull(secondType.eResource)
                       ]
                       acceptor.accept (secondType) [
                               ^abstract = true
                               assertNotNull(firstType.eResource)
                       ]
               ]]
               resource.setDerivedStateComputer(null)
               resource.URI = URI::createURI('foo.txt')
               resourceSet.classpathURIContext = getClass()
               resourceSet.resources += resource
               resource.contents += EcoreFactory::eINSTANCE.createEClass
               assoc.installDerivedState(resource,true)
               assertFalse((resource.contents.get(1) as JvmDeclaredType).^abstract)

               resource.contents.clear
               resource.contents += EcoreFactory::eINSTANCE.createEClass
               assoc.installDerivedState(resource,false)
               val type = (resource.contents.get(1) as JvmGenericType)
               assertTrue(type.^abstract)

               // test extends object and default constructor
               assertEquals(1, type.members.filter(typeof(JvmConstructor)).size)
               assertEquals("java.lang.Object", type.superTypes.head?.qualifiedName)
       }


}