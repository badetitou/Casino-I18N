"
I use a key and its qualifiers to create or retrieve a path of namespaces to an entry from the importer's current namespace.

```
CS18NPropertiesImporter new entryStrategy:
	CS18NNestedEntryStrategy new.
```
"
Class {
	#name : #CS18NNestedEntryStrategy,
	#superclass : #CS18NAbstractEntryStrategy,
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #strategy }
CS18NNestedEntryStrategy >> entryForKey: aKeyName [

	"I create or retrieve an entry through a path with the given qualified key name.
	For a key named 'foo.bar' I will answer a CS18NEntry with a key named 'bar' in the 'foo' namespace."

	^ importer model
		  entryForPath: aKeyName
		  from: importer currentNamespace
]
