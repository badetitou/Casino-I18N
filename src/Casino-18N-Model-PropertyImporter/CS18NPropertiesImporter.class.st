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
		'languageStrategy',
		'entryStrategy',
		'logger'
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
CS18NPropertiesImporter >> entryStrategy: anEntryStrategy [

	"I take a strategy to define entries and link with it."

	entryStrategy := anEntryStrategy.
	entryStrategy importer: self
]

{ #category : #accessing }
CS18NPropertiesImporter >> importFile: aFileReference [

	currentLanguage := languageStrategy languageForFile: aFileReference.
	currentNamespace := namespaceStrategy namespaceForFile: aFileReference.
	self importString: aFileReference contents
]

{ #category : #accessing }
CS18NPropertiesImporter >> importString: aString [

	(parser parse: aString) do: [ :keyValue | 
		(entryStrategy entryForKey: keyValue key) addValue: (CS18NValue new
				 name: keyValue value;
				 language: currentLanguage) ]
]

{ #category : #initialization }
CS18NPropertiesImporter >> initialize [

	super initialize.
	parser := CS18NPropertiesParser new
]

{ #category : #accessing }
CS18NPropertiesImporter >> languageStrategy: aLanguageStrategy [

	"I take a strategy to define languages and link with it."

	languageStrategy := aLanguageStrategy.
	languageStrategy importer: self
]

{ #category : #accessing }
CS18NPropertiesImporter >> model [

	^ model
]

{ #category : #accessing }
CS18NPropertiesImporter >> model: anObject [

	model := anObject
]

{ #category : #accessing }
CS18NPropertiesImporter >> namespaceStrategy: aNamespaceStrategy [

	"I take a strategy to define toplevel namespaces and link with it."

	namespaceStrategy := aNamespaceStrategy.
	namespaceStrategy importer: self
]
