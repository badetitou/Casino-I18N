Class {
	#name : #CS18NStrategyTest,
	#superclass : #TestCase,
	#instVars : [
		'importer'
	],
	#category : #'Casino-18N-Model-PropertyImporter-Tests'
}

{ #category : #running }
CS18NStrategyTest >> setUp [

	super setUp.
	importer := CS18NPropertiesImporter new model: CS18NModel new
]

{ #category : #tests }
CS18NStrategyTest >> testFileNameLanguageStrategy [

	| strategy lang |
	strategy := CS18NFileNameLanguageStrategy new importer: importer.
	lang := strategy languageForFile: 'fr.properties' asFileReference.
	self assert: lang shortName equals: 'fr'
]

{ #category : #tests }
CS18NStrategyTest >> testFileNameNamespaceStrategy [

	| strategy namespace |
	strategy := CS18NFileNameNamespaceStrategy new.
	importer namespaceStrategy: strategy.
	namespace := strategy namespaceForFile:
		             'foo.properties' asFileReference.
	self assert: namespace name equals: 'foo'.
	self assert: namespace namespace isNil
]

{ #category : #tests }
CS18NStrategyTest >> testFileNamePrefixNamespaceStrategy [

	| strategy namespace |
	strategy := CS18NFileNamePrefixNamespaceStrategy new separator: $_.
	importer namespaceStrategy: strategy.
	namespace := strategy namespaceForFile:
		             'foo_fr.properties' asFileReference.
	self assert: namespace name equals: 'foo'.
	self assert: namespace namespace isNil
]

{ #category : #tests }
CS18NStrategyTest >> testFileNameSuffixLanguageStrategy [

	| strategy lang |
	strategy := CS18NFileNameSuffixLanguageStrategy new separator: $_.
	importer languageStrategy: strategy.
	lang := strategy languageForFile: 'foo_fr.properties' asFileReference.
	self assert: lang shortName equals: 'fr'
]

{ #category : #tests }
CS18NStrategyTest >> testFilePathNamespaceStrategy [

	| strategy namespace |
	strategy := CS18NFilePathNamespaceStrategy new
		            addPathIndex: 3;
		            addPathIndex: 1.
	importer namespaceStrategy: strategy.
	namespace := strategy namespaceForFile:
		             'my/awesome/test/foo.properties' asFileReference.
	self assert: namespace name equals: 'foo'.
	self assert: namespace namespace name equals: 'awesome'.
	self assert: namespace namespace namespace isNil
]

{ #category : #tests }
CS18NStrategyTest >> testLiteralEntryStrategy [

	| strategy entry |
	strategy := CS18NLiteralEntryStrategy new.
	importer
		entryStrategy: strategy;
		currentNamespace: CS18NNamespace new.
	entry := strategy entryForKey: 'foo.bar'.
	self assert: entry key name equals: 'foo.bar'
]

{ #category : #tests }
CS18NStrategyTest >> testNestedEntryStrategy [

	| strategy entry |
	strategy := CS18NNestedEntryStrategy new.
	importer
		entryStrategy: strategy;
		currentNamespace: (importer model ensureNamespace: 'root').
	entry := strategy entryForKey: 'foo.bar'.
	self assert: entry key name equals: 'bar'.
	self assert: entry namespace name equals: 'foo'.
	self assert: entry namespace namespace name equals: 'root'
]

{ #category : #tests }
CS18NStrategyTest >> testStaticLanguageStrategy [

	| strategy lang |
	strategy := CS18NStaticLanguageStrategy new language: 'fr'.
	importer languageStrategy: strategy.
	lang := strategy languageForFile: 'foo.properties' asFileReference.
	self assert: lang shortName equals: 'fr'
]

{ #category : #tests }
CS18NStrategyTest >> testStaticNamespaceStrategy [

	| strategy namespace |
	strategy := CS18NStaticNamespaceStrategy new namespace: 'root'.
	importer namespaceStrategy: strategy.
	namespace := strategy namespaceForFile:
		             'foo.properties' asFileReference.
	self assert: namespace name equals: 'root'.
	self assert: namespace namespace isNil
]
