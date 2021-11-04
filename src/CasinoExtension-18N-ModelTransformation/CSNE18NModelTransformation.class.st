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

{ #category : #'private - accessing' }
CSNE18NModelTransformation >> attributesTypeWithText [

	^ { 
		  CSNUILabel.
		  CSNUIPlaceholder.
		  CSNUITitle.
		  CSNUIName }
]

{ #category : #api }
CSNE18NModelTransformation >> bind [

	"I am the entry point when one has configured a csnModel and a i18nModel.
	I bind the attribute of the csnModel with the existing i18nModel entries"

	| attributes |
	attributes := self attributesTypeWithText flatCollect: [ :class | 
		              self csnModel allWithType: class ].
	attributes do: [ :attribute | 
		attribute attributeValue ifNotNil: [ :attributeValue | 
			| compositeValues |
			compositeValues := attributeValue substrings: '.'.
			compositeValues ifNotEmpty: [ 
				(self i18nModel allWithType: CS18NNamespace)
					detect: [ :namespace | namespace name = compositeValues first ]
					ifOne: [ :namespace | 
						| potentialEntryName |
						potentialEntryName := compositeValues last withoutSuffix: '()'.
						(namespace toScope: CS18NEntry)
							detect: [ :entry | entry key name = potentialEntryName ]
							ifOne: [ :entry | attribute i18nEntry: entry ] ] ] ] ]
]

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
