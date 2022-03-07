"
I use a user-defined block to create or retrieve a language in a model.

```
CS18NPropertiesImporter new entryStrategy:
	(CS18NPluggableLanguageStrategy new block: [ :key | ""custom implementation"" ]).
```
"
Class {
	#name : #CS18NPluggableLanguageStrategy,
	#superclass : #CS18NAbstractLanguageStrategy,
	#traits : 'CS18NPluggable',
	#classTraits : 'CS18NPluggable classTrait',
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NPluggableLanguageStrategy >> languageForFile: aFileReference [

	"I extract a language from the given file using the received block."

	^ block value: aFileReference
]
