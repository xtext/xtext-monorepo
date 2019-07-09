/*
 * generated by Xtext
 */
package org.eclipse.xtext.example.homeautomation.ui.outline

import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.example.homeautomation.ruleEngine.Rule
import org.eclipse.xtext.ui.editor.outline.IOutlineNode
import org.eclipse.xtext.ui.editor.outline.impl.DefaultOutlineTreeProvider

/**
 * Customization of the default outline structure.
 *
 * See https://www.eclipse.org/Xtext/documentation/304_ide_concepts.html#outline
 */
class RuleEngineOutlineTreeProvider extends DefaultOutlineTreeProvider {

	override _createChildren(IOutlineNode parentNode, EObject modelElement) {
		if (!(modelElement instanceof Rule))
			super._createChildren(parentNode, modelElement)
	}

	override _isLeaf(EObject modelElement) {
		if (modelElement instanceof Rule)
			return true
		else
			return super._isLeaf(modelElement)
	}
}
