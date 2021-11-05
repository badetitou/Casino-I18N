Extension { #name : #CS18NEntry }

{ #category : #'*Casino-18N-Model-Extension' }
CS18NEntry >> completeName [
	^ self namespace completeName , '.', self key name
]
