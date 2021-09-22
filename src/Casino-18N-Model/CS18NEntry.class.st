"
An i18n entry
"
Class {
	#name : #CS18NEntry,
	#superclass : #CS18NEntity,
	#traits : 'CS18Ncontainable',
	#classTraits : 'CS18Ncontainable classTrait',
	#instVars : [
		'#name => FMProperty',
		'#key => FMOne type: #CS18NKey opposite: #entry',
		'#values => FMMany type: #CS18NValue opposite: #entry'
	],
	#category : #'Casino-18N-Model-Entities'
}

{ #category : #meta }
CS18NEntry class >> annotation [

	<FMClass: #Entry super: #CS18NEntity>
	<package: #'Casino-18N-Model'>
	<generated>
	^self
]

{ #category : #adding }
CS18NEntry >> addValue: anObject [
	<generated>
	^ self values add: anObject
]

{ #category : #accessing }
CS18NEntry >> key [
	"Relation named: #key type: #CS18NKey opposite: #entry"

	<generated>
	^ key
]

{ #category : #accessing }
CS18NEntry >> key: anObject [

	<generated>
	key := anObject
]

{ #category : #navigation }
CS18NEntry >> keyGroup [
	<generated>
	<navigation: 'Key'>
	^ MooseSpecializedGroup with: self key
]

{ #category : #accessing }
CS18NEntry >> name [

	<FMProperty: #name type: #String>
	<generated>
	^ name
]

{ #category : #accessing }
CS18NEntry >> name: anObject [
	<generated>
	name := anObject
]

{ #category : #accessing }
CS18NEntry >> values [
	"Relation named: #values type: #CS18NValue opposite: #entry"

	<generated>
	<derived>
	^ values
]

{ #category : #accessing }
CS18NEntry >> values: anObject [

	<generated>
	values value: anObject
]

{ #category : #navigation }
CS18NEntry >> valuesGroup [
	<generated>
	<navigation: 'Values'>
	^ MooseSpecializedGroup withAll: self values asSet
]
