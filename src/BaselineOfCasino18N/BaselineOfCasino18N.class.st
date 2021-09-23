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
]
