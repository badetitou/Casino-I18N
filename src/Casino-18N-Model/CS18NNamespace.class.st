"
Include a group of key or other namespace
"
Class {
	#name : #CS18NNamespace,
	#superclass : #CS18NEntity,
	#traits : 'CS18Ncontainable',
	#classTraits : 'CS18Ncontainable classTrait',
	#instVars : [
		'#containables => FMMany type: #CS18Ncontainable opposite: #namespace',
		'#name => FMProperty'
	],
	#category : #'Casino-18N-Model-Entities'
}

{ #category : #meta }
CS18NNamespace class >> annotation [

	<FMClass: #Namespace super: #CS18NEntity>
	<package: #'Casino-18N-Model'>
	<generated>
	^self
]

{ #category : #adding }
CS18NNamespace >> addContainable: anObject [
	<generated>
	^ self containables add: anObject
]

{ #category : #accessing }
CS18NNamespace >> containables [
	"Relation named: #containables type: #CS18Ncontainable opposite: #namespace"

	<generated>
	<derived>
	^ containables
]

{ #category : #accessing }
CS18NNamespace >> containables: anObject [

	<generated>
	containables value: anObject
]

{ #category : #navigation }
CS18NNamespace >> containablesGroup [
	<generated>
	<navigation: 'Containables'>
	^ MooseSpecializedGroup withAll: self containables asSet
]

{ #category : #accessing }
CS18NNamespace >> name [

	<FMProperty: #name type: #String>
	<generated>
	^ name
]

{ #category : #accessing }
CS18NNamespace >> name: anObject [
	<generated>
	name := anObject
]
