/**
 * Copyright (c) 2012, 2017 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 * 
 * SPDX-License-Identifier: EPL-2.0
 */
package org.eclipse.xtend.core.tests.typesystem;

import java.util.List;
import java.util.Map;
import org.eclipse.xtext.common.types.JvmTypeParameter;
import org.eclipse.xtext.util.CancelIndicator;
import org.eclipse.xtext.xbase.XExpression;
import org.eclipse.xtext.xbase.typesystem.internal.DefaultReentrantTypeResolver;
import org.eclipse.xtext.xbase.typesystem.internal.RootResolvedTypes;
import org.eclipse.xtext.xbase.typesystem.internal.TypeData;
import org.eclipse.xtext.xbase.typesystem.references.LightweightBoundTypeArgument;
import org.eclipse.xtext.xbase.typesystem.references.UnboundTypeReference;

/**
 * @author Sebastian Zarnekow - Initial contribution and API
 */
@SuppressWarnings("all")
public class PublicResolvedTypes extends RootResolvedTypes {
  public PublicResolvedTypes(final DefaultReentrantTypeResolver resolver) {
    super(resolver, CancelIndicator.NullImpl);
  }

  @Override
  public UnboundTypeReference createUnboundTypeReference(final XExpression expression, final JvmTypeParameter type) {
    return super.createUnboundTypeReference(expression, type);
  }

  @Override
  public UnboundTypeReference getUnboundTypeReference(final Object handle) {
    return super.getUnboundTypeReference(handle);
  }

  @Override
  public List<LightweightBoundTypeArgument> getHints(final Object handle) {
    return super.getHints(handle);
  }

  @Override
  public Map<XExpression, List<TypeData>> basicGetExpressionTypes() {
    return super.basicGetExpressionTypes();
  }
}
