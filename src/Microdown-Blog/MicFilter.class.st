Class {
	#name : #MicFilter,
	#superclass : #Object,
	#instVars : [
		'directory'
	],
	#category : #'Microdown-Blog'
}

{ #category : #accessing }
MicFilter >> directory: aDirectory [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	directory := aDirectory 
]

{ #category : #'as yet unclassified' }
MicFilter >> lastFiles: n [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	^self sortByDate first: n
]

{ #category : #sorting }
MicFilter >> sortByDate [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	^directory asFileReference children sorted: [ :a :b | a creationTime < b creationTime ]
	
]
