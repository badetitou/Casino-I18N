Class {
	#name : #CS18NPropertiesImporterTest,
	#superclass : #TestCase,
	#instVars : [
		'importer'
	],
	#category : #'Casino-18N-Model-PropertyImporter-Tests'
}

{ #category : #tests }
CS18NPropertiesImporterTest >> setUp [
	super setUp.
	importer := CS18NPropertiesImporter new.
	importer model: CS18NModel new.
	importer currentNamespace: ((importer createInModel: CS18NNamespace) name: 'foo'; yourself).
]

{ #category : #tests }
CS18NPropertiesImporterTest >> testEntryForPathRepeatingName [
	| anEntry |
	anEntry := importer entryForPath: 'foo.foo'.
	self assert: anEntry key name equals: 'foo'.
	self assert: anEntry namespace name equals: 'foo'.
	self assert: anEntry namespace namespace name equals: 'foo'.
]

{ #category : #tests }
CS18NPropertiesImporterTest >> testEntryForPathRetrieveNamespace [
	| aFirstEntry aSecondEntry |
	aFirstEntry := importer entryForPath: 'bar.bla'.
	aSecondEntry := importer entryForPath: 'bar.ble'.
	self assert: aFirstEntry namespace equals: aSecondEntry namespace.
]

{ #category : #tests }
CS18NPropertiesImporterTest >> testEntryForPathSimple [
	| anEntry |
	anEntry := importer entryForPath: 'bar.bla'.
	self assert: anEntry key name equals: 'bla'.
	self assert: anEntry namespace name equals: 'bar'.
	self assert: anEntry namespace namespace name equals: 'foo'.
]
