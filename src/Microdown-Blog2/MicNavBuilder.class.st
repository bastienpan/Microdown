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

	| html title link path collection|
	
	html := MicHTMLDocument new fromMicrodown: fileName contents.
	html title 
	ifEmpty: [ title := fileName ]  ifNotEmpty: [ title := html title ].
	path := output path / title withExtension: 'html'.
	"link := String streamContents: [ :s |
		s 
			nextPutAll: '[';
			nextPutAll: title;
			nextPutAll: '](';
		 	nextPutAll: path pathString;
			nextPutAll: ')'].
		self halt."
	link := MicLinkBlock new.
	link substring: title;
	url: path pathString;
	reference: (MicHTTPResourceReference new uri: path pathString) .
	collection := OrderedCollection new.
	collection add: link.
	self halt.
	^MicListItemBlock new children: collection.
]

{ #category : #initialization }
MicNavBuilder >> initialize [ 

	super initialize.
	output := (FileLocator image path / 'output') asFileReference.
	input := (FileLocator image path / 'input') asFileReference.
]
