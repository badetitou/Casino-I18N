Extension { #name : #CS18NModel }

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> createEntry [
	^ self add: CS18NEntry new
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> createKey [
	^ self add: CS18NKey new
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> createLanguage [
	^ self add: CS18NLanguage new
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> createNamespace [
	^ self add: CS18NNamespace new
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> createValue [
	^ self add: CS18NValue new
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> ensureEntry: aKeyName [

	"Ensure the existence of an entry under the root with the given key name."

	^ self rootNamespace ensureEntry: aKeyName
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> ensureLanguage: aLanguageShortName [

	"Ensure the existence of a language with the given short name."

	^ (self allWithType: CS18NLanguage)
		  detect: [ :lang | lang shortName = aLanguageShortName ]
		  ifNone: [ self createLanguage shortName: aLanguageShortName ]
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> ensureNamespace: aName [

	"Ensure the existence of a namespace under the root with the given name."

	^ self rootNamespace ensureNamespace: aName
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> entryForPath: aQualifiedKey [

	^ self entryForPath: aQualifiedKey from: self rootNamespace
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> entryForPath: aQualifiedKey from: parentNamespace [

	"I create or retrieve a hierarchy of namespaces qualifying a key, relative to the given parent namespace.
	The entry for the key is also created or retrieved, then returned.
	For example, the path 'foo.bar.bla' refers to the entry with the key 'bla' in the namespace 'bar', in the parent namespace 'foo'."

	^ (aQualifiedKey includes: $.)
		  ifFalse: [ parentNamespace ensureEntry: aQualifiedKey ]
		  ifTrue: [ 
			  | namespace |
			  namespace := self
				               namespaceForPath: (aQualifiedKey copyUpToLast: $.)
				               from: parentNamespace.
			  namespace ensureEntry: (aQualifiedKey copyAfterLast: $.) ]
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> namespaceForPath: aQualifiedName [

	^ self namespaceForPath: aQualifiedName from: self rootNamespace
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> namespaceForPath: aQualifiedName from: parentNamespace [

	^ (aQualifiedName includes: $.)
		  ifFalse: [ parentNamespace ensureNamespace: aQualifiedName ]
		  ifTrue: [ 
			  self
				  namespaceForPath: (aQualifiedName copyAfter: $.)
				  from:
				  (parentNamespace ensureNamespace: (aQualifiedName copyUpTo: $.)) ]
]

{ #category : #'*Casino-18N-Model-Extension' }
CS18NModel >> rootNamespace [

	^ (self allWithType: CS18NRootNamespace)
		  ifEmpty: [ self add: CS18NRootNamespace new ]
		  ifNotEmpty: [ :root | root first ]
]
