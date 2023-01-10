Class {
	#name : #MicBlog,
	#superclass : #Object,
	#instVars : [
		'merger',
		'styler',
		'filter',
		'startDirectoryName',
		'endDirectoryName'
	],
	#category : #'Microdown-Blog'
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
			
	self createMergedFile.
	self createFiles.
	

	
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

{ #category : #accessing }
MicBlog >> endDirectoryName [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			

	^endDirectoryName 
]

{ #category : #accessing }
MicBlog >> endDirectoryName: aDirectoryName [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			

	endDirectoryName := aDirectoryName  
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
	merger := MicFilesMerger new.
	styler := MicHTMLStyler new.
]

{ #category : #accessing }
MicBlog >> startDirectoryName [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	^ startDirectoryName 
]

{ #category : #accessing }
MicBlog >> startDirectoryName: aDirectoryName [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	startDirectoryName := aDirectoryName 
]
