"
I use the name of a file, which can be suffixed by a language's name, to create or retrieve a toplevel namespace in the importer's model.
I am best used in tandem with `CS18NFileNameSuffixLanguageStrategy`.

```
CS18NPropertiesImporter new namespaceStrategy:
	(CS18NFileNamePrefixNamespaceStrategy new separator: $_).
```
"
Class {
	#name : #CS18NFileNamePrefixNamespaceStrategy,
	#superclass : #CS18NAbstractNamespaceStrategy,
	#traits : 'CS18NNameSeparator',
	#classTraits : 'CS18NNameSeparator classTrait',
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NFileNamePrefixNamespaceStrategy >> namespaceForFile: aFileReference [

	"I extract a namespace from the given file's name  using the separator received by #separator:
	For a file named 'foo_fr.properties' and the separator $_ I will answer a CS18NNamespace named 'foo'"

	^ importer model ensureNamespace:
		  (aFileReference basenameWithoutExtension copyUpToLast: separator)
]
