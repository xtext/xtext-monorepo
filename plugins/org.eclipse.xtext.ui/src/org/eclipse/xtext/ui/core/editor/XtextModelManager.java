/*******************************************************************************
 * Copyright (c) 2008 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 *******************************************************************************/
package org.eclipse.xtext.ui.core.editor;

import java.util.ArrayList;
import java.util.List;

import org.apache.tools.ant.filters.StringInputStream;
import org.eclipse.emf.common.notify.Notifier;
import org.eclipse.jface.text.BadLocationException;
import org.eclipse.jface.text.IDocument;
import org.eclipse.jface.text.IRegion;
import org.eclipse.jface.text.Region;
import org.eclipse.xtext.ILanguageFacade;
import org.eclipse.xtext.core.parser.IParseErrorHandler;
import org.eclipse.xtext.core.parsetree.AbstractNode;
import org.eclipse.xtext.core.parsetree.NodeAdapter;
import org.eclipse.xtext.ui.core.internal.CoreLog;
import org.eclipse.xtext.ui.core.language.LanguageDescriptor;

/**
 * @author Dennis H�bner - Initial contribution and API
 * 
 */
public class XtextModelManager {

	private final class ParseErrorHandlerImpl implements IParseErrorHandler {
		public void handleParserError(int line, int offset, int length,
				int token, String text, String message, Object context) {
			getErrors().add(
					new ParseError(line, offset, length, token, text, message,
							context));
		}
	}

	public final class ParseError {
		int line, offset, length, token;
		String text, message;
		Object context;

		public ParseError(int line, int offset, int length, int token,
				String text, String message, Object context) {
			super();
			this.line = line;
			this.offset = offset;
			this.length = length;
			this.token = token;
			this.text = text;
			this.message = message;
			this.context = context;
		}
	}

	private List<ParseError> errors = new ArrayList<ParseError>();
	private final LanguageDescriptor languageDescriptor;
	private AbstractNode rootNode;

	public XtextModelManager(LanguageDescriptor languageDescriptor) {
		this.languageDescriptor = languageDescriptor;
	}

	public AbstractNode getCurrentAST() {
		return rootNode;
	}

	public boolean hasErrors() {
		return !getErrors().isEmpty();
	}

	private void parseTree(IDocument document, IRegion region) {
		rootNode = null;
		getErrors().clear();
		String content = document.get();
		try {
			content = document.get(region.getOffset(), region.getLength());
		} catch (BadLocationException e) {
			CoreLog.logError(e);
		}
		ILanguageFacade languageFacade = languageDescriptor.getLanguageFacade();
		Notifier object = (Notifier) languageFacade.getParser()
				.parse(new StringInputStream(content),
						languageFacade.getElementFactory(),
						new ParseErrorHandlerImpl());
		if (object != null) {
			NodeAdapter adapter = (NodeAdapter) object.eAdapters().get(0);
			rootNode = adapter.getParserNode();
		}
	}

	public void parseTree(IDocument doc) {
		parseTree(doc, new Region(0, doc.getLength()));
	}

	public LanguageDescriptor getLanguageDescriptor() {
		return languageDescriptor;
	}

	public List<ParseError> getErrors() {
		return errors;
	}

}
