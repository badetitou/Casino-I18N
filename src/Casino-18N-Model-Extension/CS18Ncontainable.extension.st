Extension { #name : #CS18Ncontainable }

{ #category : #'*Casino-18N-Model-Extension' }
CS18Ncontainable >> completeName [

	^ (namespace isNil or: [ namespace isRootNamespace ])
		  ifTrue: [ self name ]
		  ifFalse: [ namespace completeName , '.' , self name ]
]
