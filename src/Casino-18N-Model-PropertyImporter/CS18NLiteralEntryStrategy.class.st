"
I use a key as a literal to create or retrieve an entry in a model.

```
CS18NPropertiesImporter new entryStrategy:
	CS18NLiteralEntryStrategy new.
```
"
Class {
	#name : #CS18NLiteralEntryStrategy,
	#superclass : #CS18NAbstractEntryStrategy,
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NLiteralEntryStrategy >> entryForKey: aKeyName [

	"I create or retrieve an entry with the given key name.
	For a key named 'foo.bar' I will answer a CS18NEntry with a key named 'foo.bar'"

	^ importer currentNamespace ensureEntry: aKeyName
]
