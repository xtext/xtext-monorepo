/**
 * generated by Xtext
 */
package org.eclipse.xtext.xtextTest;

import org.eclipse.emf.common.util.EList;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Group</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link org.eclipse.xtext.xtextTest.Group#getElements <em>Elements</em>}</li>
 * </ul>
 *
 * @see org.eclipse.xtext.xtextTest.XtextTestPackage#getGroup()
 * @model
 * @generated
 */
public interface Group extends AbstractElement
{
  /**
   * Returns the value of the '<em><b>Elements</b></em>' containment reference list.
   * The list contents are of type {@link org.eclipse.xtext.xtextTest.AbstractElement}.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @return the value of the '<em>Elements</em>' containment reference list.
   * @see org.eclipse.xtext.xtextTest.XtextTestPackage#getGroup_Elements()
   * @model containment="true"
   * @generated
   */
  EList<AbstractElement> getElements();

} // Group
