"
In properties file of format *myfile_fr*, the language is *fr* and the namespace is *myfile* as a root namespace

Usage example:

```st
| i18nModel importer |
i18nModel := CS18NModel new.

importer := CS18NPropertiesImporter new.
importer model: i18nModel.

importer importFile: 'D:\path\to\file\myfile_en.properties' asFileReference.
importer model
```
"
Class {
	#name : #CS18NPropertiesImporter,
	#superclass : #Object,
	#instVars : [
		'model',
		'parser',
		'currentLanguage',
		'currentNamespace'
	],
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #accessing }
CS18NPropertiesImporter >> createInModel: entity [

	^ model add: entity new
]

{ #category : #accessing }
CS18NPropertiesImporter >> currentLanguage [

	^ currentLanguage
]

{ #category : #accessing }
CS18NPropertiesImporter >> currentLanguage: anObject [

	currentLanguage := anObject
]

{ #category : #accessing }
CS18NPropertiesImporter >> currentNamespace [

	^ currentNamespace
]

{ #category : #accessing }
CS18NPropertiesImporter >> currentNamespace: aNamespace [

	currentNamespace := aNamespace
]

{ #category : #accessing }
CS18NPropertiesImporter >> entryForPath: aQualifiedKey [

	"I create or retrieve a hierarchy of namespaces qualifying a key, relative to the current namespace which I don't modify. The entry for the key is also created or retrieved, then returned.
	For example, the path 'foo.bar.bla' refers to the entry with the key 'bla' in the namespace 'bar', in the parent namespace 'foo'."

	| namespaceNames keyName namespace |
	namespaceNames := aQualifiedKey splitOn: $..
	keyName := namespaceNames removeLast.
	namespace := currentNamespace.
	namespaceNames do: [ :namespaceName | 
		namespace := namespace containables
			             detect: [ :containable | 
				             containable class = CS18NNamespace and:
					             containable name = namespaceName ]
			             ifNone: [ 
				             namespace addContainable:
					             ((self createInModel: CS18NNamespace)
						              name: namespaceName;
						              yourself) ] ].
	^ (namespace toScope: CS18NEntry)
		  detect: [ :entry | entry key name = keyName ]
		  ifNone: [ 
			  (self createInModel: CS18NEntry)
				  namespace: namespace;
				  key: ((self createInModel: CS18NKey)
						   name: keyName;
						   yourself);
				  yourself ]
]

{ #category : #accessing }
CS18NPropertiesImporter >> importFile: aFileReference [

	| fileShortName namespaceName |
	fileShortName := (aFileReference absolutePath basenameWithoutExtension substrings: '_') second.
	namespaceName := (aFileReference absolutePath basenameWithoutExtension substrings: '_') first.
	currentLanguage := (self model allWithType: CS18NLanguage)
		                   detect: [ :language | language shortName = fileShortName ]
		                   ifNone: [ 
			                   (self createInModel: CS18NLanguage)
				                   shortName: fileShortName;
				                   yourself ].
	currentNamespace := (self model allWithType: CS18NNamespace)
		                    detect: [ :namespace | namespace name = namespaceName ]
		                    ifNone: [ 
			                    (self createInModel: CS18NNamespace)
				                    name: namespaceName;
				                    yourself ].
	self importString: aFileReference contents
]

{ #category : #accessing }
CS18NPropertiesImporter >> importString: aString [

	(parser parse: aString) do: [ :keyValue | 
		(self entryForPath: keyValue key) addValue:
			((self createInModel: CS18NValue)
				 name: keyValue value;
				 language: currentLanguage) ]
]

{ #category : #accessing }
CS18NPropertiesImporter >> initialize [
	super initialize.
	parser := CS18NPropertiesParser new
]

{ #category : #accessing }
CS18NPropertiesImporter >> model [

	^ model
]

{ #category : #accessing }
CS18NPropertiesImporter >> model: anObject [

	model := anObject
]
