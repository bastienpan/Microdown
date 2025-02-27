Class {
	#name : #MicMetaDataBlockTest,
	#superclass : #MicBlockTest,
	#category : #'Microdown-Tests-Parser'
}

{ #category : #tests }
MicMetaDataBlockTest >> subjectClass [ 
	^ MicMetaDataBlock 
]

{ #category : #tests }
MicMetaDataBlockTest >> testCorrectJSONMetaDataProducesDictionary [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"
}'.
	root :=  parser parse: source.
	metadata := root children first. 
	self assert: (metadata body at: 'authors') equals: 'S. Ducasse'.
	self assert: (metadata body at: 'title') equals: 'Pharo by Example'.
]

{ #category : #tests }
MicMetaDataBlockTest >> testCorrectMetaDataWithEmptyLinesProduceJSON [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"




}'.

	root :=  parser parse: source.
	metadata := root children first. 
	self assert: (metadata body at: 'authors') equals: 'S. Ducasse'.
	self assert: (metadata body at: 'title') equals: 'Pharo by Example'.
]

{ #category : #tests }
MicMetaDataBlockTest >> testMetaDataEatsOtherBlocks [
	"this is normal since 
{

....

without closing statement (}) is just an unclosed block and since metadata can be a multilines
then it eats.

"
	| source root metadata |
	source := '"author": "S Ducasse"', String cr,
	HeaderMarkup, 'newheader here'.
	root :=  parser parse:  MetaDataOpeningBlockMarkup , String cr, source.
	self assert: root children size equals: 1.
	metadata := root children first. 
	self assert: (metadata isKindOf: MicMetaDataBlock). 
	self assert: (metadata body at: metadata keyForUnparsableContents) equals: source.
	self assert: metadata bogusParsing
	
]

{ #category : #tests }
MicMetaDataBlockTest >> testParse [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" ,
"title" : "Pharo by Example"
}

# header'.
	root := parser parse: source.
	metadata := root children first.
	self assert: root children size equals: 2.
	self assert: (metadata isKindOf: MicMetaDataBlock). 
	
]

{ #category : #tests }
MicMetaDataBlockTest >> testUncorrectJSONMetaDataProducesDictionaryWithContents [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse" 
"title" : "Pharo by Example"
}'.
	root :=  parser parse: source.
	metadata := root children first. 
	self assert: (metadata body at: metadata keyForUnparsableContents) equals: '"authors" : "S. Ducasse" 
"title" : "Pharo by Example"'.
	self assert: metadata bogusParsing
	
]

{ #category : #tests }
MicMetaDataBlockTest >> testUncorrectJSONMetaDataProducesDictionaryWithContents2 [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse",
title" : "Pharo by Example"
}'.
	root :=  parser parse: source.
	metadata := root children first. 
	self assert: (metadata body at: metadata keyForUnparsableContents) equals: '"authors" : "S. Ducasse",
title" : "Pharo by Example"'.
	self assert: metadata bogusParsing
	
]

{ #category : #tests }
MicMetaDataBlockTest >> testUncorrectJSONMetaDataProducesDictionaryWithContents3 [

	| source root metadata |
	source := '{
"authors" : "S. Ducasse",
"title" "Pharo by Example"
}'.
	root :=  parser parse: source.
	metadata := root children first. 
	self assert: (metadata body at: metadata keyForUnparsableContents) equals: '"authors" : "S. Ducasse",
"title" "Pharo by Example"'.
	self assert: metadata bogusParsing
	
]
