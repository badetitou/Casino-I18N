"
I represent a strategy to create or retrieve a namespace or a language in a model.
One of my subclasses has to be initialized and then linked to an instance of `CS18NPropertiesImporter`.
"
Class {
	#name : #CS18NAbstractStrategy,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #'private - accessing' }
CS18NAbstractStrategy >> model: aModel [

	"I must only be called by CS18NPropertiesImporter."

	model := aModel
]