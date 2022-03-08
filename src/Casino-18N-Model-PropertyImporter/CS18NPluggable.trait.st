"
I define a one-argument block exposed to users for custom implementations.
"
Trait {
	#name : #CS18NPluggable,
	#instVars : [
		'block'
	],
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #accessing }
CS18NPluggable >> block: aBlock [

	block := aBlock
]
