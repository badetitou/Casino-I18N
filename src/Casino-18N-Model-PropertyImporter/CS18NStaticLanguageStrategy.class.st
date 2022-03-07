"
I have to be told once beforehand with `#language:` the short name of which `CS18NLanguage` I will answer when I receive `#languageForFile:`.

```
CS18NPropertiesImporter new
	languageStrategy: (CS18NStaticLanguageStrategy new language: 'fr').
```
"
Class {
	#name : #CS18NStaticLanguageStrategy,
	#superclass : #CS18NAbstractLanguageStrategy,
	#instVars : [
		'language'
	],
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #accessing }
CS18NStaticLanguageStrategy >> language: aLanguageShortName [

	"I take a language short name for which I will answer an instance of CS18NLanguage whenever #languageForFile: is received."

	language := aLanguageShortName
]

{ #category : #strategy }
CS18NStaticLanguageStrategy >> languageForFile: aFileReference [

	"I always answer the language that was received by #language:"

	^ importer model ensureLanguage: language
]
