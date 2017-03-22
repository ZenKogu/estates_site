class @FElibClass                                                    
	DB:-> None
	rusName:-> map (\документ + ), <[&nbsp а у &nbsp ом е ы ов ам ы ами ах]>

	# docName:     (id)~> @DB!findOne(_id:id).name
	docRemove:   (id)-> @DB!remove _id:id
	customHeaderPanel: -> ''
	InitEventsEdit:->
	InitEventsInsert:->
	Init:~>	
		events = @eventManager!
		for ev of @CustomEvents!
			events[ev] = @CustomEvents![ev]
		section = capitalize @mongo
		global.Template[section]events events
		global.Template[section]rendered =~> 

			global.uival      = 1
			global.pagination = 12 # количество элементов на странице
			global.criterio   = {} #if @mongo==\users || @mongo==\roles then {_id:$ne:'1'} else {}
			global.options    = {limit: global.pagination}		
			
			@chooseTemplate!
			@fullRender!		
		global.Template[section+\Edit].rendered=~> 
			$ \.component-container .append @DocEdit!
			@InitEventsEdit!
		global.Template[section+\Edit].events events
		global.Template[section+\Edit].destroyed=~> 
			$('.components-container').remove!
			removeBlock Meteor.userId(), @mongo
		# global.Template[section+\Edit].destroyed =~> removeBlock Meteor.userId!, @mongo
		global.Template[section+\Insert].rendered=~> 
			$ \.component-container .append @DocEdit!
			@InitEventsInsert!
		global.Template[section+\Insert].events events





	changeList:->  $ \.doc-list-placement .html @docTable!
	reloadSlider:~> 
		global.count = Math.ceil @DB!find(criterio).count!/pagination  # количество страниц
		$ ~> $ \#slider .slider do
			min: 1
			max: global.count||1
			value: global.uival
			create: -> $ \#page-handle .text global.uival
			slide: (event, ui) ~>  
				global.uival = ui.value
				$('#page-handle').text ui.value
				zisScip = global.pagination * (ui.value - 1)
				global.options = {limit: global.pagination, skip: zisScip }
				@changeList!
				$('.doc-count').html(ui.value + '/' + global.count) 

		$('.doc-count').html(global.uival + '/' + global.count)

	chooseTemplate: ~> do     
		global.count = Math.ceil @DB!find(criterio).count!/pagination  # количество страниц
		docBlock = BlockedDocs.findOne {userId: Meteor.userId!, mongoCol: @mongo}
		# if docBlock then global.criterio = {_id:docBlock.docId}
		# if docBlock then @jumbo docBlock
		# else 
		@fullRender!
		@reloadSlider!

# ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗
# ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
# █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
# ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║
# ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║
# ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝
                                                    
	eventManager:-> do 
		# 'onchange .collection-selector':-> alert '123' #@changeCol($(event.target).attr \name)
		# 'click .shortlink-delete':~>
		# 	obj = {}; obj['_id'] = $(event.target).attr('id')
		# 	ShortLinks.remove obj
		# 	$(event.target).parent().parent().remove()

		# 'click .shortlink-edit':~> 
		# 'click .shortlink-delete':~> 


		'click .shortlink-insert-button':~>
			desc    = $('.shortlink-insert').val!
			AllId   = [0]
			for link in ShortLinks.find!fetch! 
				AllId.push +link._id if is-type \Number +link._id				
			maxId   = maximum(AllId)+1
			matQ    = if @mongo==\materials then @Doc(\collection)+'/' else ''				
			link    = "/collections/#{matQ+@Doc(\_id)}-"+@Doc(\translitName)
			newLink = type:@mongo, targetId:@Doc(\_id), targetLink:link, description:desc, convCount:0
			ShortLinks.insert newLink		
			newLink._id = maximum(AllId) + 1
			$(\.shortlink-tbody).append @ShortLinkRow newLink
			$(\.short-link-table).removeClass \hidden 
			$(\.shortlink-insert).val ''
		
		'click .shortlink-edit':~> 
			linkId = $(event.target).attr(\name)
			$(".shortlink-description[name=\"#{linkId}\"]").attr('contenteditable', 'true')
				..focus!

		'click .shortlink-delete':~> 
			linkId = $(event.target).attr(\name)
			ShortLinks.remove _id:linkId
			$(event.target).parent!parent!remove!
			if 	ShortLinks.find({type:@mongo, targetId:currentID!}).count! == 0
				$(\.short-link-table).addClass \hidden


		'keydown .shortlink-description':~> if event.which is 13
			desc = $(event.target).html!
			id = $(event.target).attr \name
			ShortLinks.update({_id:id},{$set:{description:desc}})
			$(event.target).attr 'contenteditable', 'false'



		'click .db-list-edit-button':(e,t)~> @goEdit  $(event.target).attr \name
		'click .db-list-delete-button':(e,t)~> @goRemove  $(event.target).attr \name
		# 'click .delete-doc':~> @DB!remove(_id:$(event.target).attr(\name)); @Init!; @fullRender!
		'click .form-cancel-button':~> Router.go \/admin/ + @mongo
		'click .form-submit-button':~> @SaveManager!
		'click .go-edit':~> @goEdit $(event.target).attr 'name'
		'keypress':~>
			$(event.target).parent!removeClass 'has-error'
		'keydown .keywords-input-form':~> if event.which is 13 => @appendKeyword $(\.keywords-input-form).val!
		'keydown':~> event.which isnt 13
				# if $(event.target).hasClass('new-shorlink') 
				# 	@NewShortLink $(event.target).val!
				
				# else false
			

		
		'click .mongo-access':~>			
			if  $(event.target).hasClass 'btn-success' 
				$(event.target).attr \class, 'btn mongo-access btn-danger'
				$(event.target).html \Нет
			else
				$(event.target).attr \class, 'btn mongo-access btn-success'
				$(event.target).html \Да 

	CustomEvents:-> {}

	jumbo:(docBlock)~> $ \.component-container .html div class:\jumbotron,
		h1 'Продолжить работу'
		p "В одной из вкладок открыт документ «#{@DB!findOne(_id:docBlock.docId).name}». Чтобы продолжить редактирование #{@rusName!1}, нажмите кнопку. 
		Чтобы начать работу над другим документом, завершите редактирование #{@rusName!1} в других вкладках."
		a {name:docBlock.docId, role:\button, class:'btn btn-primary btn-lg go-edit'}, 'Перейти к документу'

	header: ->
		div class: \header-admin,
			h2 class: \header-admin-h, capitalize(@rusName!6)
			@customHeaderPanel!	
			button {style: 'border-radius:5px; float:right' onclick: "Router.go('#{@mongo}.insert')" class: 'btn badge btn-xs btn-success insert-button dataview-insert-button' + @accessClass \insert}, 'Добавить ' + @rusName!3
			div id:\slider,
				div id:\page-handle class:\ui-slider-handle
			div class:\doc-count

	fullRender: ->  
		$ \.component-container .html do
			div class: 'panel panel-default',
				div class:\panel-heading, @header!
				div class:\panel-body,
					div class:'panel-group doc-list-placement', 
					@docTable!
		@reloadSlider!
	

	goEdit: (id)-> Router.go @mongo + '.edit', 'id':id

	goRemove: (id)~>  
		$ \.delete-toggle .remove!
		@getModal id
		$ \.delete-toggle .modal \toggle

	goRLYremove: (id)~> 
		$ \.modal-backdrop .remove!
		$ \.component-container .children!remove!
		@docRemove id
		Rec event:\database, operation:\remove, dbName:@mongo, document:@Doc(\_id)
		@Init!
		@fullRender!
		
	accessClass: (op)-> MongoAccessGranted(Meteor.userId!, @mongo, op)?'':\hidden

	access: (op, x)-> if MongoAccessGranted(Meteor.userId!, @mongo, op) then x else ' '
 
	docTable:-> 
		if @docTbody!
			table class:'table table-bordered',
				thead tr {}, 
					th style:\width:45px, \Id 
					unlines map th, @headersArr!
					th style:\width:185px,\Управление  
				tbody @docTbody!
		else div class:'alert alert-info' role:\alert, "#{@rusName!7} не найдено."

	Data:->@DB!find(global.criterio,global.options).fetch!
	
	docTbody:~>
		tbody = ''
		for doc in @Data!
			# if (@mongo==\users || @mongo==\roles)&&(doc._id==\1) then continue
			tbody+= tr {},
				td doc._id
				unlines @cellsArr doc
				td {}, #@access \update, 
					div {class:'btn btn-default edit-button db-list-edit-button' name:doc._id}, \изменить 
					div {class:'btn btn-default delete-button db-list-delete-button' name:doc._id}, \удалить 
		tbody

	cellsArr:-> arr=
		td it?name||\————— 
		td it?description||\—————

	headersArr:-> <[ Название Описание ]>


	canIremove:-> true

	getModal:(id)~>
		if @canIremove id 
			if confirm "Подвердите удаление #{@rusName!1}" => @DB!remove(_id:id); @Init!; @fullRender!
		else alert "Нельзя удалить #{@rusName!3}. На данный объект ссылаются другие документы"

			# $ \.component-container .append do
			# 	div class:'modal  delete-toggle' tabindex:\-1 role:\dialog,
			# 		div class:\modal-dialog role:\document,
			# 			div class:\modal-content,
			# 				div class:\modal-header,
			# 					button type:\button class:'close close-modal' data-dismiss:\modal aria-label:\Close,
			# 						span aria-hidden: \true, \&times
			# 					h4 class:\modal-title, \Удаление + @rusName!1
			# 				div class:\modal-body, body
			# 				div class:\modal-footer,
			# 					delButton
			# 					button type:\button class:'btn btn-default close-modal' data-dismiss:\modal, \Отмена



                                                                                                
# ███████╗██████╗ ██╗████████╗   ██╗███╗   ██╗███████╗███████╗██████╗ ████████╗
# ██╔════╝██╔══██╗██║╚══██╔══╝   ██║████╗  ██║██╔════╝██╔════╝██╔══██╗╚══██╔══╝
# █████╗  ██║  ██║██║   ██║      ██║██╔██╗ ██║███████╗█████╗  ██████╔╝   ██║   
# ██╔══╝  ██║  ██║██║   ██║      ██║██║╚██╗██║╚════██║██╔══╝  ██╔══██╗   ██║   
# ███████╗██████╔╝██║   ██║      ██║██║ ╚████║███████║███████╗██║  ██║   ██║   
# ╚══════╝╚═════╝ ╚═╝   ╚═╝      ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝  
                                                                       
	DocEdit:-> div class: 'container admin-section-container',
		div class: 'panel panel-default',
			@PanelHeader 'Редактирование '+@rusName!1
			div class: \panel-body,
				@EditComponents!
 
	Doc:~> @DB!findOne(_id:currentID!)?[it]|| ''

# ███████╗ █████╗ ██╗   ██╗███████╗
# ██╔════╝██╔══██╗██║   ██║██╔════╝
# ███████╗███████║██║   ██║█████╗  
# ╚════██║██╔══██║╚██╗ ██╔╝██╔══╝  
# ███████║██║  ██║ ╚████╔╝ ███████╗
# ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝
 
	

	SaveManager:(data={})~> 
		for field in $ \.text-input 
			data[$(field).attr \name] = $(field).val! || $(field).text!
			if data[$(field).attr \name]=='' 
				$(field).parent!addClass 'has-error'
		# if $(\.list-group-item).length

		for field in $ \.checkbox-input
			data[$(field).attr \name] = $(field)[0].checked
		for field in $ \.select-input 
			data[$(field).attr \name] = $(field).attr('value')
		if $(\.label-keyword).length then data[\keywords] = map (.innerText.replace('\n','')), $('.label-keyword')
		if $(\.mongo-access.btn-success).length then data[\MongoAccessList] = map (.name), $(\.mongo-access.btn-success)

		if $(\.ed2100r).length 
			data[\obj__article]=editor.SAVE!obj__article
			data[\str__article]=editor.SAVE!str__article

			# data['articleContent'] =  editor.ToHTML! ||''
			# data['article'] = editor.getArticle data['articleContent']

		if data['name'] => data['translitName'] = TranslitRusEng data['name']
		

		if not $(\.has-error).length
			if currentID! is \insert
				@DB!insert data, (e)~> if not e then Router.go \/admin/ + @mongo else console.log e
				Rec event:\database, operation:\insert, dbName:@mongo, document:@Doc(\_id)
			else 
				@DB!update {_id:currentID!}, {$set:data}, (e)~> if not e then Router.go \/admin/ + @mongo else console.log e	
				Rec event:\database, operation:\update, dbName:@mongo, document:@Doc(\_id)
			

	EditComponents:-> div {},
		@CheckBoxInput \Опубликован, \is-published, \false
		@CheckBoxInput 'Комментирование материала пользователями', \comments, \false
		@CheckBoxInput 'Индексирование материала', \index, \index
		@CheckBoxInput 'Переход со страницы по ссылкам', \follow, \follow
		@ShortLinksManager!
		@TextInput input, 'Название '+@rusName!1, \name
		@ListInput \Коллекция, \class, <[ 1 2 3 4 5 6 7 8 ]>
		@TextInput div, 'Описание '+@rusName!1, \description
		@DocKeywords!


	PanelHeader:(text)->
		div class: 'panel-heading',
			div class: \header-admin,
				h2 class: \header-admin-h, text
				div class: 'btn badge btn-xs form-submit-button', 'Сохранить и выйти'
				div class: 'btn badge btn-xs form-cancel-button', 'Выйти без сохранения'

	CheckBoxInput:(text, fName, check=false)->
		inputOpts = class:'checkbox-input', name:fName, type:\checkbox
		if @Doc(fName)||check then inputOpts[\checked] = \checked
		div class:' checkbox' style:'padding-left:20px', 
			input inputOpts
			text

	TextInput:(func, text, fName, textContent='', req=true)->
		type = switch fName
			| \email    =>  \email
			| \password =>  \password 
			| _         =>  \text
		div class:'input-group input-group-section',
			div class:'input-group-addon', @RedStar(req) + text
			func {class: 'input-div form-control text-input', name:fName, contenteditable:func==div, type:type, value:textContent||@Doc(fName)}, if func==div then textContent||@Doc(fName) ##{{material description}}

	RedStar:(req=true)-> if req => span {style:'color:red; padding:0px; margin:0px; padding-right:5px;'}, '✽ ' else ''
	# SpecTextInput:(text,fName,val)->
	# 	div class:'input-group input-group-section',
	# 		div class:'input-group-addon', text
	# 		input {class: 'input-div form-control spec-input', name:fName, type:\text, value:val}##{{material description}}

	# Join:(arr)-> arr*' '


	ListInput:(text, fName, obj, req=true)~> div class: 'input-group input-group-section',
		div class:'input-group-addon', @RedStar(req)+text	
		@SEL obj, \select-input, fName


	SEL:(obj,cls=\text-select, fName, trig=off)-> 
		for el in obj.arr
			if @Doc(fName)==el.value => el.selected=\selected; trig=on; VAL=el.value 
		if trig==off=> obj.arr[0].selected=\selected; VAL=obj.arr[0].value
		select {class:"#{cls} select__list__menu",name:fName,value:VAL}, unwords [option el, el.text for el in obj.arr]	


	OptionQ:(opt, fName)~> 
		opts = opt[0]
		if opts.name == @Doc(fName) then opts.selected=\selected
		option opts, opt[1]

	EditorPanel: -> 
		div class: 'navbar navbar-fixed-top' style: 'margin-top:60px; width:55px; margin-left:5px',
			ul class:'nav navbar-nav navbar-cell-creator btn-group-vertical'

	Editor:-> div class:\ed2100r


	DocKeywords:-> 
		div class:'input-group input-group-section',
			div class:\input-group-addon, 'Ключевые слова'
			div class:'input-div form-control keywords-panel',
				unwords(@keywordSpan`map`@Doc(\keywords))
			input class:'input-div form-control keywords-input-form'


	keywordSpan:-> (.replace('\n','')) <|i(class:'fa label-default label-keyword' onclick: '$(this).remove()' style:'white-space:pre-line', it)

	appendKeyword:-> 
		if it.length > 2
			doubleQ = false
			for i in $('.keywords-panel').find('i')
				if $(i).html! == it
					doubleQ = true
					$(i).animate({backgroundColor:'#00aa00'},500)
					$(i).animate({backgroundColor:'#rgb(62,63,58)'},500)

			if not doubleQ 
				$ \.keywords-panel .append @keywordSpan(it)
				$('.keywords-input-form').val ''


	ShortLinks:-> ShortLinks.find({type:@mongo, targetId:currentID!}).fetch!

	ShortLinkRow:-> 
		tr {},
			td {class:\shortlink-description, name:it._id}, it?description||\—————
			td String it.convCount
			td it?_id||\————— 
			td {},
				div {class:'btn btn-default edit-button shortlink-edit', name:it._id}, \изменить 
				div {class:'btn btn-default delete-button shortlink-delete', name:it._id}, \удалить 

	# NewShortLink:(desc)-> 
	# 	ShortLinks.insert({type:initial(@mongo), targetId:currentID!, description:desc}) 


	ShortLinksManager: -> 
		if ShortLinks.find({type:@mongo, targetId:currentID!}).count! == 0 then cls = 'hidden' else cls = ''

		div {},
			div class: 'input-group input-group-section',
				a {class:'btn input-group-addon shortlink-insert-button', style:'color:black; border:solid; border-width:1px; border-right-width:0px; border-color:rgb(223,215,203)' }, 'Добавить короткую ссылку'
				input class:'input-div form-control shortlink-insert' placeholder: 'Введите описание и нажмите кнопку слева'
			div class: "input-group input-group-section",
				table class: "table table-bordered short-link-table #{cls}", 
					thead {},
						tr {},
							td class: \input-group-addon style:'width:100%', \Описание
							td class: \input-group-addon style:'width:100px',  \Переходов
							td class: \input-group-addon style:'width:50px', \id
							td class: \input-group-addon style:'width:185px',  \Управление
					tbody class:\shortlink-tbody,
						unlines map @ShortLinkRow, @ShortLinks! 


@FElib = new FElibClass