actions
selectedRowShouldLoadLabelPressed
	"This method was generated by UIDefiner.  Any edits made here
	may be lost whenever methods are automatically defined."
	
	| ascSortBlock dscSortBlock sortBlock |
	ascSortBlock := [:x :y | x shouldLoad	"displayString <= y shouldLoad displayString"].
	dscSortBlock := [:x :y | x shouldLoad not	"displayString >= y shouldLoad displayString"].
	sortBlock := self addOns_List sortAspect == #selectedRowShouldLoad
		ifTrue:
			[self addOns_List sortDirection == #asc
				ifTrue:
					[self addOns_List sortDirection: #dsc.
					ascSortBlock]
				ifFalse:
					[self addOns_List sortDirection: #asc.
					dscSortBlock]]
		ifFalse:
			[self addOns_List sortAspect: #selectedRowShouldLoad.
			self addOns_List sortDirection: #dsc.
			ascSortBlock].
	self addOns_List
		refreshList:
			(SortedCollection
				withAll: self addOns_List list
				sortBlock: sortBlock) asList