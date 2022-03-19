Class {
	#name : #CS18NNamespaceTest,
	#superclass : #TestCase,
	#instVars : [
		'i18model'
	],
	#category : #'Casino-18N-Model-Tests-Entities'
}

{ #category : #running }
CS18NNamespaceTest >> setUp [

	super setUp.
	i18model := CS18NModel new
]

{ #category : #tests }
CS18NNamespaceTest >> testEnsureEntry [

	| namespace anEntry |
	namespace := i18model createNamespace name: 'Hello'.

	"new entry"
	anEntry := namespace ensureEntry: 'foo'.
	self assert: anEntry key name equals: 'foo'.
	self assert: anEntry namespace equals: namespace.

	"retrieve entry"
	self assert: anEntry equals: (namespace ensureEntry: 'foo').

	"no conflict with subnamespaces"
	namespace addContainable:
		(i18model createNamespace name: 'bar').
	anEntry := namespace ensureEntry: 'bar'.
	self assert: anEntry class equals: CS18NEntry.

	"entries added to the model"
	self assert: (i18model allWithType: CS18NEntry) size equals: 2
]

{ #category : #tests }
CS18NNamespaceTest >> testEnsureNamespace [

	| namespace subNamespace |
	namespace := i18model createNamespace name: 'Hello'.

	"new subnamespace"
	subNamespace := namespace ensureNamespace: 'foo'.
	self
		assert: subNamespace name equals: 'foo'.
		self assert: subNamespace namespace equals: namespace.

	"retrieve subnamespace"
	self
		assert: subNamespace
		equals: (namespace ensureNamespace: 'foo').

	"no conflict with entries"
	namespace addContainable:
		(i18model createEntry key: (i18model createKey name: 'bar')).
	subNamespace := namespace ensureNamespace: 'bar'.
	self assert: subNamespace class equals: CS18NNamespace.
	
	self assert: (i18model allWithType: CS18NNamespace) size equals: 3
]
