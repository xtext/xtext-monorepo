/*******************************************************************************
 * Copyright (c) 2010, 2022 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.ui.tests.editor.contentassist;

import static com.google.common.collect.Iterables.*;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EReference;
import org.eclipse.emf.ecore.EcorePackage;
import org.eclipse.xtext.naming.QualifiedName;
import org.eclipse.xtext.resource.EObjectDescription;
import org.eclipse.xtext.resource.IEObjectDescription;
import org.eclipse.xtext.resource.IResourceDescription;
import org.eclipse.xtext.resource.IResourceDescriptions;
import org.eclipse.xtext.resource.impl.AliasedEObjectDescription;
import org.eclipse.xtext.scoping.IGlobalScopeProvider;
import org.eclipse.xtext.scoping.IScope;
import org.eclipse.xtext.scoping.IScopeProvider;
import org.eclipse.xtext.scoping.Scopes;
import org.eclipse.xtext.scoping.impl.AbstractDeclarativeScopeProvider;
import org.eclipse.xtext.scoping.impl.ImportUriGlobalScopeProvider;
import org.eclipse.xtext.scoping.impl.SelectableBasedScope;
import org.eclipse.xtext.scoping.impl.SimpleLocalScopeProvider;
import org.eclipse.xtext.scoping.impl.SimpleScope;
import org.eclipse.xtext.ui.tests.editor.contentassist.bug287941TestLanguage.AttributeWhereEntry;
import org.eclipse.xtext.ui.tests.editor.contentassist.bug287941TestLanguage.FromEntry;
import org.eclipse.xtext.ui.tests.editor.contentassist.bug287941TestLanguage.MQLquery;

import com.google.common.base.Function;
import com.google.common.base.Predicate;
import com.google.common.base.Predicates;
import com.google.common.collect.Iterables;
import com.google.inject.Binder;
import com.google.inject.name.Names;

/**
 * Use this class to register components to be used within the IDE.
 */
public class Bug287941TestLanguageRuntimeModule extends AbstractBug287941TestLanguageRuntimeModule {

	@Override
	public Class<? extends IScopeProvider> bindIScopeProvider() {
		return ScopeProvider.class;
	}
	
	public void configureIScopeProviderDelegate(Binder binder) {
		binder.bind(IScopeProvider.class).annotatedWith(Names.named(AbstractDeclarativeScopeProvider.NAMED_DELEGATE)).to(SimpleLocalScopeProvider.class);
	}
	
	@Override
	public Class<? extends IGlobalScopeProvider> bindIGlobalScopeProvider() {
		return SimpleEClassScopeProvider.class;
	}
	
	public static class ScopeProvider extends AbstractDeclarativeScopeProvider {
		public IScope scope_FromEntry(MQLquery _this, EClass type) {
			Iterable<IEObjectDescription> transformed = transform(
					_this.getFromEntries(),
					new Function<FromEntry, IEObjectDescription>() {

						@Override
						public IEObjectDescription apply(FromEntry from) {
							return EObjectDescription.create(QualifiedName.create(from.getAlias()), from);
						}
					});
			return new SimpleScope(IScope.NULLSCOPE, transformed);
		}
		
		public IScope scope_AttributeWhereEntry_attribute(AttributeWhereEntry entry, EReference ref) {
			return Scopes.scopeFor(entry.getAlias().getType().getEAllStructuralFeatures());
		}
	}
	
	public static class SimpleEClassScopeProvider extends ImportUriGlobalScopeProvider {
		@Override
		protected IScope createLazyResourceScope(IScope parent, URI uri, IResourceDescriptions descriptions,
				EClass type, Predicate<IEObjectDescription> filter, boolean ignoreCase) {
			IScope result = super.createLazyResourceScope(parent, uri, descriptions, type, filter, ignoreCase);
			if (EcorePackage.Literals.ECLASS == type) {
				IResourceDescription description = descriptions.getResourceDescription(uri);
				Iterable<IEObjectDescription> packages = description.getExportedObjectsByType(EcorePackage.Literals.EPACKAGE);
				for(final IEObjectDescription pack: packages) {
					Predicate<IEObjectDescription> actualFilter = Predicates.and(
							filter == null ? Predicates.<IEObjectDescription>alwaysTrue() : filter,
							new Predicate<IEObjectDescription>() {
								@Override
								public boolean apply(IEObjectDescription input) {
									return input.getName().startsWith(pack.getName());
								}
							}
					);
					result = new SelectableBasedScope(result, description, actualFilter, type, ignoreCase) {
						@Override
						protected Iterable<IEObjectDescription> getLocalElementsByName(QualifiedName name) {
							QualifiedName completeName = pack.getQualifiedName().append(name);
							return super.getLocalElementsByName(completeName);
						}
						
						@Override
						protected java.lang.Iterable<IEObjectDescription> getAllLocalElements() {
							Iterable<IEObjectDescription> result = super.getAllLocalElements();
							result = Iterables.transform(result, new Function<IEObjectDescription, IEObjectDescription>() {
								@Override
								public IEObjectDescription apply(IEObjectDescription from) {
									return new AliasedEObjectDescription(from.getName().skipFirst(pack.getName().getSegmentCount()), from);
								}
							});
							return result;
						}
					};
				}
			}
			return result;
		}
	}
	
	
}
