"
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
		'currentLanguage'
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
CS18NPropertiesImporter >> importFile: aFileReference [

	| fileShortName |
	fileShortName := (aFileReference absolutePath basenameWithoutExtension substrings: '_') second.
	currentLanguage := (self model allWithType: CS18NLanguage)
		                   detect: [ :language | language shortName = fileShortName ]
		                   ifNone: [ 
			                   (self createInModel: CS18NLanguage)
				                   shortName: fileShortName;
				                   yourself ].
	self importString: aFileReference contents
]

{ #category : #accessing }
CS18NPropertiesImporter >> importString: aString [

	(parser parse: aString) do: [ :keyValue | 
		(self model allWithType: CS18NEntry) asOrderedCollection
			detect: [ :entry | entry key name = keyValue key ]
			ifOne: [ :entry | 
				entry addValue: ((self createInModel: CS18NValue)
						 name: keyValue value;
						 language: currentLanguage;
						 yourself) ]
			ifNone: [ 
				(self createInModel: CS18NEntry)
					key: ((self createInModel: CS18NKey)
							 name: keyValue key;
							 yourself);
					addValue: ((self createInModel: CS18NValue)
							 name: keyValue value;
							 language: currentLanguage;
							 yourself);
					yourself ] ]
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
