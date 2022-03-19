"
Include a group of key or other namespace.
Should be unique in a model, and the ancestor of all other namespaces.
"
Class {
	#name : #CS18NRootNamespace,
	#superclass : #CS18NNamespace,
	#category : #'Casino-18N-Model-Entities'
}

{ #category : #testing }
CS18NRootNamespace >> isRootNamespace [

	^ true
]
