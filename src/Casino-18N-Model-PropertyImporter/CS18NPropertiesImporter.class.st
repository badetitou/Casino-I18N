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
		'logger',
		'encoding'
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
CS18NPropertiesImporter >> encoding [

	^ encoding
]

{ #category : #accessing }
CS18NPropertiesImporter >> encoding: anObject [

	encoding := anObject
]

{ #category : #accessing }
CS18NPropertiesImporter >> entryStrategy: anEntryStrategy [

	"I take a strategy to define entries and link with it."

	entryStrategy := anEntryStrategy.
	entryStrategy importer: self
]

{ #category : #'private - importing' }
CS18NPropertiesImporter >> extractModelValueAttributes: aModelValue [

	| attributes ranges rangesRegEx |
	attributes := OrderedCollection new.
	ranges := aModelValue name allRangesOfSubstring: '[%]'.
	ranges do: [ :range | 
		attributes add: (CS18NValueVariable new
				 startPos: range first;
				 endPos: range last;
				 name: 'noname';
				 yourself) ].
	rangesRegEx := aModelValue name allRangesOfRegexMatches: '{[^}]*}'.
	rangesRegEx do: [ :range | 
		attributes add: (CS18NValueVariable new
				 startPos: range first;
				 endPos: range last;
				 name:
					 (aModelValue name copyFrom: range first + 1 to: range last - 1);
				 yourself) ].
	^ attributes
]

{ #category : #importing }
CS18NPropertiesImporter >> importFile: aFileReference [

	logger ifNotNil: [ 
		logger record: 'Importing file: ' , aFileReference fullName ].
	currentLanguage := languageStrategy languageForFile: aFileReference.
	currentNamespace := namespaceStrategy namespaceForFile:
		                    aFileReference.
	self importString:
		(aFileReference readStreamEncoded: self encoding) contents
]

{ #category : #importing }
CS18NPropertiesImporter >> importString: aString [

	(parser parse: aString) do: [ :keyValue | 
		| modelValue valueAttributes |
		modelValue := model createValue
			              name: keyValue value;
			              language: currentLanguage.
		valueAttributes := self extractModelValueAttributes: modelValue.
		modelValue valueVariables addAll: valueAttributes.
		model addAll: valueAttributes.
		(entryStrategy entryForKey: keyValue key) addValue: modelValue ]
]

{ #category : #initialization }
CS18NPropertiesImporter >> initialize [

	super initialize.
	parser := CS18NPropertiesParser new.
	encoding := 'utf8'
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
						containable isNamespace and: [ 
							containable name = entry name ] ]
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

	model := anObject
]

{ #category : #accessing }
CS18NPropertiesImporter >> namespaceStrategy: aNamespaceStrategy [

	"I take a strategy to define toplevel namespaces and link with it."

	namespaceStrategy := aNamespaceStrategy.
	namespaceStrategy importer: self
]
