Class {
	#name : #CS18NPropertiesExporter,
	#superclass : #Object,
	#instVars : [
		'model',
		'language',
		'stream',
		'newLine'
	],
	#category : #'Casino-18N-Model-PropertyExporter'
}

{ #category : #exporting }
CS18NPropertiesExporter >> constructNamespace: aNamespace [

	| dic |
	dic := aNamespace containables
		       collect: [ :containable | 
			       containable isNamespace
				       ifTrue: [ 
				       containable name -> (self constructNamespace: containable) ]
				       ifFalse: [ "should be an CS18NEntry"
					       containable name -> (containable values
						        detect: [ :value | value language = language ]
						        ifOne: [ :value | self constructValueString: value ]
						        ifNone: [ '' ]) ] ]
		       as: SortedCollection.

	^ dic asOrderedDictionary
]

{ #category : #exporting }
CS18NPropertiesExporter >> constructValueString: aCS18NValue [

	| string |
	string := aCS18NValue name copyReplaceAll: '[%]' with: '{{ noname }}'.

	aCS18NValue valueVariables ifNotNil: [ 
		| col |
		col := aCS18NValue valueVariables select: [ :var | 
			       var name ~= 'noname' ].
		col ifNotEmpty: [ 
			| dic |
			dic := Dictionary new.
			col do: [ :var | dic at: var name put: '{{ ' , var name , ' }}' ].
			string := string format: dic ] ].
	^ string
]

{ #category : #exporting }
CS18NPropertiesExporter >> export [

	| writter |
	writter := NeoJSONWriter new
		           on: stream;
		           prettyPrint: true.
	self newLine ifNotNil: [ writter newLine: self newLine ].
	writter nextPut: (self constructNamespace: model rootNamespace)
]

{ #category : #accessing }
CS18NPropertiesExporter >> language [

	^ language
]

{ #category : #accessing }
CS18NPropertiesExporter >> language: anObject [

	language := anObject
]

{ #category : #accessing }
CS18NPropertiesExporter >> model [

	^ model
]

{ #category : #accessing }
CS18NPropertiesExporter >> model: anObject [

	model := anObject
]

{ #category : #accessing }
CS18NPropertiesExporter >> newLine [

	^ newLine
]

{ #category : #accessing }
CS18NPropertiesExporter >> newLine: anObject [

	newLine := anObject
]

{ #category : #accessing }
CS18NPropertiesExporter >> stream [
	^ stream
]

{ #category : #accessing }
CS18NPropertiesExporter >> stream: anObject [

	stream := anObject
]
