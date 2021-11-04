Class {
	#name : #CSE18NMetamodelGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'entry',
		'label',
		'title',
		'name',
		'placeholder'
	],
	#category : #'CasinoExtension-18N-Model-Generator'
}

{ #category : #accessing }
CSE18NMetamodelGenerator class >> packageName [

	<ignoreForCoverage>
	^ #'CasinoExtension-18N-Model'
]

{ #category : #accessing }
CSE18NMetamodelGenerator class >> prefix [

	<ignoreForCoverage>
	^ #'CSE18N'
]

{ #category : #accessing }
CSE18NMetamodelGenerator class >> submetamodels [

	^ { 
		  CS18NMetamodelGenerator.
		  CSNUISubEntitiesGenerator }
]

{ #category : #definition }
CSE18NMetamodelGenerator >> defineClasses [
	super defineClasses.
	entry := self remoteEntity: #Entry withPrefix: #CS18N.
	label := self remoteEntity: #Label withPrefix: #CSNUI.
	title := self remoteEntity: #Title withPrefix: #CSNUI.
	name := self remoteEntity: #Name withPrefix: #CSNUI.
	placeholder := self remoteEntity: #Placeholder withPrefix: #CSNUI.
]

{ #category : #definition }
CSE18NMetamodelGenerator >> defineRelations [

	super defineRelations.
	(label property: #i18nEntry) - entry.
	(title property: #i18nEntry) - entry.
	(name property: #i18nEntry) - entry.
	(placeholder property: #i18nEntry) - entry
]
