"
A CS18NPropertiesImporterTest is a test class for testing the behavior of CS18NPropertiesImporter
"
Class {
	#name : #CS18NPropertiesImporterTest,
	#superclass : #TestCase,
	#instVars : [
		'importer',
		'i18nModel',
		'languageStrategy'
	],
	#category : #'Casino-18N-Model-PropertyImporter-Tests'
}

{ #category : #test }
CS18NPropertiesImporterTest >> setUp [

	super setUp.
	importer := CS18NPropertiesImporter new.
	languageStrategy := CS18NStaticLanguageStrategy new language: 'fr'.
	importer languageStrategy: languageStrategy.
	importer namespaceStrategy: CS18NRootNamespaceStrategy new.
	importer entryStrategy: CS18NSmartEntryStrategy new.
	i18nModel := CS18NModel new.
	importer model: i18nModel.
	importer currentLanguage: (importer model ensureLanguage: #fr).
	importer currentNamespace: importer model rootNamespace
]

{ #category : #test }
CS18NPropertiesImporterTest >> testImportString [

	importer importString: 'property=value'.
	self assert: (i18nModel allWithType: CS18NEntry) size equals: 1.
	self
		assert: (i18nModel allWithType: CS18NEntry) anyOne key name
		equals: 'property'.
	self
		assert:
		(i18nModel allWithType: CS18NEntry) anyOne values anyOne name
		equals: 'value'
]
