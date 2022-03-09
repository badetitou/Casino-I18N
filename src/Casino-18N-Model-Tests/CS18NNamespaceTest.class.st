Class {
	#name : #CS18NNamespaceTest,
	#superclass : #TestCase,
	#instVars : [
		'i18model'
	],
	#category : #'Casino-18N-Model-Tests'
}

{ #category : #tests }
CS18NNamespaceTest >> setUp [
	super setUp.
	i18model := CS18NModel new.
	i18model importer: (CS18NPropertiesImporter new
			 model: i18model;
			 yourself)
]

{ #category : #tests }
CS18NNamespaceTest >> testCompleteName [

	| namespace |
	namespace := i18model importer createNamespace name: 'Hello'.
	namespace := namespace addContainable: (i18model importer createNamespace name: 'world').
	self assert: namespace completeName equals: 'Hello.world'
]

{ #category : #tests }
CS18NNamespaceTest >> testEnsureEntry [

	| namespace anEntry |
	namespace := i18model importer createNamespace name: 'Hello'.

	"new entry"
	anEntry := namespace ensureEntry: 'foo'.
	self assert: anEntry key name equals: 'foo'.
	self assert: anEntry namespace equals: namespace.

	"retrieve entry"
	self assert: anEntry equals: (namespace ensureEntry: 'foo').

	"no conflict with subnamespaces"
	namespace addContainable:
		(i18model importer createNamespace name: 'bar').
	anEntry := namespace ensureEntry: 'bar'.
	self assert: anEntry class equals: CS18NEntry.

	"entries added to the model"
	self assert: (i18model allWithType: CS18NEntry) size equals: 2
]

{ #category : #tests }
CS18NNamespaceTest >> testEnsureSubNamespace [

	| namespace subNamespace |
	namespace := i18model importer createNamespace name: 'Hello'.

	"new subnamespace"
	subNamespace := namespace ensureSubNamespace: 'foo'.
	self
		assert: subNamespace name equals: 'foo'.
		self assert: subNamespace namespace equals: namespace.

	"retrieve subnamespace"
	self
		assert: subNamespace
		equals: (namespace ensureSubNamespace: 'foo').

	"no conflict with entries"
	namespace addContainable:
		(i18model importer createEntry key: (i18model importer createKey name: 'bar')).
	subNamespace := namespace ensureSubNamespace: 'bar'.
	self assert: subNamespace class equals: CS18NNamespace.
	
	self assert: (i18model allWithType: CS18NNamespace) size equals: 3
]
