"
I'm an horizontal line. I'm expressed by using a new line with `***`

*** the rest of the line is ignored.
"
Class {
	#name : #MicHorizontalLineBlock,
	#superclass : #MicSingleLineBlock,
	#category : #'Microdown-Model'
}

{ #category : #visiting }
MicHorizontalLineBlock >> accept: aVisitor [ 
 	^ aVisitor visitHorizontalLine: self
]
