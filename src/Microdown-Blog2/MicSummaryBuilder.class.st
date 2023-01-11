Class {
	#name : #MicSummaryBuilder,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'entries',
		'maxEntries'
	],
	#category : #'Microdown-Blog2'
}

{ #category : #initialization }
MicSummaryBuilder >> acceptAndIncrement: aMicElement [

	entries add: aMicElement.
	aMicElement accept: self.
	
]

{ #category : #initialization }
MicSummaryBuilder >> entries [ 

	^entries
]

{ #category : #initialization }
MicSummaryBuilder >> initialize [ 
	super initialize.
	entries := OrderedCollection new.
	maxEntries := 5.
]

{ #category : #visiting }
MicSummaryBuilder >> visitElement: aMicElement [
	
	entries size = maxEntries
		ifFalse: [self entries add: aMicElement.].
	self visitChildrenOf: aMicElement.

]

{ #category : #visiting }
MicSummaryBuilder >> visitHeader: aMicElement [
	
	self visitElement: aMicElement.
	
	
]

{ #category : #visiting }
MicSummaryBuilder >> visitMetaData: aMicElement [
		
		self entries add: aMicElement.
		maxEntries := maxEntries + 1.


]

{ #category : #visiting }
MicSummaryBuilder >> visitParagraph: aMicElement [
	
	self visitElement: aMicElement.
	super visitParagraph: aMicElement 

]

{ #category : #visiting }
MicSummaryBuilder >> visitUnorderedList: aMicElement [
	
	self visitElement: aMicElement.
	super visitUnorderedList: aMicElement 

]
