Class {
	#name : #CS18NModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Casino-18N-Model-Tests'
}

{ #category : #running }
CS18NModelTest >> setUp [

	model := CS18NModel new.
]

{ #category : #tests }
CS18NModelTest >> testEnsureEntry [

	| firstEntry secondEntry thirdEntry |
	firstEntry := model ensureEntry: 'foo'.
	secondEntry := model ensureEntry: 'foo'.
	thirdEntry := model ensureEntry: 'bar'.
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
	self assert: firstNamespace equals: secondNamespace.
	self deny: firstNamespace equals: thirdNamespace.
	self deny: secondNamespace equals: thirdNamespace.
]

{ #category : #tests }
CS18NModelTest >> testEntryForPath [

	"The method #entryForPath: uses #entryForPath:from: and #namespaceForPath:from:"

	| anEntry |
	"only key"
	anEntry := model entryForPath: 'foo'.
	self assert: anEntry key name equals: 'foo'.
	self assert: anEntry namespace isNil.

	"simple path"
	anEntry := model entryForPath: 'foo.bar'.
	self assert: anEntry key name equals: 'bar'.
	self assert: anEntry namespace name equals: 'foo'.
	self assert: anEntry namespace namespace isNil.

	"repeating names"
	anEntry := model entryForPath: 'foo.foo'.
	self
		assert: anEntry key name equals: 'foo'. self
		assert: anEntry namespace name equals: 'foo'. self
		assert: anEntry namespace namespace isNil.

	anEntry := model entryForPath: 'foo.foo.foo'.
	self assert: anEntry key name equals: 'foo'.
	self assert: anEntry namespace name equals: 'foo'.
	self assert: anEntry namespace namespace name equals: 'foo'.
	self assert: anEntry namespace namespace namespace isNil.

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
