"
I use the path of a file to create or retrieve a toplevel namespace in the importer's model.

```
CS18NPropertiesImporter new namespaceStrategy:
	(CS18NFilePathNamespaceStrategy new
		addPathIndex: 3;
		addPathIndex: 1).
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

	"I add to a collection the index of a segment in the path of the file given to #namespaceForFile:
	The index is relative to the file, which has an index of 1.
	A namespace will be created or retrieved for each one.
	The order in which I am called matters to the resulting namespace hierarchy.
	Indexes (3 1) with path 'my/awesome/path/file' results in the namespaces 'awesome.file'"

	pathIndexes add: anIndex
]

{ #category : #initialization }
CS18NFilePathNamespaceStrategy >> initialize [

	pathIndexes := OrderedCollection new
]

{ #category : #strategy }
CS18NFilePathNamespaceStrategy >> namespaceForFile: aFileReference [

	"I use the indexes received by #addPathIndex: to collect segments of the given file's path, and translate them into nested namespaces.
	For a file with the path 'my/awesome/path/file.properties' and indexes (3 1), I will answer the namespaces: awesome.file"

	| segments |
	segments := aFileReference absolutePath segments reversed.
	segments := pathIndexes collect: [ :i | 
		            i = 1
			            ifTrue: [ aFileReference basenameWithoutExtension ]
			            ifFalse: [ segments at: i ] ].
	^ importer model namespaceForPath: ('.' join: segments)
]
