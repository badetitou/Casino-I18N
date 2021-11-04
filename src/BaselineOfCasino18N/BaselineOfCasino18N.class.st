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

	spec
		group: 'default'
		with: #( 'Casino-18N-Model' 'Casino-18N-Model-Generator'
			   'Casino-18N-Model-PropertyExporter'
			   'Casino-18N-Model-PropertyImporter'
			   'Casino-18N-Model-PropertyImporter-Tests' )
]

{ #category : #baselines }
BaselineOfCasino18N >> definePackages: spec [

	"Support I18N"

	spec
		package: 'Casino-18N-Model';
		package: 'Casino-18N-Model-Generator';
		package: 'Casino-18N-Model-PropertyExporter'
		with: [ spec requires: #( 'NeoJSON' ) ];
		package: 'Casino-18N-Model-PropertyImporter'
		with: [ spec requires: #( 'PetitParser2' ) ];
		package: 'Casino-18N-Model-PropertyImporter-Tests'
		with: [ spec requires: #( 'Casino-18N-Model-PropertyImporter' ) ].
	"Link with the main Casino Project"
	spec
		package: 'CasinoExtension-18N-Model';
		package: 'CasinoExtension-18N-Model-Generator';
		package: 'CasinoExtension-18N-ModelTransformation'
]
