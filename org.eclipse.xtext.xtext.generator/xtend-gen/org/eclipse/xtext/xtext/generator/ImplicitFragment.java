/**
 * Copyright (c) 2015, 2020 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 * 
 * SPDX-License-Identifier: EPL-2.0
 */
package org.eclipse.xtext.xtext.generator;

import com.google.inject.Inject;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtend2.lib.StringConcatenationClient;
import org.eclipse.xtext.Grammar;
import org.eclipse.xtext.GrammarUtil;
import org.eclipse.xtext.resource.containers.IAllContainersState;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Extension;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xtext.generator.model.GuiceModuleAccess;
import org.eclipse.xtext.xtext.generator.model.ManifestAccess;
import org.eclipse.xtext.xtext.generator.model.PluginXmlAccess;
import org.eclipse.xtext.xtext.generator.model.TypeReference;
import org.eclipse.xtext.xtext.generator.xbase.XbaseUsageDetector;

/**
 * The ImplicitFragment is added in the first slot to all language configurations.
 */
@SuppressWarnings("all")
class ImplicitFragment extends AbstractStubGeneratingFragment {
  @Inject
  @Extension
  private XbaseUsageDetector _xbaseUsageDetector;

  @Inject
  @Extension
  private XtextGeneratorNaming naming;

  @Override
  public void generate() {
    ManifestAccess _manifest = this.getProjectConfig().getRuntime().getManifest();
    boolean _tripleNotEquals = (_manifest != null);
    if (_tripleNotEquals) {
      this.getProjectConfig().getRuntime().getManifest().getRequiredBundles().addAll(
        Collections.<String>unmodifiableList(CollectionLiterals.<String>newArrayList("org.eclipse.xtext", "org.eclipse.xtext.util")));
      boolean _isGenerateXtendStub = this.isGenerateXtendStub();
      if (_isGenerateXtendStub) {
        Set<String> _requiredBundles = this.getProjectConfig().getRuntime().getManifest().getRequiredBundles();
        String _xtendLibVersionLowerBound = this.getProjectConfig().getRuntime().getXtendLibVersionLowerBound();
        String _plus = ("org.eclipse.xtend.lib;bundle-version=\"" + _xtendLibVersionLowerBound);
        String _plus_1 = (_plus + "\"");
        _requiredBundles.add(_plus_1);
      }
      this.getProjectConfig().getRuntime().getManifest().getImportedPackages().add("org.apache.log4j");
    }
    ManifestAccess _manifest_1 = this.getProjectConfig().getEclipsePlugin().getManifest();
    boolean _tripleNotEquals_1 = (_manifest_1 != null);
    if (_tripleNotEquals_1) {
      this.getProjectConfig().getEclipsePlugin().getManifest().getRequiredBundles().addAll(
        Collections.<String>unmodifiableList(CollectionLiterals.<String>newArrayList("org.eclipse.xtext.ui", "org.eclipse.xtext.ui.shared", "org.eclipse.ui.editors", "org.eclipse.ui")));
      boolean _isGenerateXtendStub_1 = this.isGenerateXtendStub();
      if (_isGenerateXtendStub_1) {
        Set<String> _requiredBundles_1 = this.getProjectConfig().getEclipsePlugin().getManifest().getRequiredBundles();
        String _xtendLibVersionLowerBound_1 = this.getProjectConfig().getRuntime().getXtendLibVersionLowerBound();
        String _plus_2 = ("org.eclipse.xtend.lib;bundle-version=\"" + _xtendLibVersionLowerBound_1);
        String _plus_3 = (_plus_2 + "\"");
        _requiredBundles_1.add(_plus_3);
      }
      this.getProjectConfig().getEclipsePlugin().getManifest().getImportedPackages().add("org.apache.log4j");
    }
    PluginXmlAccess _pluginXml = this.getProjectConfig().getEclipsePlugin().getPluginXml();
    boolean _tripleNotEquals_2 = (_pluginXml != null);
    if (_tripleNotEquals_2) {
      List<CharSequence> _entries = this.getProjectConfig().getEclipsePlugin().getPluginXml().getEntries();
      CharSequence _implicitPluginXmlEnties = this.getImplicitPluginXmlEnties(this.getGrammar());
      _entries.add(_implicitPluginXmlEnties);
    }
    StringConcatenationClient _client = new StringConcatenationClient() {
      @Override
      protected void appendTo(StringConcatenationClient.TargetStringConcatenation _builder) {
        TypeReference _typeRef = TypeReference.typeRef("org.eclipse.xtext.ui.shared.Access");
        _builder.append(_typeRef);
        _builder.append(".getJavaProjectsState()");
      }
    };
    final StringConcatenationClient expression = _client;
    final GuiceModuleAccess.BindingFactory bindingFactory = new GuiceModuleAccess.BindingFactory().addTypeToProviderInstance(TypeReference.typeRef(IAllContainersState.class), expression);
    boolean _inheritsXbase = this._xbaseUsageDetector.inheritsXbase(this.getGrammar());
    if (_inheritsXbase) {
      bindingFactory.addTypeToType(TypeReference.typeRef("org.eclipse.xtext.ui.editor.model.XtextDocumentProvider"), 
        TypeReference.typeRef("org.eclipse.xtext.xbase.ui.editor.XbaseDocumentProvider")).addTypeToType(TypeReference.typeRef("org.eclipse.xtext.ui.generator.trace.OpenGeneratedFileHandler"), 
        TypeReference.typeRef("org.eclipse.xtext.xbase.ui.generator.trace.XbaseOpenGeneratedFileHandler"));
    }
    bindingFactory.contributeTo(this.getLanguage().getEclipsePluginGenModule());
  }

  public CharSequence getImplicitPluginXmlEnties(final Grammar it) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("<extension");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("point=\"org.eclipse.ui.editors\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<editor");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("class=\"");
    TypeReference _eclipsePluginExecutableExtensionFactory = this.naming.getEclipsePluginExecutableExtensionFactory(it);
    _builder.append(_eclipsePluginExecutableExtensionFactory, "\t\t");
    _builder.append(":org.eclipse.xtext.ui.editor.XtextEditor\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("contributorClass=\"org.eclipse.ui.editors.text.TextEditorActionContributor\"");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("default=\"true\"");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("extensions=\"");
    String _join = IterableExtensions.join(this.getLanguage().getFileExtensions(), ",");
    _builder.append(_join, "\t\t");
    _builder.append("\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("id=\"");
    String _name = it.getName();
    _builder.append(_name, "\t\t");
    _builder.append("\"");
    _builder.newLineIfNotEmpty();
    {
      boolean _inheritsXbase = this._xbaseUsageDetector.inheritsXbase(this.getGrammar());
      if (_inheritsXbase) {
        _builder.append("\t\t");
        _builder.append("matchingStrategy=\"");
        TypeReference _eclipsePluginExecutableExtensionFactory_1 = this.naming.getEclipsePluginExecutableExtensionFactory(it);
        _builder.append(_eclipsePluginExecutableExtensionFactory_1, "\t\t");
        _builder.append(":org.eclipse.xtext.xbase.ui.editor.JavaEditorInputMatcher\"");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.append("\t\t");
    _builder.append("name=\"");
    String _simpleName = GrammarUtil.getSimpleName(it);
    _builder.append(_simpleName, "\t\t");
    _builder.append(" Editor\">");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("</editor>");
    _builder.newLine();
    _builder.append("</extension>");
    _builder.newLine();
    _builder.append("<extension");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("point=\"org.eclipse.ui.handlers\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<handler");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("class=\"");
    TypeReference _eclipsePluginExecutableExtensionFactory_2 = this.naming.getEclipsePluginExecutableExtensionFactory(it);
    _builder.append(_eclipsePluginExecutableExtensionFactory_2, "\t\t");
    _builder.append(":org.eclipse.xtext.ui.editor.hyperlinking.OpenDeclarationHandler\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("commandId=\"org.eclipse.xtext.ui.editor.hyperlinking.OpenDeclaration\">");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<activeWhen>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<reference");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("definitionId=\"");
    String _name_1 = it.getName();
    _builder.append(_name_1, "\t\t\t\t");
    _builder.append(".Editor.opened\">");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t");
    _builder.append("</reference>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</activeWhen>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</handler>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<handler");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("class=\"");
    TypeReference _eclipsePluginExecutableExtensionFactory_3 = this.naming.getEclipsePluginExecutableExtensionFactory(it);
    _builder.append(_eclipsePluginExecutableExtensionFactory_3, "\t\t");
    _builder.append(":org.eclipse.xtext.ui.editor.handler.ValidateActionHandler\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("commandId=\"");
    String _name_2 = it.getName();
    _builder.append(_name_2, "\t\t");
    _builder.append(".validate\">");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("<activeWhen>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<reference");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("definitionId=\"");
    String _name_3 = it.getName();
    _builder.append(_name_3, "\t\t\t\t");
    _builder.append(".Editor.opened\">");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t");
    _builder.append("</reference>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</activeWhen>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</handler>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<!-- copy qualified name -->");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<handler");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("class=\"");
    TypeReference _eclipsePluginExecutableExtensionFactory_4 = this.naming.getEclipsePluginExecutableExtensionFactory(it);
    _builder.append(_eclipsePluginExecutableExtensionFactory_4, "\t\t");
    _builder.append(":org.eclipse.xtext.ui.editor.copyqualifiedname.EditorCopyQualifiedNameHandler\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("commandId=\"org.eclipse.xtext.ui.editor.copyqualifiedname.EditorCopyQualifiedName\">");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<activeWhen>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<reference definitionId=\"");
    String _name_4 = it.getName();
    _builder.append(_name_4, "\t\t\t");
    _builder.append(".Editor.opened\" />");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("</activeWhen>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</handler>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<handler");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("class=\"");
    TypeReference _eclipsePluginExecutableExtensionFactory_5 = this.naming.getEclipsePluginExecutableExtensionFactory(it);
    _builder.append(_eclipsePluginExecutableExtensionFactory_5, "\t\t");
    _builder.append(":org.eclipse.xtext.ui.editor.copyqualifiedname.OutlineCopyQualifiedNameHandler\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("commandId=\"org.eclipse.xtext.ui.editor.copyqualifiedname.OutlineCopyQualifiedName\">");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<activeWhen>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<and>");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("<reference definitionId=\"");
    String _name_5 = it.getName();
    _builder.append(_name_5, "\t\t\t\t");
    _builder.append(".XtextEditor.opened\" />");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t\t");
    _builder.append("<iterate>");
    _builder.newLine();
    _builder.append("\t\t\t\t\t");
    _builder.append("<adapt type=\"org.eclipse.xtext.ui.editor.outline.IOutlineNode\" />");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("</iterate>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("</and>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</activeWhen>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</handler>");
    _builder.newLine();
    _builder.append("</extension>");
    _builder.newLine();
    _builder.append("<extension point=\"org.eclipse.core.expressions.definitions\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<definition id=\"");
    String _name_6 = it.getName();
    _builder.append(_name_6, "\t");
    _builder.append(".Editor.opened\">");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("<and>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<reference definitionId=\"isActiveEditorAnInstanceOfXtextEditor\"/>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<with variable=\"activeEditor\">");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("<test property=\"org.eclipse.xtext.ui.editor.XtextEditor.languageName\"");
    _builder.newLine();
    _builder.append("\t\t\t\t\t");
    _builder.append("value=\"");
    String _name_7 = it.getName();
    _builder.append(_name_7, "\t\t\t\t\t");
    _builder.append("\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t\t\t");
    _builder.append("forcePluginActivation=\"true\"/>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("</with>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</and>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</definition>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<definition id=\"");
    String _name_8 = it.getName();
    _builder.append(_name_8, "\t");
    _builder.append(".XtextEditor.opened\">");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("<and>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<reference definitionId=\"isXtextEditorActive\"/>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<with variable=\"activeEditor\">");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("<test property=\"org.eclipse.xtext.ui.editor.XtextEditor.languageName\"");
    _builder.newLine();
    _builder.append("\t\t\t\t\t");
    _builder.append("value=\"");
    String _name_9 = it.getName();
    _builder.append(_name_9, "\t\t\t\t\t");
    _builder.append("\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t\t\t");
    _builder.append("forcePluginActivation=\"true\"/>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("</with>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</and>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</definition>");
    _builder.newLine();
    _builder.append("</extension>");
    _builder.newLine();
    _builder.append("<extension");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("point=\"org.eclipse.ui.preferencePages\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<page");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("class=\"");
    TypeReference _eclipsePluginExecutableExtensionFactory_6 = this.naming.getEclipsePluginExecutableExtensionFactory(it);
    _builder.append(_eclipsePluginExecutableExtensionFactory_6, "\t\t");
    _builder.append(":org.eclipse.xtext.ui.editor.preferences.LanguageRootPreferencePage\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("id=\"");
    String _name_10 = it.getName();
    _builder.append(_name_10, "\t\t");
    _builder.append("\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("name=\"");
    String _simpleName_1 = GrammarUtil.getSimpleName(it);
    _builder.append(_simpleName_1, "\t\t");
    _builder.append("\">");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("<keywordReference id=\"");
    String _namespace = GrammarUtil.getNamespace(it);
    String _plus = (_namespace + ".ui.keyword_");
    String _simpleName_2 = GrammarUtil.getSimpleName(it);
    String _plus_1 = (_plus + _simpleName_2);
    _builder.append(_plus_1, "\t\t");
    _builder.append("\"/>");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("</page>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<page");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("category=\"");
    String _name_11 = it.getName();
    _builder.append(_name_11, "\t\t");
    _builder.append("\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("class=\"");
    TypeReference _eclipsePluginExecutableExtensionFactory_7 = this.naming.getEclipsePluginExecutableExtensionFactory(it);
    _builder.append(_eclipsePluginExecutableExtensionFactory_7, "\t\t");
    _builder.append(":org.eclipse.xtext.ui.editor.syntaxcoloring.SyntaxColoringPreferencePage\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("id=\"");
    String _name_12 = it.getName();
    _builder.append(_name_12, "\t\t");
    _builder.append(".coloring\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("name=\"Syntax Coloring\">");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<keywordReference id=\"");
    String _namespace_1 = GrammarUtil.getNamespace(it);
    String _plus_2 = (_namespace_1 + ".ui.keyword_");
    String _simpleName_3 = GrammarUtil.getSimpleName(it);
    String _plus_3 = (_plus_2 + _simpleName_3);
    _builder.append(_plus_3, "\t\t");
    _builder.append("\"/>");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("</page>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<page");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("category=\"");
    String _name_13 = it.getName();
    _builder.append(_name_13, "\t\t");
    _builder.append("\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("class=\"");
    TypeReference _eclipsePluginExecutableExtensionFactory_8 = this.naming.getEclipsePluginExecutableExtensionFactory(it);
    _builder.append(_eclipsePluginExecutableExtensionFactory_8, "\t\t");
    _builder.append(":org.eclipse.xtext.ui.editor.templates.XtextTemplatePreferencePage\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("id=\"");
    String _name_14 = it.getName();
    _builder.append(_name_14, "\t\t");
    _builder.append(".templates\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("name=\"Templates\">");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<keywordReference id=\"");
    String _namespace_2 = GrammarUtil.getNamespace(it);
    String _plus_4 = (_namespace_2 + ".ui.keyword_");
    String _simpleName_4 = GrammarUtil.getSimpleName(it);
    String _plus_5 = (_plus_4 + _simpleName_4);
    _builder.append(_plus_5, "\t\t");
    _builder.append("\"/>");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("</page>");
    _builder.newLine();
    _builder.append("</extension>");
    _builder.newLine();
    _builder.append("<extension");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("point=\"org.eclipse.ui.propertyPages\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<page");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("class=\"");
    TypeReference _eclipsePluginExecutableExtensionFactory_9 = this.naming.getEclipsePluginExecutableExtensionFactory(it);
    _builder.append(_eclipsePluginExecutableExtensionFactory_9, "\t\t");
    _builder.append(":org.eclipse.xtext.ui.editor.preferences.LanguageRootPreferencePage\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("id=\"");
    String _name_15 = it.getName();
    _builder.append(_name_15, "\t\t");
    _builder.append("\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("name=\"");
    String _simpleName_5 = GrammarUtil.getSimpleName(it);
    _builder.append(_simpleName_5, "\t\t");
    _builder.append("\">");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("<keywordReference id=\"");
    String _namespace_3 = GrammarUtil.getNamespace(it);
    String _plus_6 = (_namespace_3 + ".ui.keyword_");
    String _simpleName_6 = GrammarUtil.getSimpleName(it);
    String _plus_7 = (_plus_6 + _simpleName_6);
    _builder.append(_plus_7, "\t\t");
    _builder.append("\"/>");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("<enabledWhen>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<adapt type=\"org.eclipse.core.resources.IProject\"/>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</enabledWhen>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<filter name=\"projectNature\" value=\"org.eclipse.xtext.ui.shared.xtextNature\"/>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</page>");
    _builder.newLine();
    _builder.append("</extension>");
    _builder.newLine();
    _builder.append("<extension");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("point=\"org.eclipse.ui.keywords\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<keyword");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("id=\"");
    String _namespace_4 = GrammarUtil.getNamespace(it);
    String _plus_8 = (_namespace_4 + ".ui.keyword_");
    String _simpleName_7 = GrammarUtil.getSimpleName(it);
    String _plus_9 = (_plus_8 + _simpleName_7);
    _builder.append(_plus_9, "\t\t");
    _builder.append("\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("label=\"");
    String _simpleName_8 = GrammarUtil.getSimpleName(it);
    _builder.append(_simpleName_8, "\t\t");
    _builder.append("\"/>");
    _builder.newLineIfNotEmpty();
    _builder.append("</extension>");
    _builder.newLine();
    _builder.append("<extension");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("point=\"org.eclipse.ui.commands\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<command");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("description=\"Trigger expensive validation\"");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("id=\"");
    String _name_16 = it.getName();
    _builder.append(_name_16, "\t\t");
    _builder.append(".validate\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("name=\"Validate\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</command>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<!-- copy qualified name -->");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<command");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("id=\"org.eclipse.xtext.ui.editor.copyqualifiedname.EditorCopyQualifiedName\"");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("categoryId=\"org.eclipse.ui.category.edit\"");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("description=\"Copy the qualified name for the selected element\"");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("name=\"Copy Qualified Name\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</command>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<command");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("id=\"org.eclipse.xtext.ui.editor.copyqualifiedname.OutlineCopyQualifiedName\"");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("categoryId=\"org.eclipse.ui.category.edit\"");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("description=\"Copy the qualified name for the selected element\"");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("name=\"Copy Qualified Name\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</command>");
    _builder.newLine();
    _builder.append("</extension>");
    _builder.newLine();
    _builder.append("<extension point=\"org.eclipse.ui.menus\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<menuContribution");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("locationURI=\"popup:#TextEditorContext?after=group.edit\">");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<command");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("commandId=\"");
    String _name_17 = it.getName();
    _builder.append(_name_17, "\t\t\t");
    _builder.append(".validate\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t");
    _builder.append("style=\"push\"");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("tooltip=\"Trigger expensive validation\">");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<visibleWhen checkEnabled=\"false\">");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("<reference");
    _builder.newLine();
    _builder.append("\t\t\t\t\t");
    _builder.append("definitionId=\"");
    String _name_18 = it.getName();
    _builder.append(_name_18, "\t\t\t\t\t");
    _builder.append(".Editor.opened\">");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t\t");
    _builder.append("</reference>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("</visibleWhen>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</command>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</menuContribution>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<!-- copy qualified name -->");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<menuContribution locationURI=\"popup:#TextEditorContext?after=copy\">");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<command commandId=\"org.eclipse.xtext.ui.editor.copyqualifiedname.EditorCopyQualifiedName\"");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("style=\"push\" tooltip=\"Copy Qualified Name\">");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<visibleWhen checkEnabled=\"false\">");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("<reference definitionId=\"");
    String _name_19 = it.getName();
    _builder.append(_name_19, "\t\t\t\t");
    _builder.append(".Editor.opened\" />");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t");
    _builder.append("</visibleWhen>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</command>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</menuContribution>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<menuContribution locationURI=\"menu:edit?after=copy\">");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<command commandId=\"org.eclipse.xtext.ui.editor.copyqualifiedname.EditorCopyQualifiedName\"");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("style=\"push\" tooltip=\"Copy Qualified Name\">");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<visibleWhen checkEnabled=\"false\">");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("<reference definitionId=\"");
    String _name_20 = it.getName();
    _builder.append(_name_20, "\t\t\t\t");
    _builder.append(".Editor.opened\" />");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t");
    _builder.append("</visibleWhen>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</command>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</menuContribution>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<menuContribution locationURI=\"popup:org.eclipse.xtext.ui.outline?after=additions\">");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<command commandId=\"org.eclipse.xtext.ui.editor.copyqualifiedname.OutlineCopyQualifiedName\"");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("style=\"push\" tooltip=\"Copy Qualified Name\">");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<visibleWhen checkEnabled=\"false\">");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("<and>");
    _builder.newLine();
    _builder.append("\t\t\t\t\t");
    _builder.append("<reference definitionId=\"");
    String _name_21 = it.getName();
    _builder.append(_name_21, "\t\t\t\t\t");
    _builder.append(".XtextEditor.opened\" />");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t\t\t");
    _builder.append("<iterate>");
    _builder.newLine();
    _builder.append("\t\t\t\t\t\t");
    _builder.append("<adapt type=\"org.eclipse.xtext.ui.editor.outline.IOutlineNode\" />");
    _builder.newLine();
    _builder.append("\t\t\t\t\t");
    _builder.append("</iterate>");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("</and>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("</visibleWhen>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</command>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</menuContribution>");
    _builder.newLine();
    _builder.append("</extension>");
    _builder.newLine();
    _builder.append("<extension point=\"org.eclipse.ui.menus\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<menuContribution locationURI=\"popup:#TextEditorContext?endof=group.find\">");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<command commandId=\"org.eclipse.xtext.ui.editor.FindReferences\">");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<visibleWhen checkEnabled=\"false\">");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("<reference definitionId=\"");
    String _name_22 = it.getName();
    _builder.append(_name_22, "\t\t\t\t");
    _builder.append(".Editor.opened\">");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t\t");
    _builder.append("</reference>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("</visibleWhen>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</command>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</menuContribution>");
    _builder.newLine();
    _builder.append("</extension>");
    _builder.newLine();
    _builder.append("<extension point=\"org.eclipse.ui.handlers\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<handler");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("class=\"");
    TypeReference _eclipsePluginExecutableExtensionFactory_10 = this.naming.getEclipsePluginExecutableExtensionFactory(it);
    _builder.append(_eclipsePluginExecutableExtensionFactory_10, "\t\t");
    _builder.append(":org.eclipse.xtext.ui.editor.findrefs.FindReferencesHandler\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("commandId=\"org.eclipse.xtext.ui.editor.FindReferences\">");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<activeWhen>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<reference");
    _builder.newLine();
    _builder.append("\t\t\t\t");
    _builder.append("definitionId=\"");
    String _name_23 = it.getName();
    _builder.append(_name_23, "\t\t\t\t");
    _builder.append(".Editor.opened\">");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t");
    _builder.append("</reference>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</activeWhen>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</handler>");
    _builder.newLine();
    _builder.append("</extension>");
    _builder.newLine();
    _builder.append("<extension point=\"org.eclipse.core.contenttype.contentTypes\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<content-type");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("base-type=\"org.eclipse.core.runtime.text\"");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("file-extensions=\"");
    String _join_1 = IterableExtensions.join(this.getLanguage().getFileExtensions(), ",");
    _builder.append(_join_1, "\t\t");
    _builder.append("\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("id=\"");
    String _name_24 = it.getName();
    _builder.append(_name_24, "\t\t");
    _builder.append(".contenttype\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("name=\"");
    String _simpleName_9 = GrammarUtil.getSimpleName(it);
    _builder.append(_simpleName_9, "\t\t");
    _builder.append(" File\"");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("priority=\"normal\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</content-type>");
    _builder.newLine();
    _builder.append("</extension>");
    _builder.newLine();
    return _builder;
  }
}