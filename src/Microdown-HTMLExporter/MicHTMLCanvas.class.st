"
A specialized canvas to emit HTML tags.
"
Class {
	#name : #MicHTMLCanvas,
	#superclass : #MicExportCanvas,
	#category : #'Microdown-HTMLExporter-Core'
}

{ #category : #'writing text' }
MicHTMLCanvas >> initialize [
	"Private - Initialize the receiver's stream"

	super initialize.
	self initializeWith: String empty.
]

{ #category : #initialization }
MicHTMLCanvas >> initializeWith: aString [
	"Private - Set the receiver's stream to store the HTML contents"

	self setStream: (self newMicStreamOn: aString)
]

{ #category : #initialization }
MicHTMLCanvas >> newMicStreamOn: aString [
	"Answer a new wrapper over aString to help not hardcoding line ending everywhere."

	^ MicOutputStream new 
		setStream: (WriteStream on: aString);
		"nextPutAll: aString;"
		yourself
]

{ #category : #accessing }
MicHTMLCanvas >> tag [
	^ self brush: MicHTMLTag new
]
