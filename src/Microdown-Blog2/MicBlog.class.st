Class {
	#name : #MicBlog,
	#superclass : #Object,
	#instVars : [
		'navBuilder',
		'summaryBuilder',
		'input',
		'output',
		'styler'
	],
	#category : #'Microdown-Blog2'
}

{ #category : #'as yet unclassified' }
MicBlog >> createAndExportHTMLDocument: content [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	self exportHTMLDocument: (self createMicHTMLDocument: content).
]

{ #category : #'as yet unclassified' }
MicBlog >> createAndExportHTMLDocument: content as: fileName [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	self exportHTMLDocument: (self createMicHTMLDocument: content as: fileName).
]

{ #category : #'as yet unclassified' }
MicBlog >> createBlog [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	self createHierarchy.
	self createSummaryFiles.
	

	
]

{ #category : #enumerating }
MicBlog >> createFile: fileName [ 
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	
	| content |
	content := fileName asFileReference contents.
	self createAndExportHTMLDocument: content as: fileName path base ,'.html'.
]

{ #category : #'as yet unclassified' }
MicBlog >> createFiles [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	| micFiles |
	micFiles := (startDirectoryName asFileReference allChildrenMatching: '*.md')  
	do: [ :file | self createFile: file ]
]

{ #category : #'hierarchy creation' }
MicBlog >> createHierarchy [

]

{ #category : #'as yet unclassified' }
MicBlog >> createMergedFile [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	| content |
	content := merger merge: startDirectoryName.
	self createAndExportHTMLDocument: content.
	

]

{ #category : #'as yet unclassified' }
MicBlog >> createMergedFiles: n [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	| content |
	content := merger merge: (filter lastFiles: n). 
	self createAndExportHTMLDocument: content as: 'nLast'.
	
]

{ #category : #accessing }
MicBlog >> createMicHTMLDocument: content [  
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	^MicHTMLDocument new fromMicrodown: content.

]

{ #category : #accessing }
MicBlog >> createMicHTMLDocument: content as: fileName [ 
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	^MicHTMLDocument new fromMicrodown: content;
	fileName: fileName 
	

]

{ #category : #'as yet unclassified' }
MicBlog >> createSummaryFile [
]

{ #category : #'as yet unclassified' }
MicBlog >> createSummaryFile: aFileReference [

	| summary html|
	summary := summaryBuilder visit: (aFileReference content).
	html := MicHTMLDocument newWithStyle: 'awsm'.
	html fromMicrodown: summary
]

{ #category : #'as yet unclassified' }
MicBlog >> createSummaryFiles [

	output children do: [ :each | summaryBuilder visit: (each content)].
]

{ #category : #'as yet unclassified' }
MicBlog >> exportHTMLDocument: aMicHTMLDocument [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	
	aMicHTMLDocument destinationPath: (self endDirectoryName). 
	aMicHTMLDocument writeToFile 
]

{ #category : #initialization }
MicBlog >> initialize [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	super initialize.
	output := (FileLocator image path / 'output') asFileReference.
	input := (FileLocator image path / 'input') asFileReference.
	styler := MicHTMLStyler new.
]

{ #category : #accessing }
MicBlog >> inputDirectory [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			

	^input
]

{ #category : #accessing }
MicBlog >> inputDirectory: aDirectory [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			

	input := aDirectory 
]

{ #category : #accessing }
MicBlog >> outputDirectory [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			

	^output
]

{ #category : #accessing }
MicBlog >> outputDirectory: aDirectory [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			

	output := aDirectory 
]
