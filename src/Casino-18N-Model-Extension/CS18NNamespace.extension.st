Extension { #name : #CS18NNamespace }

{ #category : #'*Casino-18N-Model-Extension' }
CS18NNamespace >> completeName [

	^ (self namespace
		  ifNotNil: [ :parentNamespace | parentNamespace completeName , '.' ]
		  ifNil: [ '' ]) , self name
]
