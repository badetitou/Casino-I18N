"
I use a user-defined block to create or retrieve an entry.

```
CS18NPropertiesImporter new entryStrategy:
	(CS18NPluggableEntryStrategy new block: [ :key | ""custom implementation"" ]).
```
"
Class {
	#name : #CS18NPluggableEntryStrategy,
	#superclass : #CS18NAbstractEntryStrategy,
	#traits : 'CS18NPluggable',
	#classTraits : 'CS18NPluggable classTrait',
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NPluggableEntryStrategy >> entryForKey: aKeyName [

	"I create or retrieve an entry with the given key name using the received block."

	^ block value: aKeyName
]
