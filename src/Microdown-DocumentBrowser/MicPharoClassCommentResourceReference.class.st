"
I am reponsible for accessing class comments.

My syntax is `comment://class/className`

## loadMicrodown
My `loadMicrodown` returns the class comment of the class named className. Notice, `loadMicrodown` will return the synthesized comment (created by the class side method `buildMicroDownUsing:withComment:`)

When categoryName is a package, my two methods `contents` and `contents:` reads and writes the contents of the package comment.
"
Class {
	#name : #MicPharoClassCommentResourceReference,
	#superclass : #MicPharoCommentResourceReference,
	#instVars : [
		'classReference'
	],
	#category : #'Microdown-DocumentBrowser-ResourceModel'
}

{ #category : #private }
MicPharoClassCommentResourceReference >> browserIcon [
	^ self iconNamed: #class
]

{ #category : #accessing }
MicPharoClassCommentResourceReference >> canSave [
	"return true if I implement contents: "
	^true
]

{ #category : #accessing }
MicPharoClassCommentResourceReference >> classReference [

	^ classReference
]

{ #category : #accessing }
MicPharoClassCommentResourceReference >> contents [
	^ classReference comment
]

{ #category : #accessing }
MicPharoClassCommentResourceReference >> contents: newCommentString [
	^ classReference comment: newCommentString
]

{ #category : #loading }
MicPharoClassCommentResourceReference >> loadMicrodown [
	"I override to provide the comment produced by beautifulComments"
	| builder |
	builder := Microdown builder.
	self classReference 
		buildMicroDownUsing: builder 
		withComment: self contents.
	^ Microdown parse: builder contents
]

{ #category : #accessing }
MicPharoClassCommentResourceReference >> uri: aUri [

	"the uri is on the form commet://class/ClassName[/class]"

	| className |
	super uri: aUri.
	className := aUri segments first.
	classReference := self class environment at: className asSymbol.
	(aUri segments size = 2 and: [ aUri segments second = 'class' ]) 
		ifTrue: [ classReference := classReference class ]
]
