Class {
	#name : #MicFilesMerger,
	#superclass : #Object,
	#category : #'Microdown-Blog'
}

{ #category : #initialization }
MicFilesMerger >> initialize [ 
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	super initialize.
	
]

{ #category : #actions }
MicFilesMerger >> merge: fileDirectory [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	| micFiles |
	micFiles := (fileDirectory asFileReference allChildrenMatching: '*.md')  
collect: [ :each | each contents] .

^String streamContents: [ :tempStream | micFiles do: [:file | tempStream nextPutAll: file ; cr] ].
]
