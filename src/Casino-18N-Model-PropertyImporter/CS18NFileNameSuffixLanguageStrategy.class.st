"
I use the name of a file to create or retrieve a language in a model.
I am best used in tandem with `CS18NFileNamePrefixNamespaceStrategy`.

```
CS18NPropertiesImporter new languageStrategy:
	(CS18NFileNameSuffixLanguageStrategy new separator: $_).
```
"
Class {
	#name : #CS18NFileNameSuffixLanguageStrategy,
	#superclass : #CS18NAbstractLanguageStrategy,
	#traits : 'CS18NFilenameSeparator',
	#classTraits : 'CS18NFilenameSeparator classTrait',
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NFileNameSuffixLanguageStrategy >> languageForFile: aFileReference [

	"I extract a language from the given file's name.
	For a file named 'foo_fr.properties' I will answer a CS18NLanguage for 'fr'."

	^ model ensureLanguage: (aFileReference basenameWithoutExtension 
		                 copyAfterLast: separator).
]
