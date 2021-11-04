Extension { #name : #CSNUIName }

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CSNUIName >> i18nEntry [
	"Relation named: #i18nEntry type: #CS18NEntry opposite: #name"

	<generated>
	<FMProperty: #i18nEntry type: #CS18NEntry opposite: #name>
	<package: #'CasinoExtension-18N-Model'>
	^ self attributeAt: #i18nEntry ifAbsent: [ nil ]
]

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CSNUIName >> i18nEntry: anObject [

	<generated>
	(self attributeAt: #i18nEntry ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self i18nEntry.
		self attributeAt: #i18nEntry put: anObject.
		otherSide name: nil ]
	ifNotNil: [ 
		self attributeAt: #i18nEntry put: anObject.
		anObject name: self ]
]
