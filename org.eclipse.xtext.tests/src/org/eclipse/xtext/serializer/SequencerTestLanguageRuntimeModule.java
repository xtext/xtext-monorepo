/*******************************************************************************
 * Copyright (c) 2011, 2022 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.eclipse.xtext.serializer;

import java.util.Collections;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EReference;
import org.eclipse.emf.ecore.EStructuralFeature;
import org.eclipse.emf.ecore.EStructuralFeature.Setting;
import org.eclipse.xtext.common.services.DefaultTerminalConverters;
import org.eclipse.xtext.conversion.IValueConverter;
import org.eclipse.xtext.conversion.IValueConverterService;
import org.eclipse.xtext.conversion.ValueConverter;
import org.eclipse.xtext.conversion.ValueConverterException;
import org.eclipse.xtext.diagnostics.IDiagnosticProducer;
import org.eclipse.xtext.linking.ILinker;
import org.eclipse.xtext.linking.lazy.LazyLinker;
import org.eclipse.xtext.naming.QualifiedName;
import org.eclipse.xtext.nodemodel.INode;
import org.eclipse.xtext.resource.EObjectDescription;
import org.eclipse.xtext.resource.IEObjectDescription;
import org.eclipse.xtext.scoping.IScope;
import org.eclipse.xtext.scoping.IScopeProvider;
import org.eclipse.xtext.scoping.impl.AbstractScope;
import org.eclipse.xtext.scoping.impl.SimpleLocalScopeProvider;
import org.eclipse.xtext.serializer.sequencer.ITransientValueService;
import org.eclipse.xtext.serializer.sequencer.LegacyTransientValueService;
import org.eclipse.xtext.serializer.sequencertest.NullCrossRef;
import org.eclipse.xtext.serializer.sequencertest.SequencertestPackage;

import com.google.common.collect.Multimap;
import com.google.inject.Singleton;

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
public class SequencerTestLanguageRuntimeModule extends AbstractSequencerTestLanguageRuntimeModule {

	public static class NullSafeEObjectDescription extends EObjectDescription {

		public NullSafeEObjectDescription(QualifiedName qualifiedName, EObject element) {
			super(qualifiedName, element, Collections.<String, String> emptyMap());
		}

		@Override
		public URI getEObjectURI() {
			if (getEObjectOrProxy() == null)
				return URI.createURI("null");
			return super.getEObjectURI();
		}

	}

	public static class NullSettingLazyLinker extends LazyLinker {
		@Override
		protected void installProxies(EObject obj, IDiagnosticProducer producer, Multimap<Setting, INode> settingsToLink) {
			super.installProxies(obj, producer, settingsToLink);
			if (obj instanceof NullCrossRef)
				((NullCrossRef) obj).setRef(null);
		}
	}

	public static class SequencerTestScopeProvider extends SimpleLocalScopeProvider {

		@Override
		public IScope getScope(EObject context, EReference reference) {
			if (reference == SequencertestPackage.Literals.NULL_CROSS_REF__REF)
				return new AbstractScope(IScope.NULLSCOPE, false) {

					@Override
					public Iterable<IEObjectDescription> getElements(EObject object) {
						return Collections.singletonList(getSingleElement(object));
					}

					@Override
					public IEObjectDescription getSingleElement(EObject object) {
						return EObjectDescription.create("null", null);
					}

					@Override
					protected Iterable<IEObjectDescription> getAllLocalElements() {
						throw new UnsupportedOperationException();
					}
				};
			return super.getScope(context, reference);
		}
	}

	public static class SequencerTestTransientValueService extends LegacyTransientValueService {
		@Override
		public ValueTransient isValueTransient(EObject semanticObject, EStructuralFeature feature) {
			if (feature == SequencertestPackage.Literals.NULL_VALUE__VALUE)
				return ValueTransient.NO;
			if (feature == SequencertestPackage.Literals.NULL_CROSS_REF__REF)
				return ValueTransient.NO;
			return super.isValueTransient(semanticObject, feature);
		}
	}

	@Singleton
	public static class SequencerTestValueConverter extends DefaultTerminalConverters {
		@ValueConverter(rule = "NULL_STRING")
		public IValueConverter<String> NULL_STRING() {
			return new IValueConverter<String>() {
				@Override
				public String toString(String value) throws ValueConverterException {
					if (value == null)
						return "''";
					return "'" + value + "'";
				}

				@Override
				public String toValue(String string, INode node) throws ValueConverterException {
					if (string.length() <= 2) {
						return null;
					}
					return string.substring(1, string.length() - 1);
				}
			};
		}
	}

	@Override
	public Class<? extends ILinker> bindILinker() {
		return NullSettingLazyLinker.class;
	}

	@Override
	public Class<? extends IScopeProvider> bindIScopeProvider() {
		return SequencerTestScopeProvider.class;
	}

	public Class<? extends ITransientValueService> bindITransientValueService2() {
		return SequencerTestTransientValueService.class;
	}

	@Override
	public Class<? extends IValueConverterService> bindIValueConverterService() {
		return SequencerTestValueConverter.class;
	}
}
