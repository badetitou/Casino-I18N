"
I always answer the root of the importer's model.

```
CS18NPropertiesImporter new namespaceStrategy:
	CS18NRootNamespaceStrategy new.
```
"
Class {
	#name : #CS18NRootNamespaceStrategy,
	#superclass : #CS18NAbstractNamespaceStrategy,
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NRootNamespaceStrategy >> namespaceForFile: aFileReference [

	^ importer model rootNamespace
]
