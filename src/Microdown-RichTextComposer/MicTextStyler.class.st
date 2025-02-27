"
I am a class that defines the text styles used by `MicRichTextComposer.
I control heading sizes and bullets.


I am defining all these in methods, so to override and do something different, make a subclass of me and set `MicRichTextComposer` to use your new subclass (using `MicRichTextComposer>>textStyler:`). 
"
Class {
	#name : #MicTextStyler,
	#superclass : #Object,
	#instVars : [
		'headerFonts'
	],
	#category : #'Microdown-RichTextComposer-Composer'
}

{ #category : #'presenter styles' }
MicTextStyler >> bodyFont [
	^ nil
]

{ #category : #'composer styles' }
MicTextStyler >> bulletForLevel: level [
	"first level is 1, then 2, then 3..."
	^ ('•-' at: (level-1 % 2)+1) asText
]

{ #category : #private }
MicTextStyler >> computeHeaderFonts [
	
	headerFonts := Array new:  self headerFontSizes size.
	1 to: headerFonts size do: [ :index |
		headerFonts at: index put:
			(TextFontReference
				toFont:
					(LogicalFont 
						familyName: 'Source Sans Pro'
						pointSize: (self headerFontSizes at: index)))
			  ]
]

{ #category : #'composer styles' }
MicTextStyler >> counterFor: counter atLevel: level [
	| kind |
	"first level is 1"
	kind := level % 3.
	kind = 1
		ifTrue: [ ^ counter asString asText , '.' ].
	kind = 2
		ifTrue: [ ^ ($A asInteger + (counter - 1)) asCharacter asText , ')' ].
	kind = 0
		ifTrue: [ ^ ($a asInteger + (counter - 1)) asCharacter asText , ')' ]
]

{ #category : #'composer styles' }
MicTextStyler >> crAfterHeaderLevel: level [
	"I return Text to make space after a header"
	^ String cr asText
]

{ #category : #public }
MicTextStyler >> headerFontSizes [
	^ #(28 24 18 14 12 10)
]

{ #category : #private }
MicTextStyler >> headerLevelFont: level [
	"I return a font annotation to be used with Attributes"
	headerFonts ifNil: [ self computeHeaderFonts  ].
	^ headerFonts at: (level min: 6)
]

{ #category : #'composer styles' }
MicTextStyler >> interBlockSpacing [
	"I return the space to be put between blocks, first cr to end block, second to make empty line"
	^ (String cr, String cr) asText
]

{ #category : #'composer styles' }
MicTextStyler >> monospaceBackgroundColor [
	^ Smalltalk ui theme settings windowColor
]

{ #category : #'canvas styles' }
MicTextStyler >> newLineBody [ 
	"return a newline"
	^ String cr asText
]

{ #category : #'canvas styles' }
MicTextStyler >> newLineIfNotAlready [ 
	"return a newline if there is not already one"
	"Intended to be overridden to add extra newline or tab indentation of the following line"
	^ String cr asText
]

{ #category : #'composer styles' }
MicTextStyler >> postTextTreatment: aText [
	"my primary purpose is to replace newLines with space in some styles"
	"((1 to: aText size) 
		select: [ :i | (aText at: i) = Character cr  ]) 
		do: [ :i | aText at: i put: Character space ]."
	^ aText
	 
]
