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

{ #category : #tests }
CS18NPropertiesImporterTest >> testExtractModelMixedValueNamedAttribute [

	| result |
	result := importer extractModelValueAttributes: (CS18NValue new
			           name: 'Hello : {libelle} and [%]';
			           yourself).

	self assert: result size equals: 2.
	self assert: result first class equals: CS18NValueVariable.
	self assert: result first startPos equals: 23.
	self assert: result first endPos equals: 25.
	"No name because the name would be between the % and the last ] but we did not find example yet"
	self assert: result first name equals: 'noname'.

	self assert: result second class equals: CS18NValueVariable.
	self assert: result second startPos equals: 9.
	self assert: result second endPos equals: 17.
	"No name because the name would be between the % and the last ] but we did not find example yet"
	self assert: result second name equals: 'libelle'
]

{ #category : #tests }
CS18NPropertiesImporterTest >> testExtractModelTwoValueAttribute [

	| result |
	result := importer extractModelValueAttributes: (CS18NValue new
			           name: 'Hello : [%] and [%]';
			           yourself).
	self assert: result size equals: 2.
	self assert: result first class equals: CS18NValueVariable.
	self assert: result first startPos equals: 9.
	self assert: result first endPos equals: 11.
	"No name because the name would be between the % and the last ] but we did not find example yet"
	self assert: result anyOne name equals: 'noname'.
	

	self assert: result second class equals: CS18NValueVariable.
	self assert: result second startPos equals: 17.
	self assert: result second endPos equals: 19.
	"No name because the name would be between the % and the last ] but we did not find example yet"
	self assert: result second name equals: 'noname'.
]

{ #category : #tests }
CS18NPropertiesImporterTest >> testExtractModelTwoValueNamedAttribute [

	| result |
	result := importer extractModelValueAttributes: (CS18NValue new
			           name: 'Hello : {libelle} and {secondLibelle}';
			           yourself).
	self assert: result size equals: 2.
	self assert: result anyOne class equals: CS18NValueVariable.
	self assert: result anyOne startPos equals: 9.
	self assert: result anyOne endPos equals: 17.
	"No name because the name would be between the % and the last ] but we did not find example yet"
	self assert: result anyOne name equals: 'libelle'.
	

	self assert: result second class equals: CS18NValueVariable.
	self assert: result second startPos equals: 23.
	self assert: result second endPos equals: 37.
	"No name because the name would be between the % and the last ] but we did not find example yet"
	self assert: result second name equals: 'secondLibelle'.
]

{ #category : #tests }
CS18NPropertiesImporterTest >> testExtractModelValueAttribute [

	| result |
	result := importer extractModelValueAttributes: (CS18NValue new
			           name: 'Hello : [%]';
			           yourself).
	self assert: result size equals: 1.
	self assert: result anyOne class equals: CS18NValueVariable.
	self assert: result anyOne startPos equals: 9.
	self assert: result anyOne endPos equals: 11.
	"No name because the name would be between the % and the last ] but we did not find example yet"
	self assert: result anyOne name equals: 'noname'.
]

{ #category : #tests }
CS18NPropertiesImporterTest >> testExtractModelValueAttributes [

	| result |
	result := importer extractModelValueAttributes: (CS18NValue new
			           name: 'Hello : [%]';
			           yourself).
	self assert: result size equals: 1.
	self assert: result anyOne class equals: CS18NValueVariable.
	self assert: result anyOne startPos equals: 9.
	self assert: result anyOne endPos equals: 11.
	"No name because the name would be between the % and the last ] but we did not find example yet"
	self assert: result anyOne name equals: 'noname'.
]

{ #category : #tests }
CS18NPropertiesImporterTest >> testExtractModelValueAttributesNoAttribute [

	| result |
	result := importer extractModelValueAttributes: (CS18NValue new
			           name: 'Hello';
			           yourself).
	self assert: result size equals: 0
]

{ #category : #tests }
CS18NPropertiesImporterTest >> testExtractModelValueNamedAttribute [

	| result |
	result := importer extractModelValueAttributes: (CS18NValue new
			           name: 'Hello : {libelle}';
			           yourself).
	self assert: result size equals: 1.
	self assert: result anyOne class equals: CS18NValueVariable.
	self assert: result anyOne startPos equals: 9.
	self assert: result anyOne endPos equals: 17.
	"No name because the name would be between the % and the last ] but we did not find example yet"
	self assert: result anyOne name equals: 'libelle'.
]

{ #category : #tests }
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

{ #category : #'as yet unclassified' }
CS18NPropertiesImporterTest >> testImportStringLanguage [

	importer importString: 'property=value'.

	self
		assert: (i18nModel allWithType: CS18NValue) anyOne language
		equals: (i18nModel allWithType: CS18NLanguage) anyOne
]

{ #category : #tests }
CS18NPropertiesImporterTest >> testImportStringWithValueAttributes [

	importer importString: 'property=value : [%]'.
	self assert: (i18nModel allWithType: CS18NEntry) size equals: 1.
	self
		assert: (i18nModel allWithType: CS18NEntry) anyOne key name
		equals: 'property'.
	self
		assert:
		(i18nModel allWithType: CS18NEntry) anyOne values anyOne name
		equals: 'value : [%]'.
	self
		assert: (i18nModel allWithType: CS18NValueVariable) size
		equals: 1
]
