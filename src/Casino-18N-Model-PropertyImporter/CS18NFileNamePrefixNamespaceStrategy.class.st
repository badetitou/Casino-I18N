"
I use the name of a file, which can be suffixed by a language's name, to create or retrieve a toplevel namespace in a model.
I am best used in tandem with `CS18NFileNameSuffixLanguageStrategy`.

```
CS18NPropertiesImporter new namespaceStrategy:
	(CS18NFileNamePrefixNamespaceStrategy new separator: $_).
```
"
Class {
	#name : #CS18NFileNamePrefixNamespaceStrategy,
	#superclass : #CS18NAbstractNamespaceStrategy,
	#traits : 'CS18NFilenameSeparator',
	#classTraits : 'CS18NFilenameSeparator classTrait',
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NFileNamePrefixNamespaceStrategy >> namespaceForFile: aFileReference [

	"I extract a namespace from the given file's name.
	For a file named 'foo_fr.properties' I will answer a CS18NNamespace named 'foo'."

	^ model ensureNamespace: (aFileReference basenameWithoutExtension 
		                 copyUpToLast: separator)
]
