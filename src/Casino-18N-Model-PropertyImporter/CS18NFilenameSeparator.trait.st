"
I define a separator used to split a file's name.
"
Trait {
	#name : #CS18NFilenameSeparator,
	#instVars : [
		'separator'
	],
	#category : #'Casino-18N-Model-PropertyImporter'
}

{ #category : #accessing }
CS18NFilenameSeparator >> separator: aSeparatorCharacter [

	"I take a character that is used to split a file's name."

	separator := aSeparatorCharacter
]
