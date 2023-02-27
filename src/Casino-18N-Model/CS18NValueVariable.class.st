"
A Variable inside an i18n entry's value
"
Class {
	#name : #CS18NValueVariable,
	#superclass : #CS18NEntity,
	#instVars : [
		'#name => FMProperty',
		'#startPos => FMProperty',
		'#endPont => FMProperty',
		'#value => FMOne type: #CS18NValue opposite: #valueVariables'
	],
	#category : #'Casino-18N-Model-Entities'
}

{ #category : #meta }
CS18NValueVariable class >> annotation [

	<FMClass: #ValueVariable super: #CS18NEntity>
	<package: #'Casino-18N-Model'>
	<generated>
	^self
]

{ #category : #accessing }
CS18NValueVariable >> endPont [

	<FMProperty: #endPont type: #Number>
	<generated>
	^ endPont
]

{ #category : #accessing }
CS18NValueVariable >> endPont: anObject [
	<generated>
	endPont := anObject
]

{ #category : #accessing }
CS18NValueVariable >> name [

	<FMProperty: #name type: #String>
	<generated>
	^ name
]

{ #category : #accessing }
CS18NValueVariable >> name: anObject [
	<generated>
	name := anObject
]

{ #category : #accessing }
CS18NValueVariable >> startPos [

	<FMProperty: #startPos type: #Number>
	<generated>
	^ startPos
]

{ #category : #accessing }
CS18NValueVariable >> startPos: anObject [
	<generated>
	startPos := anObject
]

{ #category : #accessing }
CS18NValueVariable >> value [
	"Relation named: #value type: #CS18NValue opposite: #valueVariables"

	<generated>
	^ value
]

{ #category : #accessing }
CS18NValueVariable >> value: anObject [

	<generated>
	value := anObject
]
