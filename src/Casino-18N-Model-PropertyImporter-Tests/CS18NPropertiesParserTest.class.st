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

{ #category : #running }
CS18NPropertiesParserTest >> setUp [
	super setUp.
	parser := self parserClass new
]

{ #category : #tests }
CS18NPropertiesParserTest >> testCommentWeirdWithInferiorOf [
	| result |
	result := parser parse: '
<# Hello

'.
	self assert: result isPetit2Success.
	self assert: result size equals: 0
]

{ #category : #tests }
CS18NPropertiesParserTest >> testComplexParsing [

	| result |
	"test string taken from https://en.wikipedia.org/wiki/.properties"
	result := parser parse: '# You are reading the ".properties" entry.
! The exclamation mark can also mark text as comments.
# The key characters =, and : should be written with
# a preceding backslash to ensure that they are properly loaded.
# However, there is no need to precede the value characters =, and : by a backslash.
website = https://en.wikipedia.org/
language = English
# The backslash below tells the application to continue reading
# the value onto the next line.
message = Welcome to \
          Wikipedia!
# But if the number of backslashes at the end of the line is even, the next line is not included in the value. In the following example, the value for "key" is "valueOverOneLine\"
key = valueOverOneLine\\
# This line is not included in the value for "key"
# Add spaces to the key
key\ with\ spaces = This is the value that could be looked up with the key "key with spaces".
# The characters = and : in the key must be escaped as well:
key\:with\=colonAndEqualsSign = This is the value for the key "key:with=colonAndEqualsSign"
# Unicode
tab : \u0009
# If you want your property to include a backslash, it should be escaped by another backslash
path=c:\\wiki\\templates
# However, some editors will handle this automatically'.

	self assert: result isPetit2Success.
	self
		assert: (result at: 1)
		equals: 'website' -> 'https://en.wikipedia.org/'.
	self assert: (result at: 2) equals: 'language' -> 'English'.
	self
		assert: (result at: 3)
		equals: 'message' -> 'Welcome to Wikipedia!'.
	self assert: (result at: 4) equals: 'key' -> 'valueOverOneLine\\'.
	self assert: (result at: 5) equals: 'key\ with\ spaces'
		->
		'This is the value that could be looked up with the key "key with spaces".'.
	self assert: (result at: 6) equals: 'key\:with\=colonAndEqualsSign'
		-> 'This is the value for the key "key:with=colonAndEqualsSign"'.
	self assert: (result at: 7) equals: 'tab' -> '\u0009'.
	self assert: (result at: 8) equals: 'path' -> 'c:\\wiki\\templates'
]

{ #category : #tests }
CS18NPropertiesParserTest >> testEmptyLastLine [

	| result |
	result := parser parse: '
bla=ble
   '.
	self assert: result first equals: 'bla' -> 'ble'
]

{ #category : #tests }
CS18NPropertiesParserTest >> testEmptyLineBetween [

	| result |
	result := parser parse: '
bla=ble

test=hello'.
	self assert: result first equals: 'bla' -> 'ble'.
	self assert: result second equals: 'test' -> 'hello'
]

{ #category : #tests }
CS18NPropertiesParserTest >> testOnlyCommentAndWeirdEnd [

	| result |
	result := parser parse: '<#--------------------------------------------------------------------------------------------------------
#                             UcPpippf - TRANVERSE - MESSAGE - LOCALISATION 1
#--------------------------------------------------------------------------------------------------------

'.
	self assert: result isPetit2Success
]

{ #category : #tests }
CS18NPropertiesParserTest >> testPairValueParseDoubleQuote [

	self assert: (parser pairValue parse: 'auj''d') equals: 'auj''d'.
	self assert: (parser pairValue parse: 'Aujourd''hui') equals: 'Aujourd''hui'
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseDoubleQuote [

	self
		assert:
		(parser parse: 'recherchePeriodeAUJOURD_HUI=Aujourd''hui') first
		equals: 'recherchePeriodeAUJOURD_HUI' -> 'Aujourd''hui'
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseEmpty [
	| result |
	result := parser parse: ''.
	self assert: result isPetit2Success.
	self assert: result size equals: 0
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseEmptyValue [
	| result |
	result := parser parse: '
bla=
ble=bla'.
	self assert: result first equals: 'bla' -> ''.
	self assert: result second equals: 'ble' -> 'bla'
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseLabelWithDot [

	self assert: (parser label parse: 'hello.world=') equals: 'hello.world'.
]

{ #category : #tests }
CS18NPropertiesParserTest >> testParseOnlyComments [
	| result |
	result := parser parse: '
#bla
!bla'.
	self assert: result isPetit2Success.
	self assert: result size equals: 0
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
CS18NPropertiesParserTest >> testSeveralEmptyLastLine [

	| result |
	result := parser parse: '
text=Liste
infobulle=de

	

'.
	self assert: result first equals: 'text' -> 'Liste'.
	self assert: result second equals: 'infobulle' -> 'de'
]

{ #category : #tests }
CS18NPropertiesParserTest >> testSeveralEmptyLastLineWithTabulation [

	| result |
	result := parser parse: '
text=Liste
infobulle=de

	

'.
	self assert: result first equals: 'text' -> 'Liste'.
	self assert: result second equals: 'infobulle' -> 'de'
]

{ #category : #tests }
CS18NPropertiesParserTest >> testSimpleParsing [

	| result |
	result := parser parse: 'bla=ble'.
	self assert: result size = 1
]

{ #category : #tests }
CS18NPropertiesParserTest >> testUnfinishedKeyValue [
	| result |
	result := parser parse: '
bla
ble=bla'.
	self assert: result first equals: 'bla' -> ''.
	self assert: result second equals: 'ble' -> 'bla'
]

{ #category : #tests }
CS18NPropertiesParserTest >> testValueWithoutLabel [

	| result |
	result := parser parse: '=ble'.
	self assert: result size = 1.
	self assert: result first equals: '' -> 'ble'
]

{ #category : #tests }
CS18NPropertiesParserTest >> testWeirdLabelChar [
	"considered as a comment to remove problem with this file"

	| result |
	result := parser parse: '// Hello =  '.
	self assert: result isPetit2Success.
	self assert: result isEmpty
]

{ #category : #tests }
CS18NPropertiesParserTest >> testhiddenSpaceBetweenPairAndComment [

	| result |
	result := parser parse: '
	
aLabel=aVal
 
# Some comment
anotherLabel=anotherValue'.
	self assert: result isPetit2Success
]
