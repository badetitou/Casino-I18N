"
An i18n entry's value
"
Class {
	#name : #CS18NValue,
	#superclass : #CS18NEntity,
	#instVars : [
		'#entry => FMOne type: #CS18NEntry opposite: #values',
		'#language => FMOne type: #CS18NLanguage opposite: #values',
		'#name => FMProperty',
		'#valueVariables => FMMany type: #CS18NValueVariable opposite: #value'
	],
	#category : #'Casino-18N-Model-Entities'
}

{ #category : #meta }
CS18NValue class >> annotation [

	<FMClass: #Value super: #CS18NEntity>
	<package: #'Casino-18N-Model'>
	<generated>
	^self
]

{ #category : #adding }
CS18NValue >> addValueVariable: anObject [
	<generated>
	^ self valueVariables add: anObject
]

{ #category : #accessing }
CS18NValue >> entry [
	"Relation named: #entry type: #CS18NEntry opposite: #values"

	<generated>
	<container>
	^ entry
]

{ #category : #accessing }
CS18NValue >> entry: anObject [

	<generated>
	entry := anObject
]

{ #category : #navigation }
CS18NValue >> entryGroup [
	<generated>
	<navigation: 'Entry'>
	^ MooseSpecializedGroup with: self entry
]

{ #category : #accessing }
CS18NValue >> language [
	"Relation named: #language type: #CS18NLanguage opposite: #values"

	<generated>
	^ language
]

{ #category : #accessing }
CS18NValue >> language: anObject [

	<generated>
	language := anObject
]

{ #category : #accessing }
CS18NValue >> name [

	<FMProperty: #name type: #String>
	<generated>
	^ name
]

{ #category : #accessing }
CS18NValue >> name: anObject [
	<generated>
	name := anObject
]

{ #category : #accessing }
CS18NValue >> valueVariables [
	"Relation named: #valueVariables type: #CS18NValueVariable opposite: #value"

	<generated>
	<derived>
	^ valueVariables
]

{ #category : #accessing }
CS18NValue >> valueVariables: anObject [

	<generated>
	valueVariables value: anObject
]
