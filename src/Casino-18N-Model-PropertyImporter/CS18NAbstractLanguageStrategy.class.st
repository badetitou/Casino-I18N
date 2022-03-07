"
I represent a strategy to create or retrieve a `CS18NLanguage` in a model.
One of my subclasses has to be initialized and then linked to an instance of `CS18NPropertiesImporter`.
"
Class {
	#name : #CS18NAbstractLanguageStrategy,
	#superclass : #CS18NAbstractStrategy,
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NAbstractLanguageStrategy >> languageForFile: aFileReference [

	"I must be overridden to implement a specific way to extract a language from a given file."

	self subclassResponsibility
]
