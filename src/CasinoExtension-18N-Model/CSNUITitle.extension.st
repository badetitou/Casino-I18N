Extension { #name : #CSNUITitle }

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CSNUITitle >> i18nEntry [
	"Relation named: #i18nEntry type: #CS18NEntry opposite: #title"

	<generated>
	<FMProperty: #i18nEntry type: #CS18NEntry opposite: #title>
	<package: #'CasinoExtension-18N-Model'>
	^ self attributeAt: #i18nEntry ifAbsent: [ nil ]
]

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CSNUITitle >> i18nEntry: anObject [

	<generated>
	(self attributeAt: #i18nEntry ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self i18nEntry.
		self attributeAt: #i18nEntry put: anObject.
		otherSide title: nil ]
	ifNotNil: [ 
		self attributeAt: #i18nEntry put: anObject.
		anObject title: self ]
]
