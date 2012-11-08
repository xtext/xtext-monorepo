package org.eclipse.xtend.core.tests.formatting

import java.util.Collection
import javax.inject.Inject
import org.eclipse.xtend.core.formatting.MapBasedConfigurationValues
import org.eclipse.xtend.core.formatting.TextReplacement
import org.eclipse.xtend.core.formatting.XtendFormatter
import org.eclipse.xtend.core.formatting.XtendFormatterConfigKeys
import org.eclipse.xtend.core.tests.compiler.batch.XtendInjectorProvider
import org.eclipse.xtend.core.xtend.XtendFile
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.eclipse.xtext.resource.XtextResource
import org.junit.Assert
import org.junit.runner.RunWith

@RunWith(typeof(XtextRunner))
@InjectWith(typeof(XtendInjectorProvider))
abstract class AbstractFormatterTest {
	@Inject extension ParseHelper<XtendFile>
	@Inject XtendFormatter formatter
	@Inject XtendFormatterConfigKeys keys
	
	def assertFormatted(CharSequence toBeFormatted) {
		assertFormatted(toBeFormatted, toBeFormatted /* .parse.flattenWhitespace  */)
	}
	
	def private toFile(CharSequence expression) '''
		package foo
		
		class bar {
			def baz() {
				�expression�
			}
		}
	'''
	
	def private toMember(CharSequence expression) '''
		package foo
		
		class bar {
			�expression�
		}
	'''
	
	def assertFormattedExpression((MapBasedConfigurationValues<XtendFormatterConfigKeys>) => void cfg, CharSequence toBeFormatted) {
		assertFormatted(cfg, toBeFormatted.toFile, toBeFormatted.toFile)
	}
	
	def assertFormattedExpression(CharSequence toBeFormatted) {
		assertFormatted(toBeFormatted.toFile, toBeFormatted.toFile)
	}
	
	def assertFormattedExpression(String expectation, CharSequence toBeFormatted) {
		assertFormatted(expectation.toFile, toBeFormatted.toFile)
	}
	
	def assertFormattedMember(String expectation, CharSequence toBeFormatted) {
		assertFormatted(expectation.toMember, toBeFormatted.toMember)
	}
	
	def assertFormattedMember((MapBasedConfigurationValues<XtendFormatterConfigKeys>) => void cfg, String expectation, CharSequence toBeFormatted) {
		assertFormatted(cfg, expectation.toMember, toBeFormatted.toMember)
	}
	
	def assertFormattedMember((MapBasedConfigurationValues<XtendFormatterConfigKeys>) => void cfg, String expectation) {
		assertFormatted(cfg, expectation.toMember, expectation.toMember)
	}
	
	def assertFormattedMember(String expectation) {
		assertFormatted(expectation.toMember, expectation.toMember)
	}
	
	def createMissingEditReplacements(XtextResource res, Collection<TextReplacement> edits) {
		val offsets = edits.map[offset].toSet
		val result = <TextReplacement>newArrayList
		var lastOffset = 0
		for(leaf:res.parseResult.rootNode.leafNodes) 
			if(!leaf.hidden || !leaf.text.trim.empty) {
				if(!offsets.contains(lastOffset))
					result += new TextReplacement(lastOffset, leaf.offset - lastOffset, "!!")
				lastOffset = leaf.offset + leaf.length
			}
		result
	}
	
	def assertFormatted((MapBasedConfigurationValues<XtendFormatterConfigKeys>) => void cfg, CharSequence expectation) {
		assertFormatted(cfg, expectation, expectation)
	}
	
	def assertFormatted(CharSequence expectation, CharSequence toBeFormatted) {
		assertFormatted(null, expectation, toBeFormatted)
	}
	
	def assertFormatted((MapBasedConfigurationValues<XtendFormatterConfigKeys>) => void cfg, CharSequence expectation, CharSequence toBeFormatted) {
		val parsed = toBeFormatted.parse
		Assert::assertEquals(parsed.eResource.errors.join("\n"), 0, parsed.eResource.errors.size)
		val oldDocument = (parsed.eResource as XtextResource).parseResult.rootNode.text
		val rc = new MapBasedConfigurationValues<XtendFormatterConfigKeys>(keys)

		rc.put(keys.maxLineWidth, 80)
		if(cfg != null)
			cfg.apply(rc)

		formatter.allowIdentityEdits = true
		
		// Step 1: Ensure formatted document equals expectation 
		val edits = <TextReplacement>newLinkedHashSet
		edits += formatter.format(parsed.eResource as XtextResource, 0, oldDocument.length, rc)
		edits += createMissingEditReplacements(parsed.eResource as XtextResource, edits)
		val newDocument = oldDocument.applyEdits(edits)
		try {
			Assert::assertEquals(expectation.toString, newDocument.toString)
		} catch(AssertionError e) {
			println(oldDocument.applyDebugEdits(edits))
			println()
			throw e
		}
		
		// Step 2: Ensure formatting the document again doesn't change the document
		val parsed2 = newDocument.parse
		Assert::assertEquals(0, parsed2.eResource.errors.size)
		val edits2 = formatter.format(parsed2.eResource as XtextResource, 0, newDocument.length, rc)
		val newDocument2 = newDocument.applyEdits(edits2)
		try {
			Assert::assertEquals(newDocument.toString, newDocument2.toString)
		} catch(AssertionError e) {
			println(newDocument.applyDebugEdits(edits2))
			println()
			throw e
		}
	}
	
	def protected String applyEdits(String oldDocument, Collection<TextReplacement> edits) {
		var lastOffset = 0
		val newDocument = new StringBuilder()
		for(edit:edits.sortBy[offset]) {
			newDocument.append(oldDocument.substring(lastOffset, edit.offset))
			newDocument.append(edit.text)
			lastOffset = edit.offset + edit.length
		}
		newDocument.append(oldDocument.substring(lastOffset, oldDocument.length))
		newDocument.toString
	}
	
	def protected String applyDebugEdits(String oldDocument, Collection<TextReplacement> edits) {
		var lastOffset = 0
		val debugTrace = new StringBuilder()
		for(edit:edits.sortBy[offset]) {
			debugTrace.append(oldDocument.substring(lastOffset, edit.offset))
			debugTrace.append('''[�oldDocument.substring(edit.offset, edit.offset + edit.length)�|�edit.text�]''')
			lastOffset = edit.offset + edit.length
		}
		debugTrace.append(oldDocument.substring(lastOffset, oldDocument.length))
		debugTrace.toString
	}
}
