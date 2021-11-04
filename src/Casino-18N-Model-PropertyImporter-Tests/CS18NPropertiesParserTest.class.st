"
A CS18NPropertiesParserTest is a test class for testing the behavior of CS18NPropertiesParser
"
Class {
	#name : #CS18NPropertiesParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Casino-18N-Model-PropertyImporter-Tests'
}

{ #category : #tests }
CS18NPropertiesParserTest >> parserClass [
	^ CS18NPropertiesParser
]

{ #category : #tests }
CS18NPropertiesParserTest >> setUp [
	super setUp.
	parser := self parserClass new
]

{ #category : #tests }
CS18NPropertiesParserTest >> testPairValueParseDoubleQuote [

	self assert: (parser pairValue parse: 'auj''d') equals: 'auj''d'.
	self assert: (parser pairValue parse: 'Aujourd''hui') equals: 'Aujourd''hui'
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseDoubleQuote [

	self assert: (parser parse: 'recherchePeriodeAUJOURD_HUI=Aujourd''hui') equals: { 'recherchePeriodeAUJOURD_HUI' -> 'Aujourd''hui' }.
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseLabelWithDot [

	self assert: (parser label parse: 'hello.world') equals: 'hello.world'.
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseTwoElement [
	| result |
	result :=  parser parse: 'bla=ble
ble=bla'.
	self assert: result size = 2
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseTwoElementsWithCommentAtTheEnd [
	| result |
	result :=  parser parse: '

bla=ble

ble=bla
#hello	'.
	self assert: result size = 2
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseTwoElementsWithCommentBefore [
	| result |
	result :=  parser parse: '
#hello	
bla=ble
ble=bla'.
	self assert: result size = 2
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseTwoElementsWithCommentBetween [
	| result |
	result :=  parser parse: '

bla=ble
#hello	
ble=bla'.
	self assert: result size = 2
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseTwoElementsWithCommentWithDigit [

	self assert: (parser comment parse: '# el23lo') equals: { $#. {$ . $e. $l. $2. $3. $l. $o} asOrderedCollection  }
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseTwoElementsWithSeveralCommentStart [
	| result |
	result :=  parser parse: '

bla=ble
###hello	
ble=bla'.
	self assert: result size = 2
]

{ #category : #tests }
CS18NPropertiesParserTest >> testSimpleParsing [

	| result |
	result := parser parse: 'bla=ble'.
	self assert: result size = 1
]
