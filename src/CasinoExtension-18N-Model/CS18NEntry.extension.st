Extension { #name : #CS18NEntry }

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CS18NEntry >> label [
	"Relation named: #label type: #CSNUILabel opposite: #i18nEntry"

	<generated>
	<derived>
	<FMProperty: #label type: #CSNUILabel opposite: #i18nEntry>
	<package: #'CasinoExtension-18N-Model'>
	^ self attributeAt: #label ifAbsent: [ nil ]
]

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CS18NEntry >> label: anObject [

	<generated>
	(self attributeAt: #label ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self label.
		self attributeAt: #label put: anObject.
		otherSide i18nEntry: nil ]
	ifNotNil: [ 
		self attributeAt: #label put: anObject.
		anObject i18nEntry: self ]
]

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CS18NEntry >> name: anObject [

	<generated>
	(self attributeAt: #name ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self name.
		self attributeAt: #name put: anObject.
		otherSide i18nEntry: nil ]
	ifNotNil: [ 
		self attributeAt: #name put: anObject.
		anObject i18nEntry: self ]
]

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CS18NEntry >> placeholder [
	"Relation named: #placeholder type: #CSNUIPlaceholder opposite: #i18nEntry"

	<generated>
	<derived>
	<FMProperty: #placeholder type: #CSNUIPlaceholder opposite: #i18nEntry>
	<package: #'CasinoExtension-18N-Model'>
	^ self attributeAt: #placeholder ifAbsent: [ nil ]
]

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CS18NEntry >> placeholder: anObject [

	<generated>
	(self attributeAt: #placeholder ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self placeholder.
		self attributeAt: #placeholder put: anObject.
		otherSide i18nEntry: nil ]
	ifNotNil: [ 
		self attributeAt: #placeholder put: anObject.
		anObject i18nEntry: self ]
]

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CS18NEntry >> title [
	"Relation named: #title type: #CSNUITitle opposite: #i18nEntry"

	<generated>
	<derived>
	<FMProperty: #title type: #CSNUITitle opposite: #i18nEntry>
	<package: #'CasinoExtension-18N-Model'>
	^ self attributeAt: #title ifAbsent: [ nil ]
]

{ #category : #'*CasinoExtension-18N-Model-accessing' }
CS18NEntry >> title: anObject [

	<generated>
	(self attributeAt: #title ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self title.
		self attributeAt: #title put: anObject.
		otherSide i18nEntry: nil ]
	ifNotNil: [ 
		self attributeAt: #title put: anObject.
		anObject i18nEntry: self ]
]
