"
A language
"
Class {
	#name : #CS18NLanguage,
	#superclass : #CS18NEntity,
	#instVars : [
		'#shortName => FMProperty',
		'#values => FMMany type: #CS18NValue opposite: #language'
	],
	#category : #'Casino-18N-Model-Entities'
}

{ #category : #meta }
CS18NLanguage class >> annotation [

	<FMClass: #Language super: #CS18NEntity>
	<package: #'Casino-18N-Model'>
	<generated>
	^self
]

{ #category : #adding }
CS18NLanguage >> addValue: anObject [
	<generated>
	^ self values add: anObject
]

{ #category : #accessing }
CS18NLanguage >> shortName [

	<FMProperty: #shortName type: #String>
	<generated>
	^ shortName
]

{ #category : #accessing }
CS18NLanguage >> shortName: anObject [
	<generated>
	shortName := anObject
]

{ #category : #accessing }
CS18NLanguage >> values [
	"Relation named: #values type: #CS18NValue opposite: #language"

	<generated>
	<derived>
	^ values
]

{ #category : #accessing }
CS18NLanguage >> values: anObject [

	<generated>
	values value: anObject
]
