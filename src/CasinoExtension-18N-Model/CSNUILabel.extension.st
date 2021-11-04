Extension { #name : #CSNUILabel }

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CSNUILabel >> i18nEntry [
	"Relation named: #i18nEntry type: #CS18NEntry opposite: #label"

	<generated>
	<FMProperty: #i18nEntry type: #CS18NEntry opposite: #label>
	<package: #'CasinoExtension-18N-Model'>
	^ self attributeAt: #i18nEntry ifAbsent: [ nil ]
]

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CSNUILabel >> i18nEntry: anObject [

	<generated>
	(self attributeAt: #i18nEntry ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self i18nEntry.
		self attributeAt: #i18nEntry put: anObject.
		otherSide label: nil ]
	ifNotNil: [ 
		self attributeAt: #i18nEntry put: anObject.
		anObject label: self ]
]
