"
I represent a strategy to create or retrieve a toplevel namespace in a model.
One of my subclasses has to be initialized and then linked to an instance of `CS18NPropertiesImporter`.
"
Class {
	#name : #CS18NAbstractNamespaceStrategy,
	#superclass : #CS18NAbstractStrategy,
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NAbstractNamespaceStrategy >> namespaceForFile: aFileReference [

	"I must be overridden to implement a specific way to extract a namespace from a given file."

	self subclassResponsibility
]
