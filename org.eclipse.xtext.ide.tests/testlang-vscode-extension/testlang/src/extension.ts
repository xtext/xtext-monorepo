/*******************************************************************************
 * Copyright (c) 2016 TypeFox GmbH (http://www.typefox.io) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
'use strict';

import * as net from 'net';

import {Trace} from 'vscode-jsonrpc';
import { window, workspace, commands, ExtensionContext, Uri } from 'vscode';
import { LanguageClient, LanguageClientOptions, StreamInfo, Position as LSPosition, Location as LSLocation } from 'vscode-languageclient/node';

export function activate(context: ExtensionContext) {
	let serverOptions = {
		port: 5007
	}
	let serverInfo = () => {
		// Connect to the language server via a socket channel
		let socket = net.connect(serverOptions);
		let result: StreamInfo = {
			writer: socket,
			reader: socket
		}
		return Promise.resolve(result);
	}
	
	let clientOptions: LanguageClientOptions = {
		documentSelector: ['testlang']
	}
	
	// Create the language client and start the client.
	

	let client = new LanguageClient('xtext.server', 'Xtext Server', serverInfo, clientOptions)
	client.onReady().then(() => {
		client.onNotification("buildHappened", (o: any) => {
			console.log(o);
		});
	});
	let disposable = client.start();
	
	// Push the disposable to the context's subscriptions so that the 
	// client can be deactivated on extension deactivation
	context.subscriptions.push(disposable);
}