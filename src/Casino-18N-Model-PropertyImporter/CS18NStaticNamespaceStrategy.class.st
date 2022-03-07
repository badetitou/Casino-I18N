"
I have to be told once beforehand with `#namespace:` the name of which `CS18NNamespace` I will answer when I receive `#namespaceForFile:`.

```
CS18NPropertiesImporter new
	namespaceStrategy: (CS18NStaticNamespaceStrategy new namespace: 'root').
```
"
Class {
	#name : #CS18NStaticNamespaceStrategy,
	#superclass : #CS18NAbstractNamespaceStrategy,
	#instVars : [
		'namespace'
	],
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #accessing }
CS18NStaticNamespaceStrategy >> namespace: aNamespaceName [

	"I take a name for which I will answer an instance of CS18NNamespace whenever #namespaceForFile: is received."

	namespace := aNamespaceName
]

{ #category : #strategy }
CS18NStaticNamespaceStrategy >> namespaceForFile: aFileReference [

	"I always answer the namespace that was received by #namespace:"

	^ importer model ensureNamespace: namespace
]
