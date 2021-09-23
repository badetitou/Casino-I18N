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

{ #category : #'as yet unclassified' }
CS18NPropertiesExporter >> constructNamespace: aNamespace [

	| dic |
	dic := Dictionary new.
	aNamespace containables do: [ :containable | 
		(containable isKindOf: CS18NNamespace)
			ifTrue: [ dic at: containable name put: (self constructNamespace: containable) ]
			ifFalse: [ "should be an CS18NEntry" 
				dic at: containable key name put: (containable values detect: [ :value | value language = language ] ifOne: [ :value | value name ] ifNone: [ '' ]) ] ].
	^ dic
]

{ #category : #'as yet unclassified' }
CS18NPropertiesExporter >> export [

	| writter rootDic |
	writter := NeoJSONWriter new.
	writter for: CS18NNamespace customDo: [ :mapper | mapper encoder: [ :namespace | (self constructNamespace: namespace) asDictionary ] ].
	rootDic := Dictionary new.
	(model allWithType: CS18NNamespace)
		select: [ :namespace | namespace namespace isNil ]
		thenDo: [ :namespace | rootDic at: namespace name put: namespace ].
	writter
		on: self stream;
		prettyPrint: true;
		nextPut: rootDic
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
