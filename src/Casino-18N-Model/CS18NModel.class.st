Class {
	#name : #CS18NModel,
	#superclass : #MooseModel,
	#instVars : [
		'nameConflicts',
		'multiValueEntries',
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
	"check for conflict with any subnamespace's name"
	(nameConflicts includes: namespace completeName) ifFalse: [ 
		(namespace containables anySatisfy: [ :containable | 
			 containable class == CS18NNamespace and: [ 
				 namespace name = keyName ] ]) ifTrue: [ 
			('' join: { 
					 'Conflicting namespace and key: '''.
					 namespace completeName.
					 $' }) record.
			nameConflicts add: namespace completeName ] ].
	"end of conflict check"
	^ namespace containables
		  detect: [ :containable | 
			  containable class == CS18NEntry and: [ 
				  containable key name = keyName ] ]
		  ifOne: [ :entry | "warn that we found multiple values in the same entry (and in the same language but we're not checking that yet)"
			  (multiValueEntries includes: entry) ifFalse: [ 
				  ('' join: { 
						   'Multiple values for the same language in entry: '''.
						   entry completeName.
						   $' }) record.
				  multiValueEntries add: entry ].
			  "end of multivalue warning"
			  entry ]
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

{ #category : #initialization }
CS18NModel >> initialize [

	super initialize.
	multiValueEntries := Set new.
	nameConflicts := Set new
]

{ #category : #accessing }
CS18NModel >> multiValueEntries [

	^ multiValueEntries
]

{ #category : #accessing }
CS18NModel >> nameConflicts [

	^ nameConflicts
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

	| namespaceName |
	namespaceName := aQualifiedName copyUpTo: $..
	"check for conflict with any entry's key"
	(nameConflicts includes: ('.' join: { 
				  parentNamespace completeName.
				  namespaceName })) ifFalse: [ 
		parentNamespace containables
			detect: [ :containable | 
				containable class == CS18NEntry and: [ 
					containable key name = namespaceName ] ]
			ifOne: [ :entry | 
				('' join: { 
						 'Conflicting key and namespace: '''.
						 entry completeName.
						 $' }) record.
				nameConflicts add: entry completeName ] ].
	"end of conflict check"
	^ (aQualifiedName includes: $.)
		  ifFalse: [ parentNamespace ensureSubNamespace: namespaceName ]
		  ifTrue: [ 
			  self
				  namespaceForPath: (aQualifiedName copyAfter: $.)
				  from: (parentNamespace ensureSubNamespace: namespaceName) ]
]
