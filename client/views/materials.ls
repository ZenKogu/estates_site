class @FEMclass extends FElibClass
	rusName:-> map (\материал + ), <[&nbsp а у &nbsp ом е ы ов ам ы ами ах]> 
	mongo: \materials  
	DB:-> Materials
	cellsArr:~> 
		usr  = Meteor.users.findOne _id:it.userId
		pubQ=(x)~> if it.published then x else ' '
		col  = Collections.findOne _id:it.collection     
		arr  = 
			* td class:pubQ('positive-class'), it.name + pubQ ' (опубликован)'
			* td col?name||\—————
			* td usr?username||\—————

	headersArr:-> <[ Название Коллекция Автор ]>


	changeCol:~> #--------------------------- чисто для проектов		
		if it==\0 => it = undefined 
		[global.criterio,global.options]= if it then [{collection:it},{limit:pagination}] else [{},{limit:pagination}]
		global.count= Math.ceil Materials.find(criterio).count!/pagination||1 # количество страниц
		$ \.doc-count .html \1/ + count
		$ \#slider .slider \option, \max, count
		$ \#slider .slider \option, \value, 1
		$ \#page-handle .html \1
		@changeList!


	EditComponents:-> div {},
		@CheckBoxInput \Опубликован, \published
		@CheckBoxInput 'Комментирование материала пользователями', \comments
		@CheckBoxInput 'Индексирование материала', \index, currentID()==\insert 
		@CheckBoxInput 'Переход со страницы по ссылкам', \follow, currentID()==\insert 
		@TextInput input, 'Название '+@rusName!1, \name
		@ListInput \Коллекция, \collection, @CollectionsList!
		@ListInput 'Родительский материал', \parentMaterial, @ParentsList!
		@TextInput input, 'Описание '+@rusName!1, \description
		@DocKeywords!
		@ShortLinksManager!
		@EditorPanel!
		@Editor!

	ParentsList:->
		parList = {arr:[{class:\show-col, value:'noname', text:'Отсутствует'}]}
		opts={_id:$ne:currentID!}
		M2Ps = []
		col = $('.select-input[name="collection"]').find('option:selected').attr('name')||@Doc(\collection)
		if col then opts={collection:col, _id:$ne:currentID!}
		for M in Materials.find(opts)fetch!
			NC3Q = true
			if M.parentMaterial isnt 'noname'
				parent = Materials.findOne _id:M.parentMaterial
				if parent isnt undefined
					if parent.parentMaterial isnt 'noname'
						M2Ps.push M					
						NC3Q = currentID! isnt parent.parentMaterial						
				
			NC2Q = currentID! isnt M.parentMaterial
			Not3LVLQ = not _.contains M2Ps, M

			if and-list [NC2Q, Not3LVLQ, NC3Q] then parList.arr.push {class:\show-col, value:M._id, text:M.name}
		parList


	SELECT:(obj,cls=\text-select,trig=off)-> 
		for el in obj.arr
			if obj.value==el.value => el.selected=\selected; trig=on 
		if trig==off=> obj.arr[0].selected=\selected; obj.value=obj.arr[0].value
		select {class:"select__list__lib #{cls}", value:obj.value}, unwords [option el, el.text for el in obj.arr]	

	CollectionsList:~>
		obj={arr:[{class:\show-col, value:\0, text:'Все коллекции'}]}
		for col in Collections.find!fetch!
			obj.arr.push {class:\show-col, value:col._id, text:col.name}
		obj


	customHeaderPanel:~> @SELECT @CollectionsList!,\collection-selector
	


	CustomEvents:~> do 
		'paste':~> 
			event.preventDefault!
			text = (event.originalEvent || event).clipboardData.getData('text/plain')
			textArr = compact split '\n', text.replace('\n\n','\n')
			if $(event.target).parents('.TextCellContent').length>0 && textArr.length>1
				if $(event.target).text!length==0
					style = $(event.target).parents('.cell-wrapper').find('select').val!
					$(event.target).parents('.cell-wrapper').replaceWith do
						for text,N in textArr
							TextCell.CellWrap(TextCell.panel(style,text))
				else
					$(event.target).parents('.cell-wrapper').after do
						for text in textArr
							TextCell.CellWrap(TextCell.panel(null,text))
			else		
				text = (event.originalEvent || event).clipboardData.getData('text/plain') || prompt('Что вставить?')
				window.document.execCommand('insertText', false, text)

		'click .btn__header':~> 
			name=$(event.target).attr(\name)
			fsize=40-5*(+name); height=55-5*(+name)
			$(event.target).parents(\.HeaderCellContent).find(".btn__header").addClass(\btn-neutral).removeClass(\btn-default)
			$(event.target).parents(\.HeaderCellContent).find(".btn__header[name=#{name}]").addClass(\btn-default).removeClass(\btn-neutral)
			$(event.target).parents(\.HeaderCellContent).find(\input).attr(\style, "border-left:none; border-right:none; border-top:none; font-size:#{fsize}px; padding-top:10px; padding-left:5px; padding-bottom:0px; height:#{height}px")	

		'click .h-format':~> 
			if $(event.target).hasClass 'h-format' => btn = $(event.target)
			else btn = $(event.target).parents('.h-format')
			btn.parent!children('button').attr 'class', 'btn btn-default h-format'
			btn.attr 'class', 'btn btn-success h-format'
			btn.parents('.form-control-cell-wrapper').find('.form-control-cell[contenteditable="true"]').focus!
			document.execCommand('formatBlock', false,  btn.attr(\name))

		'click .btn-format':~>
			if global.ContentEditableFocus != $(event.target).parents('.form-control-cell-wrapper').find('.form-control[contenteditable="true"]')
				$(event.target).parents('.form-control-cell-wrapper').find('.form-control[contenteditable="true"]').focus!
				# document.getSelection!anchorOffset=9999
				# document.getSelection!focusOffset=9999	
			# text  = if (SEL.anchorOffset - SEL.focusOffset)!=0 => SEL else '&#8204;'
			# com=$(event.target).attr(\name)
			# console.log text
			# console.log text.baseNode.parentElement
			# document.execCommand(\insertHTML, false, "<b>#{text}</b>")
			document.getSelection!execCommand($(event.target).attr(\name),false,null)
			# console.log "#x  #y"

		'click .l-form-s':~>
			global.listFomat.focus!
			document.execCommand $(event.target).attr(\name)
	
		'click .list-toggle-mark':~>
			list=$(event.target).parents(\.list-panel).find('.sortable-handle')
			if list.html! == \•
				for unit, i in list
					$(unit).html(i+1)
			else list.html \•

		# 'click .delete-list-unit':~> ListCell.GetModal($(event.target))
		'click .cell__remove':->  $(event.target).parents(".cell-wrapper").remove! 

		'click .get-table-btn':-> $(event.target).addClass(\hidden); $(event.target).parents(\.cont).find(\table).removeClass(\hidden)

		'click .list-unit-add':~> $(event.target).parents('.list-panel').find('.list-group').append ListCell.ListUnit \•

		'change .collection-selector':~> 
			colId =  $(event.target).find('option:selected').attr 'value'
			@changeCol colId
		'change select':~>
			console.log $(event.target)
			console.log $(event.target).find('option:selected').attr('value')
			V=$(event.target).find('option:selected').attr('value')
			$(event.target).attr('value',V)
		'change .select-input[name="collection"]':~> 
			$('.select-input[name="parentMaterial"]').parent!replaceWith @ListInput 'Родительский материал', \parentMaterial, @ParentsList!

		'keypress .onlyNum':-> /[0-9.]/.test String.fromCharCode event.which #Ввод только цифр
		'mouseover': ~> do
			$('.ed2100r').sortable do
				connectWith: '.ed2100r'
				axis: 'y'
				handle: '.IGA__cell'
				placeholder: 'ui-state-focus'
			$('.portlet').addClass 'ui-widget ui-widget-content ui-corner-all'
			# $('[toggle="tooltip"]').tooltip do
			# 	trigger: 'hover'
			# 	delay: 'show': 500

			list=$(event.target).parents('.list-panel').find('.sortable-handle')
			if list.html! isnt \•
				for unit, i in list
					$(unit).html(i+1)

		'click .get__link':~> 		
			href  = prompt('Введите адрес'); SEL=document.getSelection!
			href .= match //^(http.?|ftp\:\/\/)?(www\.)?([^\s\/$.?#].[^\s]*?$)//
			text  = if (SEL.anchorOffset - SEL.focusOffset)!=0 => SEL else (href?1||'http://')+href[3]
			document.execCommand("insertHTML", false, "<a class='inactive' href='#{(href?1||'http://')+href[3]}'>#{text}</a>")
		

			# window.document.execCommand('createLink',false, prompt('Введите адрес'))

		# Cell.Modal!
			 
		'click .inactive':~> event.preventDefault!
		# 'click .form-control-cell[contenteditable="true"]':~> global.selection = window.getSelection()
		# 'keypress .form-control-cell[contenteditable="true"]':~> global.selection = window.getSelection()

		# 'click .create__link':~>
		# 	TXT = $('.link-text:eq(0)').text()
		# 	console.log TXT
		# 	LINK = a href:$(\.link-href).text!, TXT
			# console.log take(window.getSelection().anchorOffset, $(CE).html())
			# console.log  LINK
			# console.log drop(window.getSelection().focusOffset, $(CE).html())

			# Cell.CloseModal()
			# CE=global.ContentEditableFocus
			# $(CE)[0].focus()bE
			# $(CE)[0].focus()
			# window.getSelection().focusOffset = global.textOffset
			# $(CE).select()
			# console.log doc
		
					# restoreRP(event.target,global.RP)
			# window.document.execCommand('insertHTML', false, global.pasteMarker)

			# take(ST, $(CE).text()
			# setCurrentCursorPosition $(CE)[0], 10
			# window.document.execCommand('insertHTML',false,"<a> ldpfldpfldpfl</a>")

			# ST = global?selection?anchorOffset || false
			
			# if ST>FN => [ST,FN] = [FN,ST]
			# # if ST && FN => $(CE).html( take(ST, $(CE).html()) + LINK + drop(FN, $(CE).html()) )
			# else $(CE).html( $(CE).html() + LINK )
			# global.pasteMarker =  LINK
			# Cell.CloseModal()

		# 	CE=global.ContentEditableFocus
			# $(CE).html( $(CE).html(). + ' ' + a href:'http://'+prompt('адрес ссылки'), prompt('текст ссылки'))


		'change .img__upload':~>
			EV = $(event.target)
			for file in event.target.files when file.type.match \image
				FS.Utility.eachFile event, (file)~>
					img = new (FS.File)(file)
					Images.insert img
					picReader = new FileReader
					picReader.addEventListener \load, (event)~>
						$(EV).parents(\.MultiPicCellContent).find(\ul).append div MultiPicCell.newImage do 
							src:     event.target.result
							trueSrc: "/pics/images-#{img._id}-#{img.name!}"
					picReader.readAsDataURL file

		'change .img__reload':~>
			EV = $(event.target)
			for file in event.target.files when file.type.match \image
				FS.Utility.eachFile event, (file)~>
					img = new (FS.File)(file)
					Images.insert img
					picReader = new FileReader
					picReader.addEventListener \load, (event)~>
						$(EV).parents(\.img__container).replaceWith div MultiPicCell.newImage do
							src:     event.target.result
							trueSrc: "/pics/images-#{img._id}-#{img.name!}"
							com:     $(EV).parents(\.img__container).find(\.img__comment).text!
							alt:     $(EV).parents(\.img__container).find(\.img__text).text!
					picReader.readAsDataURL file

		'change .file__upload':~>
			EV = $(event.target)
			FS.Utility.eachFile event, (file)~> 
				doc = new (FS.File)(file)
				console.log doc.original.name
				console.log doc.original.name.replace(/[\s\S]*?\./g, '').toLowerCase!
				console.log find-index (==doc.original.name.replace(/[\s\S]*?\./g, '').toLowerCase!), <[ doc docx doc pdf zip rar ppt pptx xls xlsx ]>
	
				unless find-index (==doc.original.name.replace(/[\s\S]*?\./g, '').toLowerCase!), <[ x docx doc pdf zip rar ppt pptx xls xlsx ]>
					alert "Разрешено загружать только следующие файлы: zip, pdf, doc, docx, ppt, ppts, xls, xlsx, rar."
				else				
					Documents.insert doc	
					reader = new FileReader
					# $(EV).parents(\.FileCellContent).find(\.file__container).remove!
					reader.onload=~> $(EV).parents(\.FileCellContent).append div FileCell.newFile do 
						ext:	   doc.original.name.replace(/[\s\S]*?\./g, '').toLowerCase!
						fileName:  doc.original.name
						text:      $(EV).parents(\.file__container).find(\.file__text).text!
						source:    "/docs/documents-#{doc._id}-#{doc.name!}"
					####!!!!!   output.insertBefore div, null
					reader.readAsDataURL event.target.files[0]  
		# else FileCell.errorFunction id, 'Разрешено загружать только следующие файлы: zip, pdf, doc, docx, ppt, ppts, xls, xlsx, rar.'


	# errorFunction:(id, text)-> #Заменяем блок с плохой картинкой на сообщение об ошибке
	# 	$('#el'+id).find(\.alert-dismissible).remove!
	# 	$('#image-preview-'+id).remove!
	# 	$('#upload'+id).append div class:'alert alert-danger alert-dismissible' role:\alert,
	# 		button type:\button class:\close data-dismiss:\alert aria-label:\Close,
	# 			span aria-hidden:\true, \&times, xml(\strong)(\Ошибка)


		# 'keypress .form-control-cell[contenteditable="true"]':~>
		# 	global.focusOffset = window.getSelection().focusOffset
		# 	global.anchorOffset = window.getSelection().anchorOffset
		# 'click .form-control-cell[contenteditable="true"]':~>
		# 	global.textOffset = window.getSelection().focusOffset
		# 	global.anchorOffset = window.getSelection().anchorOffset

		'click':~> do
			# console.log $(event.target)
			if $(event.target).parents(\.modal-content).length == 0
				$(\.modal).remove!; $(\body).attr \class, '' ; $(\.in).attr \class, ''
			$ ~> do
				$ \.sortable .sortable do 
					connectWith: \.sortable
					axis: 'y'
					handle: \.sortable-handle
					placeholder: \ui-state-focus
			list=$(event.target).parents('.list-panel').find('.sortable-handle')
			if list.html! isnt \•
				for unit, i in list
					$(unit).html(i+1)					


		'focus .list-unit':~> global.listFomat = $(event.target)	
		'focus .form-control-cell[contenteditable="true"]':~>  
			global.ContentEditableFocus = $(event.target)
			console.log event.target

		# 	console.log event.target
				# global.RP=saveRP(event.target)


	InitEventsEdit:->
		$ \.navbar-cell-creator .find \* .remove!
		$ \.ed2100r .find \* .remove!
		editor.MetaCell=[]
		editor.count=0
		map (.init()), [HeaderCell, TextCell, MultiPicCell, ListCell, TableCell, FileCell, VideoCell, MapCell]	
		editor.LOAD!

	InitEventsInsert:->
		$ \.navbar-cell-creator .find \* .remove!
		$ \.ed2100r .find \* .remove!
		editor.MetaCell=[]
		editor.count=0
		map (.init()), [HeaderCell, TextCell, MultiPicCell, ListCell, TableCell, FileCell, VideoCell, MapCell]	
		editor.LOAD!


@FEM = new FEMclass

FEM.Init!

