Extension { #name : #CS18NNamespace }

{ #category : #'*Casino-18N-Model-Extension' }
CS18NNamespace >> ensureEntry: aKeyName [

	"Ensure the existence of an entry with the given key name."

	^ self containables
		  detect: [ :containable | 
			  containable isEntry and: [ containable key name = aKeyName ] ]
		  ifNone: [ 
			  self addContainable: (self mooseModel createEntry
					   key: (self mooseModel createKey
							    name: aKeyName;
							    yourself);
					   yourself) ]
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NNamespace >> ensureNamespace: aName [

	"Ensure the existence of a subnamespace with the given name."

	^ self containables
		  detect: [ :containable | 
			  containable isNamespace and: [ containable name = aName ] ]
		  ifNone: [ 
		  self addContainable: (self mooseModel createNamespace name: aName) ]
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NNamespace >> isNamespace [

	^ true
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NNamespace >> isRootNamespace [

	^ false
]
