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

{ #category : #factory }
CS18NPropertiesImporter >> createEntry [
	^ self createInModel: CS18NEntry
]

{ #category : #accessing }
CS18NPropertiesImporter >> createInModel: entity [

	^ model add: entity new
]

{ #category : #factory }
CS18NPropertiesImporter >> createKey [
	^ self createInModel: CS18NKey
]

{ #category : #factory }
CS18NPropertiesImporter >> createLanguage [
	^ self createInModel: CS18NLanguage
]

{ #category : #factory }
CS18NPropertiesImporter >> createNamespace [
	^ self createInModel: CS18NNamespace
]

{ #category : #factory }
CS18NPropertiesImporter >> createValue [
	^ self createInModel: CS18NValue
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

	logger ifNotNil: [ 
		logger record:
			'Importing file: ' , aFileReference fullName ].
	currentLanguage := languageStrategy languageForFile: aFileReference.
	currentNamespace := namespaceStrategy namespaceForFile:
		                    aFileReference.
	self importString: aFileReference contents
]

{ #category : #accessing }
CS18NPropertiesImporter >> importString: aString [

	(parser parse: aString) do: [ :keyValue | 
		(entryStrategy entryForKey: keyValue key) addValue: (self createValue
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

{ #category : #logging }
CS18NPropertiesImporter >> logMultiValueEntries [

	"Log every entry that has multiple values with the same language."

	logger ifNil: [ ^ nil ].
	logger
		execute: [ 
			(model allWithType: CS18NEntry) do: [ :entry | 
				| languageValues isMultiValue |
				languageValues := Dictionary new.
				isMultiValue := false.
				entry values do: [ :value | 
					languageValues
						at: value language shortName
						update: [ :values | 
							isMultiValue := true.
							values
								add: value;
								yourself ]
						initial: [ 
							OrderedCollection new
								add: value;
								yourself ] ].
				isMultiValue ifTrue: [ 
					logger
						execute: [ 
							languageValues keysAndValuesDo: [ :lang :values | 
								values size > 1 ifTrue: [ 
									logger
										execute: [ values do: [ :value | logger record: value name ] ]
										recordedAs: ('' join: { 
													 'language: '.
													 lang }) ] ] ]
						recordedAs: ('' join: { 
									 'entry: '.
									 entry completeName }) ] ] ]
		recordedAs: 'entries with multiple values for the same language.'
]

{ #category : #logging }
CS18NPropertiesImporter >> logNameConflicts [

	"Log every conflict between a namespace and an entry key."

	logger ifNil: [ ^ nil ].
	logger
		execute: [ 
			(model allWithType: CS18NEntry) do: [ :entry | 
				entry namespace containables
					detect: [ :containable | 
						containable class == CS18NNamespace and: [ 
							containable name = entry key name ] ]
					ifOne: [ :namespace | logger record: namespace completeName ] ] ]
		recordedAs: 'conflicts between namespaces and entries.'
]

{ #category : #accessing }
CS18NPropertiesImporter >> logger [

	^ logger
]

{ #category : #accessing }
CS18NPropertiesImporter >> logger: aLogger [

	logger := aLogger
]

{ #category : #accessing }
CS18NPropertiesImporter >> model [

	^ model
]

{ #category : #accessing }
CS18NPropertiesImporter >> model: anObject [

	model := anObject.
	model importer: self
]

{ #category : #accessing }
CS18NPropertiesImporter >> namespaceStrategy: aNamespaceStrategy [

	"I take a strategy to define toplevel namespaces and link with it."

	namespaceStrategy := aNamespaceStrategy.
	namespaceStrategy importer: self
]
