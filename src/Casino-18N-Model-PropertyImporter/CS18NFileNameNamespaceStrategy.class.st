"
I use the name of a file to create or retrieve a toplevel namespace in a model.

```
CS18NPropertiesImporter new namespaceStrategy:
	CS18NFileNameNamespaceStrategy new.
```
"
Class {
	#name : #CS18NFileNameNamespaceStrategy,
	#superclass : #CS18NAbstractNamespaceStrategy,
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NFileNameNamespaceStrategy >> namespaceForFile: aFileReference [

	"I extract a namespace from the given file's name.
	For a file named 'foo_fr.properties' I will answer a CS18NNamespace named 'foo_fr'."

	^ importer model ensureNamespace:
		  aFileReference basenameWithoutExtension
]
