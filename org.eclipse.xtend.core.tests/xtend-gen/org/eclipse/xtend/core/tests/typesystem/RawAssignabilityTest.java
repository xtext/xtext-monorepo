/**
 * Copyright (c) 2012, 2016 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 * 
 * SPDX-License-Identifier: EPL-2.0
 */
package org.eclipse.xtend.core.tests.typesystem;

import org.eclipse.xtext.xbase.lib.Pair;
import org.eclipse.xtext.xbase.typesystem.conformance.ConformanceFlags;
import org.eclipse.xtext.xbase.typesystem.conformance.TypeConformanceComputationArgument;
import org.eclipse.xtext.xbase.typesystem.references.LightweightTypeReference;
import org.junit.Assert;
import org.junit.Test;

/**
 * @author Sebastian Zarnekow
 */
@SuppressWarnings("all")
public class RawAssignabilityTest extends CommonAssignabilityTest {
  @Override
  public boolean doIsAssignable(final LightweightTypeReference lhs, final LightweightTypeReference rhs) {
    final int result = lhs.internalIsAssignableFrom(rhs, TypeConformanceComputationArgument.RAW);
    Assert.assertTrue(((result & ConformanceFlags.RAW_TYPE) != 0));
    return ((result & ConformanceFlags.SUCCESS) != 0);
  }

  @Test
  public void testPrimitiveConversion_09() {
    this.isAssignableFrom("Comparable", "int");
    this.isAssignableFrom("Comparable<Integer>", "int");
    this.isAssignableFrom("Comparable<? extends Number>", "int");
    this.isAssignableFrom("Comparable<Number>", "int");
  }

  @Test
  public void testWildcardWithDefaultUpper() {
    this.isAssignableFrom("Iterable<? extends Object>", "java.util.List<?>");
  }

  @Test
  public void testWildcardLowerBound_02() {
    this.isAssignableFrom("java.util.List<? super Integer>", "java.util.List<? super String>");
  }

  @Test
  @Override
  public void testNestedWildcard_01() {
    this.isAssignableFrom("java.util.List<java.util.List<?>>", "java.util.List<java.util.List<? extends CharSequence>>");
    this.isAssignableFrom("java.util.Collection<java.util.List<?>>", "java.util.List<java.util.List<? extends CharSequence>>");
    this.isAssignableFrom("java.util.Collection<java.util.List<? extends CharSequence>>", "java.util.List<java.util.List<? extends CharSequence>>");
  }

  @Test
  public void testLeftIsRawType_01() {
    this.isAssignableFrom("java.util.Collection", "java.util.List<? super String>");
  }

  @Test
  public void testLeftIsRawType_02() {
    this.isAssignableFrom("java.util.Collection", "java.util.List<? extends String>");
  }

  @Test
  public void testLeftIsRawType_03() {
    this.isAssignableFrom("java.util.Collection", "java.util.List<String>");
  }

  @Test
  public void testRightIsRawType_01() {
    this.isAssignableFrom("java.util.Collection<? super String>", "java.util.List");
  }

  @Test
  public void testRightIsRawType_02() {
    this.isAssignableFrom("java.util.Collection<? extends String>", "java.util.List");
  }

  @Test
  public void testRightIsRawType_03() {
    this.isAssignableFrom("java.util.Collection<String>", "java.util.List");
  }

  @Test
  public void testInterfaceConformsToObject_01() {
    this.isAssignableFrom("Object", "CharSequence");
  }

  @Test
  public void testInterfaceConformsToObject_02() {
    this.isAssignableFrom("Object", "Iterable<CharSequence>");
  }

  @Test
  public void testLowerBoundTypeParameter() {
    this.isAssignableFrom("java.util.List<? super String>", "java.util.List<? super CharSequence>");
    this.isAssignableFrom("java.util.List<? super CharSequence>", "java.util.List<? super String>");
  }

  @Test
  public void testLowerBoundTypeParameterAndInvariant_01() {
    this.isAssignableFrom("Iterable<? super String>", "java.util.List<CharSequence>");
    this.isAssignableFrom("Iterable<? super CharSequence>", "java.util.List<? super String>");
  }

  @Test
  public void testLowerBoundTypeParameterAndInvariant_02() {
    this.isAssignableFrom("Iterable<? super String>", "Iterable<CharSequence>");
    this.isAssignableFrom("Iterable<? super CharSequence>", "Iterable<? super String>");
  }

  @Test
  public void testLowerBoundAndUpperBound_01() {
    this.isAssignableFrom("Iterable<? super CharSequence>", "Iterable<? extends String>");
    this.isAssignableFrom("Iterable<? extends CharSequence>", "Iterable<? super String>");
  }

  @Test
  public void testWildcardAndInvariant_01() {
    this.isAssignableFrom("Iterable<?>", "Iterable<String>");
    this.isAssignableFrom("Iterable<? extends Object>", "Iterable<String>");
  }

  @Test
  public void testWildcardAndUpperBound_01() {
    this.isAssignableFrom("Iterable<?>", "Iterable<? extends String>");
    this.isAssignableFrom("Iterable<? extends Object>", "Iterable<? extends String>");
  }

  @Test
  public void testWildcardAndLowerBound_01() {
    this.isAssignableFrom("Iterable<?>", "Iterable<? super String>");
    this.isAssignableFrom("Iterable<? extends Object>", "Iterable<? super String>");
  }

  @Test
  public void testBoundTypeParameter_01() {
    this.isAssignableFrom("Iterable<CharSequence>", "org.eclipse.xtend.core.tests.typesystem.CharIterable");
    this.isNotAssignableFrom("org.eclipse.xtend.core.tests.typesystem.CharIterable", "Iterable<Character>");
  }

  @Test
  public void testBoundTypeParameter_02() {
    this.isAssignableFrom("Iterable<Object>", "org.eclipse.xtend.core.tests.typesystem.CharIterable");
    this.isNotAssignableFrom("org.eclipse.xtend.core.tests.typesystem.CharIterable", "Iterable<Object>");
  }

  @Test
  public void testUpperBoundTypeParameter() {
    this.isAssignableFrom("java.util.List<? extends String>", "java.util.List<? extends CharSequence>");
    this.isAssignableFrom("java.util.List<? extends CharSequence>", "java.util.List<? extends String>");
  }

  @Test
  public void testUpperBoundTypeParameter_02() {
    this.isAssignableFrom("java.util.List<? extends CharSequence>", "java.util.List<? extends String>");
  }

  @Test
  public void testInvariantTypeParameter_01() {
    this.isAssignableFrom("java.util.Collection<String>", "java.util.List<CharSequence>");
    this.isAssignableFrom("java.util.Collection<String>", "java.util.List<String>");
    this.isAssignableFrom("java.util.Collection<CharSequence>", "java.util.List<String>");
  }

  @Test
  public void testInvariantTypeParameter_02() {
    this.isAssignableFrom("java.util.Map<? extends CharSequence, ? extends Number>", "java.util.Map<? extends String, ? extends Integer>");
    this.isAssignableFrom("java.util.Map<? extends CharSequence, ? extends Number>", "java.util.Map<String, Integer>");
  }

  @Test
  public void testInvariantTypeParameter_03() {
    this.isAssignableFrom("Iterable<Iterable<String>>", "Iterable<Iterable<CharSequence>>");
    this.isAssignableFrom("Iterable<Iterable<CharSequence>>", "Iterable<Iterable<String>>");
  }

  @Test
  @Override
  public void testTypeParameter_08() {
    this.isAssignableFrom(Pair.<String, String>of("Iterable<T>", "T extends CharSequence"), "org.eclipse.xtend.core.tests.typesystem.CharIterable<String>");
    this.isAssignableFrom(Pair.<String, String>of("Iterable<T>", "T extends CharSequence"), "org.eclipse.xtend.core.tests.typesystem.CharIterable<CharSequence>");
    this.isAssignableFrom(Pair.<String, String>of("Iterable<T>", "T extends CharSequence"), "org.eclipse.xtend.core.tests.typesystem.CharIterable<? extends CharSequence>");
    this.isAssignableFrom(Pair.<String, String>of("Iterable<? extends T>", "T extends CharSequence"), "org.eclipse.xtend.core.tests.typesystem.CharIterable<String>");
    this.isAssignableFrom(Pair.<String, String>of("Iterable<? extends T>", "T extends CharSequence"), "org.eclipse.xtend.core.tests.typesystem.CharIterable<CharSequence>");
    this.isAssignableFrom(Pair.<String, String>of("Iterable<? extends T>", "T extends CharSequence"), "org.eclipse.xtend.core.tests.typesystem.CharIterable<? extends CharSequence>");
    this.isAssignableFrom(Pair.<String, String>of("Iterable<T>", "T extends CharSequence"), "org.eclipse.xtend.core.tests.typesystem.CharIterable");
    this.isAssignableFrom(Pair.<String, String>of("Iterable<T>", "T extends Number"), "org.eclipse.xtend.core.tests.typesystem.CharIterable");
  }

  @Test
  @Override
  public void testTwoTypeParameters_02() {
    this.isAssignableFrom(Pair.<String, String>of("Iterable<T>", "T, V extends T"), "Iterable<V>");
    this.isAssignableFrom(Pair.<String, String>of("Iterable<? extends T>", "T, V extends T"), "Iterable<V>");
    this.isAssignableFrom(Pair.<String, String>of("Iterable<? extends T>", "T, V extends T"), "Iterable<? extends V>");
  }

  @Test
  @Override
  public void testTwoTypeParameters_03() {
    this.isAssignableFrom(Pair.<String, String>of("Iterable<? super V>", "T, V extends T"), "Iterable<? super T>");
    this.isAssignableFrom(Pair.<String, String>of("Iterable<? super T>", "T, V extends T"), "Iterable<? super V>");
  }

  @Test
  @Override
  public void testFunctionTypes_01() {
    this.isAssignableFrom("(String)=>void", "(CharSequence)=>void");
    this.isAssignableFrom("(String)=>void", "(String)=>void");
    this.isAssignableFrom("(CharSequence)=>void", "(String)=>void");
  }

  @Test
  @Override
  public void testFunctionTypes_02() {
    this.isAssignableFrom("(String)=>String", "(CharSequence)=>String");
    this.isAssignableFrom("(String)=>String", "(String)=>String");
    this.isAssignableFrom("(CharSequence)=>String", "(String)=>String");
  }

  @Test
  @Override
  public void testFunctionTypes_03() {
    this.isAssignableFrom("(String)=>CharSequence", "(CharSequence)=>String");
    this.isAssignableFrom("(String)=>CharSequence", "(CharSequence)=>String");
    this.isAssignableFrom("(CharSequence)=>CharSequence", "(String)=>String");
  }

  @Test
  @Override
  public void testFunctionTypes_07() {
    this.isAssignableFrom(Pair.<String, String>of("(T)=>T", "T extends Integer"), "(Integer)=>Integer");
    this.isAssignableFrom(Pair.<String, String>of("(T)=>T", "T extends Integer"), "(int)=>int");
  }

  @Test
  @Override
  public void testFunctionTypes_08() {
    this.isAssignableFrom("()=>long", "()=>int");
    this.isAssignableFrom("()=>int", "()=>long");
  }

  @Test
  @Override
  public void testFunctionTypes_12() {
    this.isAssignableFrom("java.util.ArrayList<(int)=>boolean>", "java.util.ArrayList<$Function1<? super Long, ? extends Boolean>>");
    this.isAssignableFrom("java.util.ArrayList<(int)=>boolean>", "java.util.ArrayList<(long)=>boolean>");
  }

  @Test
  @Override
  public void testFunctionTypeAsParameterized_01() {
    this.isAssignableFrom("$Procedure1<String>", "(CharSequence)=>void");
    this.isAssignableFrom("$Procedure1<? super String>", "(CharSequence)=>void");
    this.isAssignableFrom("$Procedure1<? extends String>", "(CharSequence)=>void");
    this.isAssignableFrom("$Procedure1<String>", "(String)=>void");
    this.isAssignableFrom("$Procedure1<? super String>", "(String)=>void");
    this.isAssignableFrom("$Procedure1<? extends String>", "(String)=>void");
    this.isAssignableFrom("$Procedure1<CharSequence>", "(String)=>void");
    this.isAssignableFrom("$Procedure1<? super CharSequence>", "(String)=>void");
    this.isAssignableFrom("$Procedure1<? extends CharSequence>", "(String)=>void");
  }

  @Test
  @Override
  public void testFunctionTypeAsParameterized_02() {
    this.isAssignableFrom("$Function1<String, String>", "(CharSequence)=>String");
    this.isAssignableFrom("$Function1<? super String, String>", "(CharSequence)=>String");
    this.isAssignableFrom("$Function1<String, ? extends String>", "(CharSequence)=>String");
    this.isAssignableFrom("$Function1<? super String, ? extends String>", "(CharSequence)=>String");
    this.isAssignableFrom("$Function1<String, String>", "(String)=>String");
    this.isAssignableFrom("$Function1<? super String, String>", "(String)=>String");
    this.isAssignableFrom("$Function1<String, ? extends String>", "(String)=>String");
    this.isAssignableFrom("$Function1<? super String, ? extends String>", "(String)=>String");
    this.isAssignableFrom("$Function1<CharSequence, String>", "(String)=>String");
    this.isAssignableFrom("$Function1<? super CharSequence, String>", "(String)=>String");
    this.isAssignableFrom("$Function1<CharSequence, ? extends String>", "(String)=>String");
    this.isAssignableFrom("$Function1<? super CharSequence, ? extends String>", "(String)=>String");
  }

  @Test
  @Override
  public void testFunctionTypeAsParameterized_03() {
    this.isAssignableFrom("$Function1<String, CharSequence>", "(CharSequence)=>String");
    this.isAssignableFrom("$Function1<? super String, CharSequence>", "(CharSequence)=>String");
    this.isAssignableFrom("$Function1<String, ? extends CharSequence>", "(CharSequence)=>String");
    this.isAssignableFrom("$Function1<? super String, ? extends CharSequence>", "(CharSequence)=>String");
    this.isAssignableFrom("$Function1<String, CharSequence>", "(String)=>String");
    this.isAssignableFrom("$Function1<? super String, CharSequence>", "(String)=>String");
    this.isAssignableFrom("$Function1<String, ? extends CharSequence>", "(String)=>String");
    this.isAssignableFrom("$Function1<? super String, ? extends CharSequence>", "(String)=>String");
    this.isAssignableFrom("$Function1<CharSequence, CharSequence>", "(String)=>String");
    this.isAssignableFrom("$Function1<? super CharSequence, CharSequence>", "(String)=>String");
    this.isAssignableFrom("$Function1<CharSequence, ? extends CharSequence>", "(String)=>String");
    this.isAssignableFrom("$Function1<? super CharSequence, ? extends CharSequence>", "(String)=>String");
  }

  @Test
  @Override
  public void testFunctionTypeAsParameterized_07() {
    this.isAssignableFrom(Pair.<String, String>of("$Function1<T, T>", "T extends Integer"), "(Integer)=>Integer");
    this.isAssignableFrom(Pair.<String, String>of("$Function1<? super T, T>", "T extends Integer"), "(Integer)=>Integer");
    this.isAssignableFrom(Pair.<String, String>of("$Function1<T, ? extends T>", "T extends Integer"), "(Integer)=>Integer");
    this.isAssignableFrom(Pair.<String, String>of("$Function1<? super T, ? extends T>", "T extends Integer"), "(Integer)=>Integer");
    this.isAssignableFrom(Pair.<String, String>of("$Function1<T, T>", "T extends Integer"), "(int)=>int");
    this.isAssignableFrom(Pair.<String, String>of("$Function1<? super T, T>", "T extends Integer"), "(int)=>int");
    this.isAssignableFrom(Pair.<String, String>of("$Function1<T, ? extends T>", "T extends Integer"), "(int)=>int");
    this.isAssignableFrom(Pair.<String, String>of("$Function1<? super T, ? extends T>", "T extends Integer"), "(int)=>int");
  }

  @Test
  @Override
  public void testFunctionTypeAsParameterized_08() {
    this.isAssignableFrom("(String)=>void", "$Procedure1<CharSequence>");
    this.isAssignableFrom("(String)=>void", "$Procedure1<String>");
    this.isAssignableFrom("(CharSequence)=>void", "$Procedure1<String>");
  }

  @Test
  @Override
  public void testFunctionTypeAsParameterized_09() {
    this.isAssignableFrom("(String)=>String", "$Function1<CharSequence,String>");
    this.isAssignableFrom("(CharSequence)=>String", "$Function1<String, String>");
  }

  @Test
  @Override
  public void testFunctionTypeAsParameterized_10() {
    this.isAssignableFrom("(String)=>CharSequence", "$Function1<CharSequence, String>");
    this.isAssignableFrom("(String)=>CharSequence", "$Function1<CharSequence, String>");
    this.isAssignableFrom("(CharSequence)=>CharSequence", "$Function1<String, String>");
  }

  @Test
  @Override
  public void testFunctionTypeAsParameterized_14() {
    this.isAssignableFrom(Pair.<String, String>of("(T)=>T", "T extends Integer"), "$Function1<Integer, Integer>");
  }

  @Test
  @Override
  public void testDemandConvertedFunctionType_01() {
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<String>", "(CharSequence)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<? super String>", "(CharSequence)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<String>", "(Object)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<? super String>", "(Object)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<String>", "(String)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<? super String>", "(String)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<CharSequence>", "(String)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<? super CharSequence>", "(String)=>void");
  }

  @Test
  @Override
  public void testDemandConvertedFunctionType_05() {
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<Integer>", "(int)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<? super Integer>", "(int)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<? extends Integer>", "(int)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<Number>", "(int)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<? extends Number>", "(int)=>void");
    this.isAssignableFrom("org.eclipse.xtext.util.IAcceptor<? super Number>", "(int)=>void");
  }

  @Test
  @Override
  public void testDemandConvertedFunctionType_06() {
    this.isAssignableFrom("Comparable<Integer>", "(int)=>int");
    this.isAssignableFrom("Comparable<String>", "(int)=>int");
  }

  @Test
  @Override
  public void testBug409847_01() {
    this.isAssignableFrom("java.lang.Class<? extends java.lang.Iterable<?>>", "java.lang.Class<java.util.ArrayList>");
    this.isAssignableFrom("java.lang.Class<? extends java.lang.Iterable<?>>", "java.lang.Class<java.util.ArrayList<java.lang.Integer>>");
    this.isAssignableFrom("java.lang.Class<? extends java.lang.Iterable>", "java.lang.Class<java.util.ArrayList>");
  }

  @Test
  @Override
  public void testBug409847_02() {
    this.isAssignableFrom("java.lang.Class<java.util.ArrayList<?>>", "java.lang.Class<java.util.ArrayList>");
  }

  @Test
  @Override
  public void testBug409847_03() {
    this.isAssignableFrom("java.lang.Class<java.util.ArrayList>", "java.lang.Class<java.util.ArrayList<?>>");
  }

  @Test
  @Override
  public void testBug409847_04() {
    this.isAssignableFrom("java.lang.Iterable<? extends java.lang.Iterable<?>>", "java.util.ArrayList<java.util.ArrayList>");
    this.isAssignableFrom("java.lang.Iterable<? extends java.lang.Iterable<?>>", "java.util.ArrayList<java.util.ArrayList<java.lang.Integer>>");
    this.isAssignableFrom("java.lang.Iterable<? extends java.lang.Iterable>", "java.util.ArrayList<java.util.ArrayList>");
  }

  @Test
  @Override
  public void testStringIsNotComparableInteger() {
    this.isAssignableFrom("java.lang.Comparable<? extends Integer>", "String");
    this.isAssignableFrom("java.lang.Comparable<Integer>", "String");
  }

  @Test
  @Override
  public void testClassStringIntMapIsClassMap() {
    this.isAssignableFrom("java.lang.Class<? extends java.util.Map>", "java.lang.Class<org.eclipse.xtend.core.tests.typesystem.StringIntMap>");
    this.isAssignableFrom("java.lang.Class<? super java.util.Map>", "java.lang.Class<org.eclipse.xtend.core.tests.typesystem.StringIntMap>");
    this.isAssignableFrom("java.lang.Class<? super org.eclipse.xtend.core.tests.typesystem.StringIntMap>", "java.lang.Class<java.util.Map>");
  }

  @Test
  @Override
  public void testClassMapIsClassMapStringInteger() {
    this.isAssignableFrom("java.lang.Class<? extends java.util.Map>", "java.lang.Class<? extends java.util.Map<String, Integer>>");
    this.isAssignableFrom("java.lang.Class<? extends java.util.Map>", "java.lang.Class<? extends java.util.Map<?, ?>>");
    this.isAssignableFrom("java.lang.Class<? super java.util.Map>", "java.lang.Class<? super java.util.Map<String, Integer>>");
    this.isAssignableFrom("java.lang.Class<? super java.util.Map>", "java.lang.Class<? super java.util.Map<?, ?>>");
    this.isAssignableFrom("java.lang.Class<? super java.util.Map<String, Integer>>", "java.lang.Class<? super java.util.Map>");
    this.isAssignableFrom("java.lang.Class<? super java.util.Map<?, ?>>", "java.lang.Class<? super java.util.Map>");
  }

  @Test
  @Override
  public void testInnerClasses_03() {
    this.isAssignableFrom("test.InnerClasses.SubString<Number>.Inner<Number>", "test.InnerClasses.Super<String>.Inner<Integer>");
    this.isAssignableFrom("test.InnerClasses.Super<String>.Inner<Integer>", "test.InnerClasses.SubString<Number>.Inner<Number>");
  }

  @Test
  @Override
  public void testInnerClasses_04() {
    this.isAssignableFrom("test.InnerClasses.SubString<Number>.Inner<? extends Number>", "test.InnerClasses.Super<String>.Inner<Integer>");
    this.isAssignableFrom("test.InnerClasses.Super<String>.Inner<Integer>", "test.InnerClasses.SubString<Number>.Inner<? extends Number>");
  }

  @Test
  @Override
  public void testInnerClasses_07() {
    this.isAssignableFrom("test.InnerClasses.Super<Number>.Inner<Number>", "test.InnerClasses.Super<String>.Inner<Number>");
    this.isAssignableFrom("test.InnerClasses.Super<String>.Inner<Number>", "test.InnerClasses.Super<Number>.Inner<Number>");
  }

  @Test
  @Override
  public void testInnerClasses_11() {
    this.isAssignableFrom("test.InnerClasses.Super<String>.Inner<String>", "test.InnerClasses.Sub<String>.SubInner2<Number>");
    this.isAssignableFrom("test.InnerClasses.Super<String>.Inner<String>", "test.InnerClasses.Sub<Number>.SubInner2<Number>");
  }

  @Test
  @Override
  public void testInnerClasses_12() {
    this.isAssignableFrom("test.InnerClasses.Super<String>.Inner<String>", "test.InnerClasses.Sub<String>.SubInner2<Number>");
    this.isAssignableFrom("test.InnerClasses.Super<String>.Inner<String>", "test.InnerClasses.Sub<Number>.SubInner2<Number>");
    this.isAssignableFrom("test.InnerClasses.Super<String>.Inner<Number>", "test.InnerClasses.Sub<Number>.SubInner2<Number>");
  }

  @Test
  @Override
  public void testInnerClasses_13() {
    this.isAssignableFrom("test.InnerClasses.Super<String>.Inner<Number>", "test.InnerClasses.Sub<String>.SubInner<Number>");
    this.isNotAssignableFrom("test.InnerClasses.Super<String>.SubInner<Number>", "test.InnerClasses.Sub<String>.SubInner2<Number>");
    this.isAssignableFrom("test.InnerClasses.Super<String>.Inner<String>", "test.InnerClasses.Sub<Number>.SubInner<Number>");
  }

  @Test
  @Override
  public void testInnerClasses_15() {
    this.isAssignableFrom("test.InnerClasses.Super3<String>.Inner<Number>", "test.InnerClasses.Sub5<Number>");
    this.isAssignableFrom("test.InnerClasses.Super3<String>.Inner<String>", "test.InnerClasses.Sub5<Number>");
    this.isAssignableFrom("test.InnerClasses.Super3<Number>.Inner<Number>", "test.InnerClasses.Sub5<Number>");
  }
}
