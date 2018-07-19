Class {
	#name : #AbstractActivityModel,
	#superclass : #ElementActivityDiagramModel,
	#instVars : [
		'activityChoices',
		'selectedActivity',
		'targetClass',
		'listActivity',
		'purpose'
	],
	#category : 'Cormas-Core-Tools'
}

{ #category : #default }
AbstractActivityModel class >> defaultName [
	
	^'          ??          '
]

{ #category : #'interface specs' }
AbstractActivityModel class >> setterWindows [
	"Tools.UIPainter new openOnClass: self andSelector: #setterWindows"
	
	<resource: #canvas>
	^#(FullSpec 
		#window: #(WindowSpec 
			#label: 'Activity setter' 
			#min: #(Point 40 20) 
			#max: #(Point 0 0) 
			#bounds: #(Rectangle 720 450 1147 669) 
			#colors: #(LookPreferences 
				#setForegroundColor: nil 
				#setBackgroundColor: #(ColorValue #white) 
				#setSelectionForegroundColor: nil 
				#setSelectionBackgroundColor: nil) 
			#isEventDriven: true) 
		#component: #(SpecCollection 
			#collection: #(#(InputFieldSpec 
				#layout: #(Rectangle 201 29 416 52) 
				#name: #InputFieldActivity 
				#colors: #(LookPreferences 
					#setBackgroundColor: #(ColorValue 8191 7167 6143)) 
				#model: #selectedActivity 
				#menu: #menuInspect) #(SequenceViewSpec 
				#layout: #(Rectangle 8 7 186 215) 
				#name: #List1 
				#model: #listActivity 
				#useModifierKeys: true 
				#selectionType: #highlight) #(ActionButtonSpec 
				#layout: #(Rectangle 283 193 341 216) 
				#name: #ActionButton1 
				#model: #closeRequest 
				#label: 'OK' 
				#defaultable: true) #(LabelSpec 
				#layout: #(Point 201 8) 
				#name: #Label1 
				#colors: #(LookPreferences 
					#setForegroundColor: #(ColorValue 2048 2048 8191)) 
				#label: 'Activity:') #(TextEditorSpec 
				#layout: #(Rectangle 199 76 416 183) 
				#name: #purposeEditor 
				#flags: 5 
				#colors: #(LookPreferences 
					#setBackgroundColor: #(ColorValue 8191 7679 7167)) 
				#model: #purpose 
				#style: #small 
				#tabRequiresControl: true) #(GroupBoxSpec 
				#layout: #(Rectangle 195 57 420 191) 
				#name: #GroupBox1 
				#label: 'Activity purpose:'))))
]

{ #category : #set }
AbstractActivityModel >> activityChanged [
	"set the selectedActivity and the purpose"
	
	self listActivity selection ifNil: [^nil].
	self selectedActivity value: self listActivity selection.
	self changed: #name.
	self purpose
		value:
			(Cormas
				commentOfMethod: self listActivity selection
				class: self targetClass)
]

{ #category : #aspects }
AbstractActivityModel >> activityChoices [
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined.  The
	initialization provided below may have been preempted by an
	initialize method."
	
	^activityChoices isNil
		ifTrue: [activityChoices := List new asValue]
		ifFalse: [activityChoices]
]

{ #category : #aspects }
AbstractActivityModel >> activityChoices: listValue [
	
	activityChoices := listValue
]

{ #category : #'initialize-release' }
AbstractActivityModel >> initialize [
	" Set the listActivity as simple methods of the target class "
	
	| list list2 |
	list := List new.
	list addAll: self targetClass methodsForControlNoArg.
	self listActivity list: list.
	listActivity selectionIndexHolder onChangeSend: #activityChanged to: self.
	list2 := list copy.
	list2 addFirst: self class defaultName.
	self selectedActivity value: list2 first.
	self activityChoices value: list2
]

{ #category : #controlling }
AbstractActivityModel >> inspectCode [
	"Open a Browser on the selected method, or open an activity Diagram if available"
	
	((self targetClass methodsOfProtocol: #'@ control_diagram')
		includes: self selectedActivity value asSymbol)
		ifFalse:
			[Cormas
				editMethod: self selectedActivity value asSymbol
				fromClass: self targetClass]
		ifTrue:
			[self targetClass openActivityDiagram: self selectedActivity value asSymbol]
]

{ #category : #aspects }
AbstractActivityModel >> listActivity [
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined.  The
	initialization provided below may have been preempted by an
	initialize method."
	
	^listActivity isNil
		ifTrue: [listActivity := SelectionInList new]
		ifFalse: [listActivity]
]

{ #category : #menu }
AbstractActivityModel >> menuInspect [
	
	| mb |
	mb := MenuBuilder new.
	mb add: 'show Code' -> #inspectCode.
	^mb menu
]

{ #category : #accessing }
AbstractActivityModel >> name [
	"return class name. Usefull for storing the object"
	
	^self class name asString
]

{ #category : #set }
AbstractActivityModel >> openActivitySetter [
	
	self openInterface: #setterWindows
]

{ #category : #aspects }
AbstractActivityModel >> purpose [
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined.  The
	initialization provided below may have been preempted by an
	initialize method."
	
	^purpose isNil
		ifTrue: [purpose := String new asValue]
		ifFalse: [purpose]
]

{ #category : #aspects }
AbstractActivityModel >> selectedActivity [
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined.  The
	initialization provided below may have been preempted by an
	initialize method."
	
	^selectedActivity isNil
		ifTrue: [selectedActivity := self class defaultName asValue]
		ifFalse: [selectedActivity]
]

{ #category : #controlling }
AbstractActivityModel >> setActivityChoicesFrom: anEntityClass [
	
	self targetClass: anEntityClass.
	self initialize
]

{ #category : #printing }
AbstractActivityModel >> storeOn: aStream [
	
	| deps outgo incom build uiSess actChoices selectAct |
	deps := self myDependents.
	self myDependents: nil.
	outgo := self outgoing.
	outgoing := nil.
	incom := self incoming.
	incoming := nil.
	build := builder.
	builder := nil.
	uiSess := uiSession.
	uiSession := nil.
	actChoices := self activityChoices.
	activityChoices := nil.
	selectAct := selectedActivity.
	selectedActivity := selectedActivity value.
	[super storeOn: aStream]
		ensure:
			[self myDependents: deps.
			outgoing := outgo.
			incoming := incom.
			builder := build.
			uiSession := uiSess.
			activityChoices := actChoices.
			selectedActivity := selectAct]
]

{ #category : #accessing }
AbstractActivityModel >> targetClass [
	
	^targetClass ifNil: [targetClass := AgentLocation]
]

{ #category : #accessing }
AbstractActivityModel >> targetClass: anObject [
	
	targetClass := anObject
]