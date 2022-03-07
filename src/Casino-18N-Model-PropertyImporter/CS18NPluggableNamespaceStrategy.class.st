"
I use a user-defined block to create or retrieve a namespace in a model.

```
CS18NPropertiesImporter new entryStrategy:
	(CS18NPluggableNamespaceStrategy new block: [ :key | ""custom implementation"" ]).
```
"
Class {
	#name : #CS18NPluggableNamespaceStrategy,
	#superclass : #CS18NAbstractNamespaceStrategy,
	#traits : 'CS18NPluggable',
	#classTraits : 'CS18NPluggable classTrait',
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NPluggableNamespaceStrategy >> namespaceForFile: aFileReference [

	"I create or retrieve a namespace from the given file using the received block."

	^ block value: aFileReference
]
