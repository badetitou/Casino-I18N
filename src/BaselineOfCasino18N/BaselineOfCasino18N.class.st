Class {
	#name : #BaselineOfCasino18N,
	#superclass : #BaselineOf,
	#category : #BaselineOfCasino18N
}

{ #category : #baselines }
BaselineOfCasino18N >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			self defineDependencies: spec.
			self definePackages: spec.
			self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfCasino18N >> defineDependencies: spec [

	spec baseline: 'PetitParser2' with: [ spec repository: 'github://kursjan/petitparser2' ].
	spec baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ]
]

{ #category : #baselines }
BaselineOfCasino18N >> defineGroups: spec [
]

{ #category : #baselines }
BaselineOfCasino18N >> definePackages: spec [

	spec
		package: 'Casino-18N-Model';
		package: 'Casino-18N-Model-Generator';
		package: 'Casino-18N-Model-PropertyExporter' with: [ spec requires: #( 'NeoJSON' ) ];
		package: 'Casino-18N-Model-PropertyImporter' with: [ spec requires: #( 'PetitParser2' ) ];
		package: 'Casino-18N-Model-PropertyImporter-Tests' with: [ spec requires: #( 'Casino-18N-Model-PropertyImporter' ) ]
]
