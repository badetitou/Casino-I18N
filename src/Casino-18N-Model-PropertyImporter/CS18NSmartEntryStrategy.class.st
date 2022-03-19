"
I act like `CS18NNestedEntryStrategy` until I find a conflict between an entry and a namespace, then I try to avoid it by ""raising"" the namespace.
Raising a namespace means its own namespace becomes the one for each of its direct containable, and their key is prefixed by the name of the raised namespace.
This essentially removes a level of nesting while conserving the same path.
In the worst case, when there are always conflicts, I act like `CS18NLiteralEntryStrategy`.

```
CS18NPropertiesImporter new entryStrategy:
	CS18NSmartEntryStrategy new.
```
"
Class {
	#name : #CS18NSmartEntryStrategy,
	#superclass : #CS18NAbstractEntryStrategy,
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NSmartEntryStrategy >> entryForKey: aKeyName [

	^ (aKeyName includes: $.)
		  ifFalse: [ "is an entry key" self entryForSimpleKey: aKeyName ]
		  ifTrue: [ "is a qualified key" 
		  self entryForQualifiedKey: aKeyName ]
]

{ #category : #'private - tree building' }
CS18NSmartEntryStrategy >> entryForQualifiedKey: aKeyName [

	"Extract the shortest non-conflicting namespace and use the rest of the path to recursively call #entryForKey:
	If a conflict exists up to the longest namespace composed of every qualifier, aKeyName is used as an entry key in the current namespace."

	^ importer currentNamespace containables
		  detect: [ :containable | "if an entry already exists with this name, the conflicts have already been checked"
			  containable class == CS18NEntry and: [ 
				  containable key name = aKeyName ] ]
		  ifNone: [ "otherwise make the checks"
			  | name rest |
			  name := aKeyName copyUpTo: $..
			  rest := aKeyName copyAfter: $..
			  [ "loop until no rest or no conflict"
			  rest isNotEmpty and: [ 
				  importer currentNamespace containables anySatisfy: [ 
					  :containable | "check for conflicting entry" 
					  containable class == CS18NEntry and: [ 
						  containable key name = name ] ] ] ] whileTrue: [ 
				  name := '' join: { 
						          name.
						          $..
						          (rest copyUpTo: $.) }.
				  rest := rest copyAfter: $. ].
			  rest isEmpty
				  ifTrue: [ "name must be an entry key" 
				  self entryForSimpleKey: name ]
				  ifFalse: [ "found a name for a namespace with no conflict
			update then restore current namespace around recursive call to keep context accurate"
					  | parentNamespace entry |
					  parentNamespace := importer currentNamespace.
					  importer currentNamespace:
						  (parentNamespace ensureNamespace: name).
					  entry := self entryForKey: rest.
					  importer currentNamespace: parentNamespace.
					  entry ] ]
]

{ #category : #'private - tree building' }
CS18NSmartEntryStrategy >> entryForSimpleKey: aKeyName [

	^ importer currentNamespace containables
		  detect: [ :containable | "check if entry already exists"
			  containable class == CS18NEntry and: [ 
				  containable key name = aKeyName ] ]
		  ifNone: [ "check for a conflicting namespace"
			  importer currentNamespace containables
				  detect: [ :containable | 
					  containable class == CS18NNamespace and: [ 
						  containable name = aKeyName ] ]
				  ifOne: [ :namespace | "namespace gives way to new entry" 
					  self raiseNamespace: namespace ].
			  importer currentNamespace ensureEntry: aKeyName ]
]

{ #category : #'private - tree building' }
CS18NSmartEntryStrategy >> raiseNamespace: aNamespace [

	"Raise the containables of aNamespace to its parent namespace."

	aNamespace containables asArray do: [ :containable | "we can't modify links of containables while iterating over them because of FMRelationSlot properties, that's why we use an array copy"
		containable class == CS18NNamespace
			ifTrue: [ 
				containable name: ('.' join: { 
							 aNamespace name.
							 containable name }) ]
			ifFalse: [ "should be an entry"
				containable key name: ('.' join: { 
							 aNamespace name.
							 containable key name }) ].
		containable namespace: aNamespace namespace ].
	"remove references to aNamespace"
	aNamespace namespace: nil.
	importer model remove: aNamespace
]
