Class {
	#name : #CS18NPropertiesParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'pairs',
		'label',
		'pairValue',
		'pair',
		'newline',
		'comment'
	],
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #accessing }
CS18NPropertiesParser >> comment [

	^ ($# asPParser / $! asPParser / '// ' asPParser , newline negate star) trimBlanks
]

{ #category : #accessing }
CS18NPropertiesParser >> label [

	^ (#word asPParser
	   /
	   (PP2PredicateObjectNode anyOf:
		    (Set newFrom: { $.. $-. $_. $[. $] }))
	   / ($\ asPParser , (PP2PredicateObjectNode noneOf: { 
				     Character cr.
				     Character lf }))) star flatten trim
	  , ($= asPParser / $: asPParser) ==> [ :token | token at: 1 ]
]

{ #category : #accessing }
CS18NPropertiesParser >> newline [

	^ Character lf asPParser
	  / (Character cr asPParser , Character lf asPParser optional)
]

{ #category : #accessing }
CS18NPropertiesParser >> pair [

	^ label , pairValue ==> [ :token | (token at: 1) -> (token at: 2) ]
	  / (#word asPParser , pairValue) flatten ==> [ :token | 
	  (token isKindOf: Association)
		  ifTrue: [ token ]
		  ifFalse: [ token -> '' ] ]
]

{ #category : #accessing }
CS18NPropertiesParser >> pairValue [

	^ ('\\' asPParser
	   / ($\ asPParser , newline trimBlanks ==> [ :ignored | '' ])
	   / newline negate) star ==> [ :token | ('' join: token) trimLeft ]
]

{ #category : #accessing }
CS18NPropertiesParser >> pairs [

	^ (($  asPParser star , newline / comment) star , pair
	   ==> [ :token | token second ]) star
	  , ($  asPParser star , newline / comment) star trimBlanks
	  ==> [ :token | token first ]
]

{ #category : #accessing }
CS18NPropertiesParser >> start [
	^ pairs end 
]
