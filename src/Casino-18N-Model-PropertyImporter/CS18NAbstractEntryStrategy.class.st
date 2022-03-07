"
I represent a strategy to create or retrieve a `CS18NEntry` in a model.
One of my subclasses has to be initialized and then linked to an instance of `CS18NPropertiesImporter`.
"
Class {
	#name : #CS18NAbstractEntryStrategy,
	#superclass : #CS18NAbstractStrategy,
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NAbstractEntryStrategy >> entryForKey: aKeyName [

	self subclassResponsibility
]
