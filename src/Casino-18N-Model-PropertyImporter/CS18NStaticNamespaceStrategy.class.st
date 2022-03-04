"
I have to be told once beforehand with `#namespace:` the name of which `CS18NNamespace` I will answer when I receive `#namespaceForFile:`.

```
CS18NPropertiesImporter new
	model: CS18NModel new; ""a model must be provided before me""
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
CS18NStaticNamespaceStrategy >> model: aModel [

	"I must only be called by CS18NPropertiesImporter."

	super model: aModel.
	model add: namespace
]

{ #category : #accessing }
CS18NStaticNamespaceStrategy >> namespace: aNamespaceName [

	"I take a name with which I will create an instance of CS18NNamespace in a model when linked to an importer.
	I will answer this instance whenever #namespaceForFile: is called."

	namespace := CS18NNamespace new name: aNamespaceName
]

{ #category : #strategy }
CS18NStaticNamespaceStrategy >> namespaceForFile: aFileReference [

	"I always answer the namespace that I was told with #namespace:"

	^ namespace
]
