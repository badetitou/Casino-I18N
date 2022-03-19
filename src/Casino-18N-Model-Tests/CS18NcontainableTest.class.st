"
A CS18NcontainableTest is a test class for testing the behavior of CS18Ncontainable
"
Class {
	#name : #CS18NcontainableTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Casino-18N-Model-Tests-Traits'
}

{ #category : #running }
CS18NcontainableTest >> setUp [

	super setUp.
	model := CS18NModel new
]

{ #category : #tests }
CS18NcontainableTest >> testCompleteName [

	| containable |
	containable := model entryForPath: 'Hello.world'.
	self assert: containable completeName equals: 'Hello.world'.

	containable := model namespaceForPath: 'Hello.world'.
	self assert: containable completeName equals: 'Hello.world'
]
