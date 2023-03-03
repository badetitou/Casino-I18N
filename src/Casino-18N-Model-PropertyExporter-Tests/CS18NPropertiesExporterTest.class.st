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
	exporter := CS18NPropertiesExporter new model: model.
	exporter newLine: String cr
]

{ #category : #running }
CS18NPropertiesExporterTest >> testExportEmptyModel [

	| result |
	result := String streamContents: [ :stream | exporter stream: stream; export ].
	self assert: result equals: '{ }'
]

{ #category : #running }
CS18NPropertiesExporterTest >> testExportSimpleModel [

	| result entry language |
	language := CS18NLanguage new
		            shortName: #fr;
		            yourself.
	model add: language.

	entry := CS18NEntry new
		         key: (CS18NKey new
				          name: 'hello';
				          yourself);
		         yourself.
	(CS18NValue new
		 name: 'value';
		 language: language;
		 entry: entry yourself).
	model rootNamespace addContainable: entry.
	model add: entry.
	model add: entry key.
	model addAll: entry values.
	result := String streamContents: [ :stream | 
		          exporter
			          stream: stream;
			          language: language;
			          export ].
	self assert: result equals: '{
	"hello" : "value"
}'
]

{ #category : #running }
CS18NPropertiesExporterTest >> testExportValueWithAttribute [

	| result entry language value |
	language := CS18NLanguage new
		            shortName: #fr;
		            yourself.
	model add: language.

	entry := CS18NEntry new
		         key: (CS18NKey new
				          name: 'hello';
				          yourself);
		         yourself.
	value := CS18NValue new
		         name: 'value [%]';
		         language: language;
		         entry: entry;
		         yourself.
	value addValueVariable: (CS18NValueVariable new
			 name: 'noname';
			 startPos: 7;
			 endPos: 9;
			 yourself).
	model rootNamespace addContainable: entry.
	model add: entry.
	model add: entry key.
	model addAll: entry values.
	result := String streamContents: [ :stream | 
		          exporter
			          stream: stream;
			          language: language;
			          export ].
	self assert: result equals: '{
	"hello" : "value {{noname}}"
}'
]

{ #category : #running }
CS18NPropertiesExporterTest >> testExportValueWithNamedAttribute [

	| result entry language value |
	language := CS18NLanguage new
		            shortName: #fr;
		            yourself.
	model add: language.

	entry := CS18NEntry new
		         key: (CS18NKey new
				          name: 'hello';
				          yourself);
		         yourself.
	value := CS18NValue new
		         name: 'value {label}';
		         language: language;
		         entry: entry;
		         yourself.
	value addValueVariable: (CS18NValueVariable new
			 name: 'label';
			 startPos: 7;
			 endPos: 13;
			 yourself).
	model rootNamespace addContainable: entry.
	model add: entry.
	model add: entry key.
	model addAll: entry values.
	result := String streamContents: [ :stream | 
		          exporter
			          stream: stream;
			          language: language;
			          export ].
	self assert: result equals: '{
	"hello" : "value {{label}}"
}'
]
