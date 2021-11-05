Class {
	#name : #CSE18NExporterAngularAttribute,
	#superclass : #CSNExporterAngularAttribute,
	#category : #'CasinoExtension-18N-Model-Exporter'
}

{ #category : #visiting }
CSE18NExporterAngularAttribute >> visitCSNUILabel: aBLUILabel [
	aBLUILabel i18nEntry ifNil: [ ^ super visitCSNUITitle: aBLUILabel ].
	self
		<<< '{{ ''';
		<<< aBLUILabel i18nEntry completeName;
		<<< ''' | translate }}'
]

{ #category : #visiting }
CSE18NExporterAngularAttribute >> visitCSNUIName: aBLUIName [

	aBLUIName i18nEntry ifNil: [ ^ super visitCSNUITitle: aBLUIName ].
	self
		<<< '{{ ''';
		<<< aBLUIName i18nEntry completeName;
		<<< ''' | translate }}'
]

{ #category : #visiting }
CSE18NExporterAngularAttribute >> visitCSNUIPlaceholder: aBLUIPlaceholder [

	aBLUIPlaceholder i18nEntry ifNil: [ 
		^ super visitCSNUITitle: aBLUIPlaceholder ].
	self
		<<< '{{ ''';
		<<< aBLUIPlaceholder i18nEntry completeName;
		<<< ''' | translate }}'
]

{ #category : #visiting }
CSE18NExporterAngularAttribute >> visitCSNUITitle: aBLUITitle [

	aBLUITitle i18nEntry ifNil: [ ^ super visitCSNUITitle: aBLUITitle ].
	self
		<<< '{{ ''';
		<<< aBLUITitle i18nEntry completeName;
		<<< ''' | translate }}'
]
