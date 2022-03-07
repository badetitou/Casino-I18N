"
A CS18NEntryTest is a test class for testing the behavior of CS18NEntry
"
Class {
	#name : #CS18NEntryTest,
	#superclass : #TestCase,
	#category : #'Casino-18N-Model-Tests-Entities'
}

{ #category : #test }
CS18NEntryTest >> testCompleteName [

	| namespace entry key |
	namespace := CS18NNamespace new
		             name: 'Hello';
		             yourself.
	entry := CS18NEntry new.
	key := CS18NKey new
		       name: 'world';
		       yourself.
	entry key: key.
	namespace addContainable: entry.
	self assert: entry completeName equals: 'Hello.world'
]
