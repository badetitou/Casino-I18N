"
I define a separator used to split names.
"
Trait {
	#name : #CS18NNameSeparator,
	#instVars : [
		'separator'
	],
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #accessing }
CS18NNameSeparator >> separator: aSeparatorCharacter [

	"I take a character that is used to split a file's name."

	separator := aSeparatorCharacter
]
