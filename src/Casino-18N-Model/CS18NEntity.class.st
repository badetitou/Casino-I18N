Class {
	#name : #CS18NEntity,
	#superclass : #MooseEntity,
	#category : #'Casino-18N-Model-Entities'
}

{ #category : #meta }
CS18NEntity class >> annotation [

	<FMClass: #Entity super: #MooseEntity>
	<package: #'Casino-18N-Model'>
	<generated>
	^self
]

{ #category : #meta }
CS18NEntity class >> metamodel [

	<generated>
	^ CS18NModel metamodel
]
