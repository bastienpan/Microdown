Class {
	#name : #MicNavBuilder,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'input',
		'output'
	],
	#category : #'Microdown-Blog2'
}

{ #category : #'as yet unclassified' }
MicNavBuilder >> createNav [

	| files content|
	
	files := input allChildrenMatching: '*.md' .
	content := files collect: [ :each | self hyperlink: each ].
	^MicUnorderedListBlock new children: content.
	
]

{ #category : #'as yet unclassified' }
MicNavBuilder >> hyperlink: fileName [

	| html title text|
	
	html := MicHTMLDocument new fromMicrodown: fileName contents.
	html title 
	ifEmpty: [ title := fileName ]  ifNotEmpty: [ title := html title ].
	self halt.
	text := Text fromString:title.
	^MicListItemBlock new children: (OrderedCollection new add: text).
	
	
]

{ #category : #initialization }
MicNavBuilder >> initialize [ 

	super initialize.
	output := (FileLocator image path / 'output') asFileReference.
	input := (FileLocator image path / 'input') asFileReference.
]
