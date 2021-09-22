"
An i18n entry's key
"
Class {
	#name : #CS18NKey,
	#superclass : #CS18NEntity,
	#instVars : [
		'#entry => FMOne type: #CS18NEntry opposite: #key'
	],
	#category : #'Casino-18N-Model-Entities'
}

{ #category : #meta }
CS18NKey class >> annotation [

	<FMClass: #Key super: #CS18NEntity>
	<package: #'Casino-18N-Model'>
	<generated>
	^self
]

{ #category : #accessing }
CS18NKey >> entry [
	"Relation named: #entry type: #CS18NEntry opposite: #key"

	<generated>
	<container>
	<derived>
	^ entry
]

{ #category : #accessing }
CS18NKey >> entry: anObject [

	<generated>
	entry := anObject
]

{ #category : #navigation }
CS18NKey >> entryGroup [
	<generated>
	<navigation: 'Entry'>
	^ MooseSpecializedGroup with: self entry
]
