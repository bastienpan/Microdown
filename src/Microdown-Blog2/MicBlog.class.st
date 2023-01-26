Class {
	#name : #MicBlog,
	#superclass : #Object,
	#instVars : [
		'navBuilder',
		'summaryBuilder',
		'input',
		'output',
		'styler',
		'parser',
		'htmlVisitor'
	],
	#category : #'Microdown-Blog2'
}

{ #category : #converting }
MicBlog >> asHTMLMic: aMicCollection [
			
	htmlVisitor := MicHTMLVisitor new.
	htmlVisitor visit: aMicCollection.
	^htmlVisitor contents 
	
]

{ #category : #'as yet unclassified' }
MicBlog >> completeConfiguration: aConfiguration [
	
	aConfiguration charSet: (aConfiguration defaultCharset).
	aConfiguration canvas stream configuration: aConfiguration. 
]

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
			
	self createFiles.
	self createSummaryFiles.
	self createNav.
	
	

	
]

{ #category : #enumerating }
MicBlog >> createFile: fileName [ 
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	
	| content html |
	content := fileName asFileReference contents.
	html := self createMicHTMLDocument: content.
	html fileName: ((html configuration title asPath withExtension: 'html') basename ).
	self ensureCreateDirectory: html title. 
	self exportHTMLDocument: html.
	
]

{ #category : #'as yet unclassified' }
MicBlog >> createFiles [
	| files |
	
	files := input allChildrenMatching: '*.md' .
	files do: [ :each | self createFile: each ].
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
MicBlog >> createNav [

	| content html |
	
	content := self asHTMLMic: (navBuilder createNav).
	html := self createMicHTMLDocument: content.
	html fileName: 'Navigation.html'.
	self exportHTMLDocumentInOutputDir: html.
]

{ #category : #'as yet unclassified' }
MicBlog >> createSummaryFile: aFileReference [

	| summary html htmlString|
	summary := summaryBuilder visit: (parser parse:(aFileReference contents)).
	htmlString := self asHTMLMic: summary.
	html := self initializeHTML: (htmlVisitor configuration).
	html writeDocument: htmlString.
	html fileName: (html configuration title , ' Summary.html').
	self exportHTMLDocument: html.
]

{ #category : #'as yet unclassified' }
MicBlog >> createSummaryFiles [

	| files |
	
	files := input allChildrenMatching: '*.md' .
	files do: [ :each | self createSummaryFile: each ].
]

{ #category : #'hierarchy creation' }
MicBlog >> ensureCreateDirectory: directoryName [



	(output path / directoryName) asFileReference ensureCreateDirectory.
	
]

{ #category : #'as yet unclassified' }
MicBlog >> exportHTMLDocument: aMicHTMLDocument [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	
	aMicHTMLDocument destinationPath: (self outputDirectory / aMicHTMLDocument title). 
	aMicHTMLDocument writeToFile 
]

{ #category : #'as yet unclassified' }
MicBlog >> exportHTMLDocumentInOutputDir: aMicHTMLDocument [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	
	aMicHTMLDocument destinationPath: (self outputDirectory). 
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
	summaryBuilder := MicSummaryBuilder new.
	navBuilder := MicNavBuilder new.
	parser := MicrodownParser new.
]

{ #category : #initialization }
MicBlog >> initializeHTML: configuration [
	
	| html |
	"html := MicHTMLDocument newWithStyle: 'AwsmCSS'. "
	html := MicHTMLDocument new.
	html configuration: configuration.
	html configuration document: html.
	self completeConfiguration: (html configuration).
	
	^html
]

{ #category : #initialization }
MicBlog >> initializeHTML: configuration as: fileName [
	
	| html |
	html := MicHTMLDocument new.
	html configuration: configuration.
	html configuration document: html.
	self completeConfiguration: (html configuration).
	html fileName: ((fileName asPath withExtension: 'html') basename ).
	
	^html
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
