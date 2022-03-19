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
	importer languageStrategy:
		(strategy := CS18NFileNameLanguageStrategy new).
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
	self assert: namespace namespace isRootNamespace
]

{ #category : #tests }
CS18NStrategyTest >> testFileNamePrefixNamespaceStrategy [

	| strategy namespace |
	strategy := CS18NFileNamePrefixNamespaceStrategy new separator: $_.
	importer namespaceStrategy: strategy.
	namespace := strategy namespaceForFile:
		             'foo_fr.properties' asFileReference.
	self assert: namespace name equals: 'foo'.
	self assert: namespace namespace isRootNamespace
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
	self assert: namespace namespace namespace isRootNamespace
]

{ #category : #tests }
CS18NStrategyTest >> testLiteralEntryStrategy [

	| strategy entry namespace |
	strategy := CS18NLiteralEntryStrategy new.
	namespace := importer model createNamespace name: 'root'.
	importer
		entryStrategy: strategy;
		currentNamespace: namespace.
	entry := strategy entryForKey: 'foo.bar'.
	self assert: entry key name equals: 'foo.bar'.
	self assert: entry namespace name equals: 'root'
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
CS18NStrategyTest >> testPluggableEntryStrategy [

	| strategy entry |
	importer currentNamespace: (importer model ensureNamespace: 'root').
	strategy := CS18NPluggableEntryStrategy new
		            importer: importer;
		            block: [ :key | 
			            importer currentNamespace ensureEntry:
					            (key copyAfterLast: $.) ].
	entry := strategy entryForKey: 'foo.bar'.
	self assert: entry key name equals: 'bar'.
	self assert: entry namespace name equals: 'root'
]

{ #category : #tests }
CS18NStrategyTest >> testPluggableLanguageStrategy [

	| strategy lang |
	strategy := CS18NPluggableLanguageStrategy new block: [ :file | 
		            importer model ensureLanguage:
			            (file basenameWithoutExtension copyUpTo: $-) ].
	importer
		currentNamespace: (importer model ensureNamespace: 'root');
		entryStrategy: strategy.
	lang := strategy languageForFile: 'fr-foo.properties' asFileReference.
	self assert: lang shortName equals: 'fr'
]

{ #category : #tests }
CS18NStrategyTest >> testPluggableNamespaceStrategy [

	| strategy namespace |
	strategy := CS18NPluggableNamespaceStrategy new block: [ :file | 
		            importer currentNamespace ensureNamespace:
			            (file basenameWithoutExtension copyAfter: $-) ].
	importer
		currentNamespace: (importer model ensureNamespace: 'root');
		namespaceStrategy: strategy.
	namespace := strategy namespaceForFile:
		             'fr-foo.properties' asFileReference.
	self assert: namespace name equals: 'foo'.
	self assert: namespace namespace name equals: 'root'
]

{ #category : #tests }
CS18NStrategyTest >> testRootNamespaceStrategy [

	| strategy namespace |
	strategy := CS18NRootNamespaceStrategy new.
	importer namespaceStrategy: strategy.
	
	namespace := strategy namespaceForFile: 'foo'.
	self assert: namespace class equals: CS18NRootNamespace.
	self assert: namespace name equals: nil.
	self assert: namespace equals: importer model rootNamespace.
]

{ #category : #tests }
CS18NStrategyTest >> testSmartEntryStrategy [

	| strategy entry1 entry2 entry3 |
	importer
		currentNamespace: (importer model ensureNamespace: 'root');
		entryStrategy: (strategy := CS18NSmartEntryStrategy new).

	entry1 := strategy entryForKey: 'foo.bar.baz'.
	self assert: entry1 key name equals: 'baz'.
	self assert: entry1 namespace name equals: 'bar'.
	self assert: entry1 namespace namespace name equals: 'foo'.
	self assert: entry1 namespace namespace namespace name equals: 'root'.

	entry2 := strategy entryForKey: 'foo.bar'.
	self assert: entry2 key name equals: 'bar'.
	self assert: entry1 key name equals: 'bar.baz'.
	self assert: entry1 namespace equals: entry2 namespace.

	entry3 := strategy entryForKey: 'foo'.
	self assert: entry3 key name equals: 'foo'.
	self assert: entry2 key name equals: 'foo.bar'.
	self assert: entry1 key name equals: 'foo.bar.baz'.
	self assert: entry1 namespace equals: entry2 namespace.
	self assert: entry1 namespace equals: entry3 namespace.

	entry1 := strategy entryForKey: 'foo.bar.baz.foo'.
	self assert: entry1 key name equals: 'foo.bar.baz.foo'.

	entry1 := strategy entryForKey: 'a.a'.
	entry2 := strategy entryForKey: 'a.a.a.a'.
	self assert: entry1 key name equals: 'a'.
	self assert: entry1 namespace name equals: 'a'.
	self assert: entry2 key name equals: 'a'.
	self assert: entry2 namespace name equals: 'a.a'.
	entry3 := strategy entryForKey: 'a'.
	self assert: entry1 key name equals: 'a.a'.
	self assert: entry1 namespace name equals: 'root'.
	self assert: entry2 key name equals: 'a'.
	self assert: entry2 namespace name equals: 'a.a.a'.
	self assert: entry3 key name equals: 'a'.
	self assert: entry3 namespace name equals: 'root'
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
	self assert: namespace namespace isRootNamespace
]
