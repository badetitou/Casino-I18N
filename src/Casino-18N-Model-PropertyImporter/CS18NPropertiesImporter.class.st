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
		'currentNamespace',
		'namespaceStrategy',
		'languageStrategy'
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
		(model entryForPath: keyValue key from: currentNamespace) addValue:
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
