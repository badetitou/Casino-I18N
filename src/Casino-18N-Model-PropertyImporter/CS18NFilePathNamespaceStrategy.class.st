"
I use the path of a file to create or retrieve a toplevel namespace in a model.

```
CS18NPropertiesImporter new namespaceStrategy:
	CS18NFileNameNamespaceStrategy new.
```
"
Class {
	#name : #CS18NFilePathNamespaceStrategy,
	#superclass : #CS18NAbstractNamespaceStrategy,
	#instVars : [
		'pathIndexes'
	],
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #adding }
CS18NFilePathNamespaceStrategy >> addPathIndex: anIndex [

	"I add to a set the index of a file in the path of the one given to #namespaceForFile:
	The index is relative to the leaf file, which has an index of 1.
	A namespace will be created or retrieved for each one.
	The order in which I am called matters to the resulting namespace hierarchy.
	Set(3 1) with the path 'my/awesome/path/file' results in the namespaces 'awesome.file'
	
	self addPathIndex: 3; addPathIndex: 1. >>> nil
	self namespaceForFile: 'my/awesome/path/file' asFileReference. >>> "

	pathIndexes add: anIndex
]

{ #category : #initialization }
CS18NFilePathNamespaceStrategy >> initialize [

	pathIndexes := Set new.
]

{ #category : #strategy }
CS18NFilePathNamespaceStrategy >> namespaceForFile: aFileReference [

	| segments namePath |
	segments := aFileReference absolutePath segments reversed.
	namePath := pathIndexes collect: [ :i | 
		            i = 1
			            ifTrue: [ (segments at: 1) copyUpToLast: $. ]
			            ifFalse: [ segments at: i ] ].
	^ model namespaceForPath: ('.' join: namePath)
]