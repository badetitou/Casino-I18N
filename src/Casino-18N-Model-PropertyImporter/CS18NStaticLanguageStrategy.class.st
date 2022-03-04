"
I have to be told once beforehand with `#language:` the short name of which `CS18NLanguage` I will answer when I receive `#languageForFile:`.

```
CS18NPropertiesImporter new
	model: CS18NModel new; ""a model must be provided before me""
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

	"I take a language short name with which I will create an instance of CS18NLanguage in a model when linked to an importer.
	I will answer this instance whenever #languageForFile: is called."
	
	language := CS18NLanguage new shortName: aLanguageShortName
]

{ #category : #strategy }
CS18NStaticLanguageStrategy >> languageForFile: aFileReference [

	"I always answer the language that I was told with #language:"

	^ language
]

{ #category : #'private - accessing' }
CS18NStaticLanguageStrategy >> model: aModel [

	"I must only be called by CS18NPropertiesImporter."

	super model: aModel.
	model add: language
]
