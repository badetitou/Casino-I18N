"
An element that can be add in a `CS18NNamespace`
"
Trait {
	#name : #CS18Ncontainable,
	#instVars : [
		'#namespace => FMOne type: #CS18NNamespace opposite: #containables'
	],
	#category : #'Casino-18N-Model-Traits'
}

{ #category : #meta }
CS18Ncontainable classSide >> annotation [

	<FMClass: #containable super: #Object>
	<package: #'Casino-18N-Model'>
	<generated>
	^self
]

{ #category : #accessing }
CS18Ncontainable >> namespace [
	"Relation named: #namespace type: #CS18NNamespace opposite: #containables"

	<generated>
	<container>
	^ namespace
]

{ #category : #accessing }
CS18Ncontainable >> namespace: anObject [

	<generated>
	namespace := anObject
]

{ #category : #navigation }
CS18Ncontainable >> namespaceGroup [
	<generated>
	<navigation: 'Namespace'>
	^ MooseSpecializedGroup with: self namespace
]
