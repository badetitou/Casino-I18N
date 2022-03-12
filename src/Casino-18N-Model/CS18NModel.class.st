Class {
	#name : #CS18NModel,
	#superclass : #MooseModel,
	#instVars : [
		'importer'
	],
	#category : #'Casino-18N-Model-Model'
}

{ #category : #accessing }
CS18NModel class >> allSubmetamodelsPackagesNames [
	<generated>
	^ #(#'Moose-Query')
]

{ #category : #meta }
CS18NModel class >> annotation [
	<FMClass: #CS18NModel super: #MooseModel>
	<package: #'Casino-18N-Model'>
	<generated>
]

{ #category : #'public-entity-creation' }
CS18NModel >> ensureEntry: aKeyName [

	"Ensure the existence of a root entry with the given name."

	^ (self allWithType: CS18NEntry)
		  detect: [ :entry | entry key name = aKeyName ]
		  ifNone: [ 
			  importer createEntry key: (importer createKey
					   name: aKeyName;
					   yourself) ]
]

{ #category : #'public-entity-creation' }
CS18NModel >> ensureLanguage: aLanguageShortName [

	"Ensure the existence of a language with the given short name."

	^ (self allWithType: CS18NLanguage)
		  detect: [ :lang | lang shortName = aLanguageShortName ]
		  ifNone: [ importer createLanguage shortName: aLanguageShortName ]
]

{ #category : #'public-entity-creation' }
CS18NModel >> ensureNamespace: aName [

	"Ensure the existence of a root namespace with the given name."

	^ (self allWithType: CS18NNamespace)
		  detect: [ :namespace | namespace name = aName ]
		  ifNone: [ 
			  importer createNamespace
				  name: aName;
				  yourself ]
]

{ #category : #'public-entity-creation' }
CS18NModel >> entryForPath: aQualifiedKey [

	^ (aQualifiedKey includes: $.)
		  ifFalse: [ self ensureEntry: aQualifiedKey ]
		  ifTrue: [ 
			  self
				  entryForPath: (aQualifiedKey copyAfter: $.)
				  from: (self ensureNamespace: (aQualifiedKey copyUpTo: $.)) ]
]

{ #category : #'public-entity-creation' }
CS18NModel >> entryForPath: aQualifiedKey from: parentNamespace [

	"I create or retrieve a hierarchy of namespaces qualifying a key, relative to the given parent namespace.
	The entry for the key is also created or retrieved, then returned.
	For example, the path 'foo.bar.bla' refers to the entry with the key 'bla' in the namespace 'bar', in the parent namespace 'foo'."

	| keyName namespace |
	(aQualifiedKey includes: $.)
		ifFalse: [ 
			keyName := aQualifiedKey.
			namespace := parentNamespace ]
		ifTrue: [ 
			keyName := aQualifiedKey copyAfterLast: $..
			namespace := self
				             namespaceForPath: (aQualifiedKey copyUpToLast: $.)
				             from: parentNamespace ].
	^ namespace containables
		  detect: [ :containable | 
			  containable class == CS18NEntry and: [ 
				  containable key name = keyName ] ]
		  ifNone: [ 
			  namespace addContainable: (CS18NEntry new
					   namespace: namespace;
					   key: (CS18NKey new name: keyName)) ]
]

{ #category : #accessing }
CS18NModel >> importer [

	^ importer
]

{ #category : #accessing }
CS18NModel >> importer: anObject [

	importer := anObject
]

{ #category : #'public-entity-creation' }
CS18NModel >> namespaceForPath: aQualifiedName [

	^ self
		  namespaceForPath: (aQualifiedName copyAfter: $.)
		  from: (self ensureNamespace: (aQualifiedName copyUpTo: $.))
]

{ #category : #'public-entity-creation' }
CS18NModel >> namespaceForPath: aQualifiedName from: parentNamespace [

	"This method could be in CS18NNamespace but it's kept here for keeping track of conflicts."

	^ (aQualifiedName includes: $.)
		  ifFalse: [ parentNamespace ensureSubNamespace: aQualifiedName ]
		  ifTrue: [ 
			  self
				  namespaceForPath: (aQualifiedName copyAfter: $.)
				  from:
				  (parentNamespace ensureSubNamespace:
					   (aQualifiedName copyUpTo: $.)) ]
]
