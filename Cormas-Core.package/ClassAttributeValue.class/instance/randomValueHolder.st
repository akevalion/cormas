aspects
randomValueHolder
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined.  The
	initialization provided below may have been preempted by an
	initialize method."
	
	^randomValueHolder isNil
		ifTrue: [randomValueHolder := String new asValue]
		ifFalse: [randomValueHolder]