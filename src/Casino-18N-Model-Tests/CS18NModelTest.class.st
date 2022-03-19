Class {
	#name : #CS18NModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Casino-18N-Model-Tests-Model'
}

{ #category : #running }
CS18NModelTest >> setUp [

	super setUp.
	model := CS18NModel new
]

{ #category : #tests }
CS18NModelTest >> testEnsureEntry [

	| firstEntry secondEntry thirdEntry |
	firstEntry := model ensureEntry: 'foo'.
	secondEntry := model ensureEntry: 'foo'.
	thirdEntry := model ensureEntry: 'bar'.
	self assert: firstEntry class equals: CS18NEntry.
	self assert: firstEntry equals: secondEntry.
	self deny: firstEntry equals: thirdEntry.
	self deny: secondEntry equals: thirdEntry
]

{ #category : #tests }
CS18NModelTest >> testEnsureLanguage [

	| firstLanguage secondLanguage thirdLanguage |
	firstLanguage := model ensureLanguage: 'foo'.
	secondLanguage := model ensureLanguage: 'foo'.
	thirdLanguage := model ensureLanguage: 'bar'.
	self assert: firstLanguage class equals: CS18NLanguage.
	self assert: firstLanguage equals: secondLanguage.
	self deny: firstLanguage equals: thirdLanguage.
	self deny: secondLanguage equals: thirdLanguage
]

{ #category : #tests }
CS18NModelTest >> testEnsureNamespace [

	| firstNamespace secondNamespace thirdNamespace |
	firstNamespace := model ensureNamespace: 'foo'.
	secondNamespace := model ensureNamespace: 'foo'.
	thirdNamespace := model ensureNamespace: 'bar'.
	self assert: firstNamespace class equals: CS18NNamespace.
	self assert: firstNamespace equals: secondNamespace.
	self deny: firstNamespace equals: thirdNamespace.
	self deny: secondNamespace equals: thirdNamespace
]

{ #category : #tests }
CS18NModelTest >> testEntryForPath [

	"The method #entryForPath: uses #entryForPath:from: and #namespaceForPath:from:"

	| anEntry |
	"only key"
	anEntry := model entryForPath: 'foo'.
	self assert: anEntry key name equals: 'foo'.
	self assert: anEntry namespace isRootNamespace.

	"simple path"
	anEntry := model entryForPath: 'foo.bar'.
	self assert: anEntry key name equals: 'bar'.
	self assert: anEntry namespace name equals: 'foo'.
	self assert: anEntry namespace namespace isRootNamespace.

	"repeating names"
	anEntry := model entryForPath: 'foo.foo'.
	self assert: anEntry key name equals: 'foo'.
	self assert: anEntry namespace name equals: 'foo'.
	self assert: anEntry namespace namespace isRootNamespace.

	anEntry := model entryForPath: 'foo.foo.foo'.
	self assert: anEntry key name equals: 'foo'.
	self assert: anEntry namespace name equals: 'foo'.
	self assert: anEntry namespace namespace name equals: 'foo'.
	self assert: anEntry namespace namespace namespace isRootNamespace.

	"retrieve namespace"
	self
		assert: (model entryForPath: 'foo.bar') namespace
		equals: (model entryForPath: 'foo.baz') namespace.

	"empty path"
	self assert: (model entryForPath: '') key name equals: ''.

	"weird paths"
	anEntry := model entryForPath: 'foo.'.
	self assert: anEntry key name equals: ''.
	self assert: anEntry namespace name equals: 'foo'.

	anEntry := model entryForPath: '.foo'.
	self assert: anEntry key name equals: 'foo'.
	self assert: anEntry namespace name equals: ''.

	anEntry := model entryForPath: 'foo..bar'.
	self assert: anEntry key name equals: 'bar'.
	self assert: anEntry namespace name equals: ''.
	self assert: anEntry namespace namespace name equals: 'foo'
]

{ #category : #tests }
CS18NModelTest >> testNamespaceForPath [

	"The method #namespaceForPath: uses #namespaceForPath:from:"

	| aNamespace |
	"only key"
	aNamespace := model namespaceForPath: 'foo'.
	self assert: aNamespace name equals: 'foo'.
	self assert: aNamespace namespace isRootNamespace.

	"simple path"
	aNamespace := model namespaceForPath: 'foo.bar'.
	self assert: aNamespace name equals: 'bar'.
	self assert: aNamespace namespace name equals: 'foo'.
	self assert: aNamespace namespace namespace isRootNamespace.

	"repeating names"
	aNamespace := model namespaceForPath: 'foo.foo'.
	self assert: aNamespace name equals: 'foo'.
	self assert: aNamespace namespace name equals: 'foo'.
	self assert: aNamespace namespace namespace isRootNamespace.

	aNamespace := model namespaceForPath: 'foo.foo.foo'.
	self assert: aNamespace name equals: 'foo'.
	self assert: aNamespace namespace name equals: 'foo'.
	self assert: aNamespace namespace namespace name equals: 'foo'.
	self assert: aNamespace namespace namespace namespace isRootNamespace.

	"retrieve namespace"
	self
		assert: (model namespaceForPath: 'foo.bar') namespace
		equals: (model namespaceForPath: 'foo.baz') namespace.

	"empty path"
	self assert: (model namespaceForPath: '') name equals: ''.

	"weird paths"
	aNamespace := model namespaceForPath: 'foo.'.
	self assert: aNamespace name equals: ''.
	self assert: aNamespace namespace name equals: 'foo'.

	aNamespace := model namespaceForPath: '.foo'.
	self assert: aNamespace name equals: 'foo'.
	self assert: aNamespace namespace name equals: ''.

	aNamespace := model namespaceForPath: 'foo..bar'.
	self assert: aNamespace name equals: 'bar'.
	self assert: aNamespace namespace name equals: ''.
	self assert: aNamespace namespace namespace name equals: 'foo'
]
