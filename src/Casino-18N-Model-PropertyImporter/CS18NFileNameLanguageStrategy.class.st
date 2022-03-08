"
I use the name of a file to create or retrieve a language in the importer's model.

```
CS18NPropertiesImporter new languageStrategy:
	CS18NFileNameLanguageStrategy new.
```
"
Class {
	#name : #CS18NFileNameLanguageStrategy,
	#superclass : #CS18NAbstractLanguageStrategy,
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NFileNameLanguageStrategy >> languageForFile: aFileReference [

	"I extract a language from the given file's name.
	For a file named 'fr.properties' I will answer a CS18NLanguage named 'fr'"

	^ importer model ensureLanguage:
		  aFileReference basenameWithoutExtension
]
