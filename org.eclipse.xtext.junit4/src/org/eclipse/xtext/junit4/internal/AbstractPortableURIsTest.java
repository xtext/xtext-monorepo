/*******************************************************************************
 * Copyright (c) 2015, 2022 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.junit4.internal;

import static org.junit.Assert.*;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.eclipse.core.runtime.IStatus;
import org.eclipse.emf.codegen.ecore.genmodel.GenModel;
import org.eclipse.emf.codegen.ecore.genmodel.GenPackage;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EReference;
import org.eclipse.emf.ecore.EStructuralFeature;
import org.eclipse.emf.ecore.plugin.EcorePlugin;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.xmi.XMLResource;
import org.eclipse.emf.ecore.xmi.impl.URIHandlerImpl;
import org.eclipse.xtext.resource.XtextResourceSet;
import org.eclipse.xtext.util.EmfFormatter;
import org.eclipse.xtext.xbase.lib.Functions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.junit.After;
import org.junit.Before;
import org.junit.ComparisonFailure;

import com.google.common.base.Predicate;
import com.google.common.collect.Lists;

/**
 * @author Sebastian Zarnekow - Initial contribution and API
 */
@Deprecated(forRemoval = true, since = "2.30")
public abstract class AbstractPortableURIsTest extends URIHandlerImpl.PlatformSchemeAware {

	private ResourceSet resourceSet;

	@Before
	public void setUp() throws Exception {
		resourceSet = new XtextResourceSet();
		resourceSet.getURIConverter().getURIMap().putAll(EcorePlugin.computePlatformURIMap(false));
		resourceSet.getLoadOptions().put(XMLResource.OPTION_URI_HANDLER, this);
	}
	
	@After
	public void tearDown() {
		resourceSet = null;
	}
	
	@Override
	public URI resolve(URI uri) {
		assertPortableURI(uri);
		return super.resolve(uri);
	}
	
	protected void doTestResource(String platformPath, String... packageNames) {
		Resource resource = resourceSet.getResource(URI.createPlatformPluginURI(platformPath, false), true);
		assertNotNull(resource);
		assertEquals(1, resource.getContents().size());
		EObject obj = resource.getContents().get(0);
		if (obj instanceof EPackage) {
			assertEquals(packageNames[0], ((EPackage) obj).getName());
		} else if (obj instanceof GenModel) {
			GenModel model = (GenModel) obj;
			List<GenPackage> packages = Lists.newArrayList(model.getGenPackages());
			assertEquals(packageNames.length, packages.size());
			ListExtensions.sortInplaceBy(packages, new Functions.Function1<GenPackage, String>() {
				@Override
				public String apply(GenPackage p) {
					return p.getEcorePackage().getName();
				}
			});
			List<String> packageNamesList = Arrays.asList(packageNames);
			Collections.sort(packageNamesList);
			for(int i = 0; i < packageNamesList.size(); i++) {
				assertEquals(packageNamesList.get(i), packages.get(i).getEcorePackage().getName());
			}
			IStatus status = model.validate();
			assertTrue(printLeafs(status), status.isOK());
			EObject orig = EcoreUtil.copy(obj);
			((GenModel) obj).reconcile();
			if (!EcoreUtil.equals(orig, obj)) {
				Predicate<EStructuralFeature> ignoreContainer = new Predicate<EStructuralFeature>() {
					@Override
					public boolean apply(EStructuralFeature f) {
						if (f instanceof EReference) {
							EReference casted = (EReference) f;
							return !casted.isContainment();
						}
						return false;
					}
				};
				String origAsString = EmfFormatter.objToStr(orig, ignoreContainer);
				String newAsString = EmfFormatter.objToStr(obj, ignoreContainer);
				throw new ComparisonFailure("Reconcile changed model", origAsString, newAsString);
			}
		} else {
			fail("Unexpected root element type: " + obj.eClass().getName());
		}
	}
	
	protected String printLeafs(IStatus status) {
		StringBuilder result = new StringBuilder();
		appendLeafs(status, result);
		return result.toString();
	}
	
	protected void appendLeafs(IStatus status, StringBuilder result) {
		if (status.isOK()) {
			return;
		}
		result.append(status.getMessage()).append('\n');
		IStatus[] children = status.getChildren();
		for(IStatus child: children) {
			appendLeafs(child, result);
		}
	}

	protected void assertPortableURI(URI uri) {
		if (uri.isRelative()) {
			String path = uri.path();
			assertFalse(uri.toString() + " is not portable", path.startsWith(".."));
		}
	}
	
}
