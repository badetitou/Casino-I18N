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

	^ ($# asPParser , newline negate star) trim
]

{ #category : #accessing }
CS18NPropertiesParser >> label [
	^ (#letter asPParser / #digit asPParser / $- asPParser) star flatten trim
]

{ #category : #accessing }
CS18NPropertiesParser >> newline [

	^ Character lf asPParser / (Character cr asPParser , Character lf asPParser optional)
]

{ #category : #accessing }
CS18NPropertiesParser >> pair [

	^ label , $= asPParser token trim , pairValue ==> [ :token | (token at: 1) -> (token at: 3) ]
]

{ #category : #accessing }
CS18NPropertiesParser >> pairValue [

	^ (PP2PredicateObjectNode noneOf: { 
			   $#.
			   Character cr.
			   Character lf }) star flatten
]

{ #category : #accessing }
CS18NPropertiesParser >> pairs [

	^ comment optional starLazy, pair , ((newline / comment) star , pair ==> [ :token | token second ]) star , (newline/comment) star ==> [ :token | 
	  ((OrderedCollection with: token second)
		   addAll: token third;
		   yourself) asArray ]
]

{ #category : #accessing }
CS18NPropertiesParser >> start [
	^ pairs end 
]
