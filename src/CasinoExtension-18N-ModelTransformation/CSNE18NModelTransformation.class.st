"
I take as input a Casino Model, and I tranform it by adding the I18N information based on a I18N model
"
Class {
	#name : #CSNE18NModelTransformation,
	#superclass : #Object,
	#instVars : [
		'csnModel',
		'i18nModel'
	],
	#category : #'CasinoExtension-18N-ModelTransformation'
}

{ #category : #accessing }
CSNE18NModelTransformation >> csnModel [

	^ csnModel
]

{ #category : #accessing }
CSNE18NModelTransformation >> csnModel: anObject [

	csnModel := anObject
]

{ #category : #accessing }
CSNE18NModelTransformation >> i18nModel [

	^ i18nModel
]

{ #category : #accessing }
CSNE18NModelTransformation >> i18nModel: anObject [

	i18nModel := anObject
]
