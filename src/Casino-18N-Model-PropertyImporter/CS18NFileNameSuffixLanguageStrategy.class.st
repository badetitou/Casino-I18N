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
	#traits : 'CS18NNameSeparator',
	#classTraits : 'CS18NNameSeparator classTrait',
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NFileNameSuffixLanguageStrategy >> languageForFile: aFileReference [

	"I extract a language from the given file's name using the separator received by #separator:
	For a file named 'foo_fr.properties' and the separator $_ I will answer a CS18NLanguage for 'fr'"

	^ importer model ensureLanguage:
		  (aFileReference basenameWithoutExtension copyAfterLast: separator)
]
