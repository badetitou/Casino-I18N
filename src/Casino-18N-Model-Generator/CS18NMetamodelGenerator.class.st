Class {
	#name : #CS18NMetamodelGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'language',
		'entry',
		'key',
		'value',
		'namespace',
		'containable',
		'entity',
		'valueVariable'
	],
	#category : #'Casino-18N-Model-Generator'
}

{ #category : #accessing }
CS18NMetamodelGenerator class >> packageName [

	<ignoreForCoverage>
	^ #'Casino-18N-Model'
]

{ #category : #accessing }
CS18NMetamodelGenerator class >> prefix [

	<ignoreForCoverage>
	^ #'CS18N'
]

{ #category : #accessing }
CS18NMetamodelGenerator class >> submetamodels [
	^ { FamixMooseQueryGenerator }
]

{ #category : #definition }
CS18NMetamodelGenerator >> defineClasses [
	super defineClasses.
	entity := builder newClassNamed: 'Entity'.
	language := builder newClassNamed: 'Language' comment: 'A language'.
	entry := builder newClassNamed: 'Entry' comment: 'An i18n entry'.
	key := builder newClassNamed: 'Key' comment: 'An i18n entry''s key'.
	value := builder newClassNamed: 'Value' comment: 'An i18n entry''s value'.
	valueVariable := builder newClassNamed: 'ValueVariable' comment: 'A Variable inside an i18n entry''s value'.
	namespace := builder newClassNamed: 'Namespace' comment: 'Include a group of key or other namespace'
]

{ #category : #definition }
CS18NMetamodelGenerator >> defineHierarchy [
	super defineHierarchy.
	entity --|> #TEntityMetaLevelDependency.
	namespace --|> containable.
	entry --|> containable.
]

{ #category : #definition }
CS18NMetamodelGenerator >> defineProperties [

	super defineProperties.
	language property: #shortName type: #String.
	key property: #name type: #String.
	value property: #name type: #String.
	namespace property: #name type: #String.
	valueVariable property: #name type: #String.
	valueVariable property: #startPos type: #Number.
	valueVariable property: #endPont type: #Number
]

{ #category : #definition }
CS18NMetamodelGenerator >> defineRelations [
	super defineRelations.
	entry <>- key.
	entry <>-* value.
	language -* value.
	namespace <>-* containable.
	value -* valueVariable
]

{ #category : #definition }
CS18NMetamodelGenerator >> defineTraits [
	super defineTraits.
	containable := builder newTraitNamed: 'containable' comment: 'An element that can be add in a `CS18NNamespace`' 
]
