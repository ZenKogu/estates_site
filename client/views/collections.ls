class @FECclass extends FElibClass
	rusName:-> map (\коллекци + ), <[я и и ю ей ии и й ям и ями ях]>   
	mongo: \collections
	DB:~> Collections
	canIremove:(id)-> !Materials.find collection:String(id) .count!
	docRemove:(id)-> @DB!remove {_id: String(id)}, {}

	cellsArr:~> 
		pubQ=(x)~> if it.unpublished then x else ' '
		arr  = 
			* td class:pubQ('negative-class'), it.name + pubQ ' (снята с публикации)'
			* td it?description||\—————

	EditComponents:~> div {},
		@CheckBoxInput 'Снята с публикации', \unpublished
		
		@TextInput input, 'Название '+@rusName!1, \name
		@TextInput input, 'Описание '+@rusName!1, \description 
		@ShortLinksManager!

@FEC = new FECclass

FEC.Init!
		
	# global.Template.Collections.events @eventManager!
	# global.Template.Collections.rendered =~> @chooseTemplate!		

	# global.Template.CollectionsEdit.rendered=~> $ \.component-container .append @DocEdit!
	# global.Template.CollectionsEdit.events @eventManager!	
	# global.Template.CollectionsEdit.destroyed =~> removeBlock Meteor.userId!, @mongo


	# global.Template.CollectionsInsert.rendered=~> $ \.component-container .append @DocEdit!
	# global.Template.CollectionsInsert.events @eventManager!	




# Template.Unpublished.events do
#   'change input': (event) ->
#     if event.target.checked then Collections.update { _id: currentID() }, {$set: 'unpublished': true }
#     else Collections.update { _id: currentID() }, {$set: 'unpublished': false }

# Template.Unpublished.rendered = ->
#   unpubQ = Collections.findOne({ _id: currentID() }).unpublished == true
#   if unpubQ then $('input').attr('checked','checked')
#     