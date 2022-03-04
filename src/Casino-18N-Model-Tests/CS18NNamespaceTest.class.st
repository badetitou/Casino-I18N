Class {
	#name : #CS18NNamespaceTest,
	#superclass : #TestCase,
	#category : #'Casino-18N-Model-Tests'
}

{ #category : #tests }
CS18NNamespaceTest >> testCompleteName [

	| namespace |
	namespace := CS18NNamespace new name: 'Hello'.
	namespace := namespace addContainable: (CS18NNamespace new name: 'world').
	self assert: namespace completeName equals: 'Hello.world'
]

{ #category : #tests }
CS18NNamespaceTest >> testEnsureEntry [

	| namespace anEntry |
	namespace := CS18NNamespace new name: 'Hello'.

	"new entry"
	anEntry := namespace ensureEntry: 'foo'.
	self
		assert: anEntry key name equals: 'foo'. self
		assert: anEntry namespace equals: namespace.

	"retrieve entry"
	self assert: anEntry equals: (namespace ensureEntry: 'foo').

	"no conflict with subnamespaces"
	namespace addContainable: (CS18NNamespace new name: 'bar').
	anEntry := namespace ensureEntry: 'bar'.
	self assert: anEntry class equals: CS18NEntry
]

{ #category : #tests }
CS18NNamespaceTest >> testEnsureSubNamespace [

	| namespace subNamespace |
	namespace := CS18NNamespace new name: 'Hello'.

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
		(CS18NEntry new key: (CS18NKey new name: 'bar')).
	subNamespace := namespace ensureSubNamespace: 'bar'.
	self assert: subNamespace class equals: CS18NNamespace
]
