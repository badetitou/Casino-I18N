Class {
	#name : #CS18NPropertiesExporter,
	#superclass : #Object,
	#instVars : [
		'model',
		'language',
		'stream'
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
						        ifOne: [ :value | value name ]
						        ifNone: [ '' ]) ] ]
		       as: SortedCollection.
	^ dic asOrderedDictionary
]

{ #category : #exporting }
CS18NPropertiesExporter >> export [

	NeoJSONWriter new
		on: stream;
		prettyPrint: true;
		nextPut: (self constructNamespace: model rootNamespace)
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
CS18NPropertiesExporter >> stream [
	^ stream
]

{ #category : #accessing }
CS18NPropertiesExporter >> stream: anObject [

	stream := anObject
]
