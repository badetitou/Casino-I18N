Class {
	#name : #CS18NStrategyTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Casino-18N-Model-PropertyImporter-Tests'
}

{ #category : #initialization }
CS18NStrategyTest >> setUp [

	model := CS18NModel new
]

{ #category : #tests }
CS18NStrategyTest >> testFilePathNamespaceStrategy [

	| strategy namespace |
	strategy := CS18NFilePathNamespaceStrategy new
		            addPathIndex: 3;
		            addPathIndex: 1;
		            model: model.
	namespace := strategy namespaceForFile:
		             'my/awesome/test/foo.properties' asFileReference.
	self
		assert: namespace name equals: 'foo'. self
		assert: namespace namespace name equals: 'awesome'. self
		assert: namespace namespace namespace isNil
]

{ #category : #tests }
CS18NStrategyTest >> testFilenameNamespaceStrategy [

	| strategy namespace |
	strategy := CS18NFileNameNamespaceStrategy new model: model.
	namespace := strategy namespaceForFile:
		             'foo.properties' asFileReference.
	self
		assert: namespace name equals: 'foo'. self
		assert: namespace namespace isNil
]

{ #category : #tests }
CS18NStrategyTest >> testFilenamePrefixNamespaceStrategy [

	| strategy namespace |
	strategy := CS18NFileNamePrefixNamespaceStrategy new
		            separator: $_;
		            model: model.
	namespace := strategy namespaceForFile:
		             'foo_fr.properties' asFileReference.
	self
		assert: namespace name equals: 'foo'. self
		assert: namespace namespace isNil
]

{ #category : #tests }
CS18NStrategyTest >> testFilenameSuffixLanguageStrategy [

	| strategy lang |
	strategy := CS18NFileNameSuffixLanguageStrategy new
		            separator: $_;
				            model: model.
	lang := strategy languageForFile: 'foo_fr.properties' asFileReference.
	self assert: lang shortName equals: 'fr'
]

{ #category : #tests }
CS18NStrategyTest >> testStaticLanguageStrategy [

	| strategy lang |
	strategy := CS18NStaticLanguageStrategy new
		            language: 'fr';
			model: model.
	lang := strategy languageForFile: 'foo.properties' asFileReference.
	self assert: lang shortName equals: 'fr'
]

{ #category : #tests }
CS18NStrategyTest >> testStaticNamespaceStrategy [

	| strategy namespace |
	strategy := CS18NStaticNamespaceStrategy new
		            namespace: 'root';
		            model: model.
	namespace := strategy namespaceForFile:
		             'foo.properties' asFileReference.
	self
		assert: namespace name equals: 'root'. self
		assert: namespace namespace isNil
]
