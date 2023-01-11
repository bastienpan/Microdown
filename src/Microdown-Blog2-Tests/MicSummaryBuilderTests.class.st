Class {
	#name : #MicSummaryBuilderTests,
	#superclass : #TestCase,
	#instVars : [
		'visitor',
		'parser',
		'factory'
	],
	#classInstVars : [
		'parser',
		'factory'
	],
	#category : #'Microdown-Blog2-Tests'
}

{ #category : #tests }
MicSummaryBuilderTests >> setUp [
	
	super setUp.
	parser := Microdown new.
	factory := MicMicrodownSnippetFactory new.
	visitor := MicSummaryBuilder new.
]

{ #category : #tests }
MicSummaryBuilderTests >> testHeaderEntries [
	
	|  micHeader |
	micHeader := (parser parse: factory headerLevel3Sample) children first.
	self assert: micHeader class equals: MicHeaderBlock.
	self assert: micHeader children first class equals: MicTextBlock.
	visitor visit: micHeader.
	self assert: visitor entries size equals: 1.
	self assert: (visitor entries includes: micHeader).

]
