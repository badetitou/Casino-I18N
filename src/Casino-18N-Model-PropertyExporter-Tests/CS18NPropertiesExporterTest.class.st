"
A CS18NPropertiesExporterTest is a test class for testing the behavior of CS18NPropertiesExporter
"
Class {
	#name : #CS18NPropertiesExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'model',
		'exporter'
	],
	#category : #'Casino-18N-Model-PropertyExporter-Tests'
}

{ #category : #running }
CS18NPropertiesExporterTest >> setUp [

	super setUp.
	model := CS18NModel new.
	exporter := CS18NPropertiesExporter new model: model
]

{ #category : #tests }
CS18NPropertiesExporterTest >> testConstructNamespace [

	| result expected |
	model ensureEntry: 'foo'.
	result := exporter constructNamespace: model rootNamespace.
	expected := { ('foo' -> '') } asOrderedDictionary.
	self assert: result equals: expected.

	(model entryForPath: 'bar.baz') addValue:
		(model createValue name: 'Hi!').
	model entryForPath: 'bar.bla.baz'.
	result := exporter constructNamespace: model rootNamespace.
	expected addAll: { ('bar' -> { 
			 ('baz' -> 'Hi!').
			 ('bla' -> { ('baz' -> '') } asOrderedDictionary) }
			 asOrderedDictionary) }.
	self assert: result equals: expected
]
