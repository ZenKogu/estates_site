class @CellClass             
	content:-> @panel!||''
	Tools:->   name:\Cell top:\tooltipTop bot:\tooltipBot ico:\fa-paragraph
	init:~>	   $(\body).append a onclick:"#{@Tools!name}.createCell(#{@Tools!name}.panel())" class:"btn btn-primary btn-cell-create", i class:"fa fa-2x fa-fw #{@Tools!ico} icon-cell-create"
	OptionQ:(opt,name,opts=opt[0])~> opts.selected=\selected if opts.name==name; option opts, opt[1]
	SELECT:(obj,cls=\text-select,trig=off)-> 
		for el in obj.arr
			if obj.value==el.value => el.selected=\selected; trig=on 
		if trig==off=> obj.value=obj.arr[0].n
		select {class:"#{cls} select__list__editor", value:obj.value}, unwords [option el, el.text for el in obj.arr]	
	F_BTN:->span {name:it[0], class:"btn btn-neutral btn-format" toggle:\tooltip  style:'color:black; border:solid; margin-bottom:2px; border-width:1px; border-color:rgb(223,215,203)'  title:it[1]}, i class:"fa #{it[2]}"	
	createCell:~> $(\body).append @CellWrap it
	CellWrap:~> div class:'input-group input-group-sm cell-wrapper',
		div class:'input-group-addon btn-group-vertical IGA__cell' style:'padding:3px',
			a class:'btn-default btn' style:'padding:2px; padding-bottom:0px; margin:0px; padding-bottom:5px; height:25px; width:25px' onclick:"$('.ed2100r').append($(this).closest('.cell-wrapper').clone())" toggle:'tooltip' data-placement:'top' title:@Tools!bot+' (скопировать)', i class:"fa fa-fw #{@Tools!ico}"
			a class: 'btn-default btn' style: 'padding:2px; padding-bottom:0px; margin:0px; height:25px; width:25px' toggle:'tooltip' data-placement:'bottom' title:'Удалить ячейку', i class: 'fa fa-remove cell__remove'
		div class:\cont, div {class:"form-control form-control-cell #{@Tools!name}Content form-control-cell-wrapper"}, it
	
# 	# Modal:(FUNC,text)~>	
# 	# 	$ \.modal .remove!	
# 	# 	ST = window.getSelection().anchorOffset
# 	# 	FN = window.getSelection().focusOffset
# 	# 	global.anchorOffset = ST
# 	# 	global.focusOffset = FN	
# 	# 	if ST>FN => [ST,FN] = [FN,ST]
# 	# 	console.log ST+' '+FN
# 	# 	$ \.container .append div class:\modal, div class:\modal-dialog, div class:\modal-content,
# 	# 		div class:\modal-body,
# 	# 			div class:'input-group input-group-section',
# 	# 				div class:'input-group-addon' style:'width:120px', \Текст
# 	# 				div class:'input-div form-control text-input link-text' contenteditable:\true,  window.getSelection().focusNode.data.slice(ST,FN)
# 	# 			div class:'input-group input-group-section',
# 	# 				div class:\input-group-addon style:'width:120px', \Ссылка
# 	# 				div class:'input-div form-control text-input link-href' contenteditable:\true 
# 	# 		div class:\modal-footer,
# 	# 			a class:"btn btn-primary create__link", 'Получить ссылку'
# 	# 			a class:"btn btn-default close-modal" onclick:'Cell.CloseModal()', \Отмена									
# 	# 	$ \.modal .modal \toggle 
# 	# CloseModal:-> $(\.modal).remove!; $(\body).attr \class, '' ; $(\.in).attr \class, ''	
	
# class @TextCellClass extends CellClass
# 	Tools:-> name:\TextCell top:\Абзац bot:\Абзац ico:\fa-paragraph	
# 	panel: (text-style=\txt, text='')-> div {},
# 		unwords @F_BTN`map`[<[bold жирный fa-bold]> <[italic курсив fa-italic]> <[underline подчёркнутый fa-underline]> <[strikeThrough зачёркнутый fa-strikethrough]>]
# 		span class:"btn btn-neutral get__link" style:'color:black; border:solid; margin-bottom:2px; border-width:1px; border-color:rgb(223,215,203)' title:'Сделать выделенное ссылкой' toggle:\tooltip,  i class:"fa fa-format fa-link"     
# 		@SELECT {value:text-style, arr:[ {value:\txt, text:'Основной текст'} {value:\quote text:\Цитата} {value:\com text:\Комментарий} ]}, \text-select
# 		div class:'form-control form-control-cell' style:'border-left:none; border-right:none; border-top:none;  padding-top:10px; padding-left:5px; padding-bottom:0px' contenteditable:true, text			

# class @HeaderCellClass extends CellClass
# 	Tools:-> name:\HeaderCell top:\Заголовок bot:\Заголовок ico:\fa-header
# 	H_BTN:(lvl,N)-> span name:String(N), class:"btn btn-#{if lvl==N=> 'default' else 'neutral'} btn__header" toggle:\tooltip data-placement:\top title:"Заголовок #N уровня", i class:'fa fa-header' name:String(N), sub style:'font-weight:bold' name:String(N), N
# 	panel:(N=\1,T='')-> div unwords(@H_BTN(N, _)`map`<[ 1 2 3 4 ]>)+input class:\form-control style:"font-size:#{40-5*(+N)}px;height:#{55-5*(+N)}px" value:T

# class @ListCellClass extends CellClass
# 	Tools:->name:\ListCell top:\Список bot:\Список ico:\fa-list-ol
# 	GetModal:~>	if confirm('Подвердите удаление элемента списка')=> $(it).parents(\.list-unit-wrap).remove!
# 	ListUnit:(text='', textContent='')-> div class:'input-group list-unit-wrap',
# 		div class:'input-group-addon sortable-handle',  text
# 		div {class:'input-div form-control form-control-cell list-unit', contenteditable:true},textContent
# 		div class:'input-group-addon', a class:'close delete-list-unit', i class:'fa fa-close'
# 	panel:(listType=\ul, li__arr=[])-> div class:'list-panel',
# 		div class:'format-panel', 
# 			unwords @F_BTN`map`[<[bold жирный fa-bold]> <[italic курсив fa-italic]> <[underline подчёркнутый fa-underline]> <[strikeThrough зачёркнутый fa-strikethrough]>]
# 			span class:"btn btn-neutral get__link" title:'Сделать выделенное ссылкой' toggle:\tooltip,  i class:"fa fa-format fa-link"     
# 			span class:"btn btn-neutral l-format list-unit-add"     style:'color:black; border:solid; border-width:1px; border-color:rgb(223,215,203)' toggle:\tooltip  data-placement:\top title:'новый элемент списка', 'Добавить элемент'
# 			span class:"btn btn-neutral l-format list-toggle-mark"  style:'color:black; border:solid; border-width:1px; border-color:rgb(223,215,203)'  toggle:\tooltip  data-placement:\top title:'Маркировка числами (1,2,3) или маркером (•)', 'Изменить тип маркированного списка (число/символ)'
# 		ul class:'sortable list-group',
# 			unwords <| for li__unit, I in li__arr
# 				mark = if listType==\ul => \• else String(I+1)
# 				@ListUnit mark, li__unit

# class @FileCellClass extends CellClass
# 	Tools:-> name:\FileCell top:'Загрузить файл' bot:'Ячейка загрузки файла' ico:\fa-file-text-o
# 	panel:(cell={file__arr:[]})-> div style:'min-height:40px', form class:\editor-file-upload enctype:\multipartform-data,
# 		div style:'padding-right:7px; padding-right:7px; display:inline', 'Допускаются файлы форматов: zip, pdf, doc, docx, ppt, ppts, xls, xlsx, rar.'			
# 		button class:'fileUpload btn btn-neutral' style:'display:inline; height:22px; padding-bottom:10px; padding-top:0px;  color:black; border:solid; margin-bottom:2px; border-width:1px; border-color:rgb(223,215,203)' toggle:\tooltip data-placement:\right title:'Выберите файл на своем компьютере для загрузки на сервер', 'Выбрать файл',
# 			input type:\file class:'upload file__upload' name:'upload[]'
# 		input type:'hidden' name:\type value:'file' class:\file__upload
# 		ul class:\sortable, if cell.file__arr isnt [] => unwords map (@newFile _), cell.file__arr
# 	newFile:(file)-> div class:"input-group file__container" style:"margin-bottom:2px; margin-top:2px",
# 		span class:\input-group-addon style:"padding:0px; margin:0px; position:relative; background-color: rgb(62,63,58)",
# 			a {class:\file__icon style:"padding:5px; margin:5px", href:file?source, download:\download}, file?ext||''
# 		div class:"form-control form-control-cell file__text" contenteditable:\true, file?text||''
# 		div class:"form-control file__filename" style:'border-radius:0px; border-top:none', file?fileName||''	

class @MultiPicCellClass extends CellClass
	Tools:-> name:'MultiPicCell' top:'Загрузить изображения' bot:'Ячейка загрузки изображений' ico:\fa-picture-o	
	panel:(cell={img__arr:[]})-> div style:'min-height:40px', form class:\editor-file-upload,
		div style:'padding-right:7px; padding-right:7px; display:inline', 'Допускаются изображения форматов: jpg, jpeg, jpeg2000, png, bmp, gif.'
		button class:'fileUpload btn btn-neutral' style:'display:inline; height:22px; padding-bottom:10px; padding-top:0px;  color:black; border:solid; margin-bottom:2px; border-width:1px; border-color:rgb(223,215,203)' toggle:\tooltip data-placement:\right title:'Выберите файл на своем компьютере для загрузки на сервер', 'Выбрать изображение',
			input type:\file class:'upload img__upload' name:'upload[]' accept:'image*' value:\images		
		input type:'hidden' name:'type' value:\image class:\img__upload
		ul class:\sortable, if cell.img__arr.length>0 => unwords map (@newImage _), cell.img__arr
	newImage:(cell)-> div class:'input-group img__container' style:'margin-bottom:2px; margin-top:2px',      
		span class:'input-group-addon input-group-addon-image sortable-handle',      
			span type:'button' class:'close label label-default label-on-image' onclick:"$(this).parents('.img__container').remove()" toggle:'tooltip'  data-placement:'bottom' title:'Удалить изображение', i style:'color:white' class:'fa fa-times fa-fw'
			span type:'button' class:'close label label-default label-on-image fileUpload'  toggle:'tooltip'  data-placement:'bottom' title:'Заменить изображение', i style:'color:white' class:'fa fa-refresh fa-fw',
				form class:'editor-file-upload' enctype:'multipartform-data',         
					input type:'file' class:'upload img__reload' name:'upload[]' accept:'image*' value:'images'
					input type:'hidden' class:\img__reload name:'type' value:'image'
			img {class:'images-in-galery close' style:'z-index:1', src:cell?src||'', trueSrc:cell.trueSrc||''}
		div class:'form-control form-control-cell img__text' contenteditable:\true placeholder:'Описание изображения', cell?alt||''
		div class:'form-control form-control-cell img__comment' contenteditable:\true placeholder:'Дополнительная информация', cell?com||''

# class @MapCellClass extends CellClass
# 	Tools:-> name:\MapCell top:\Карта bot:\Карта ico:\fa-map-o
# 	Desc:(B,I=B.parents(\.map-addon).find(\input))-> if +I.val!>1 => I.val +I.val!-1
# 	Asc: (B,I=B.parents(\.map-addon).find(\input))-> if +I.val!<18 => I.val +I.val!+1	 
# 	panel: (scale=16, lat='', lon='', adressVal='') -> div {},
# 		div class:'input-group map-addon',
# 			span class:\input-group-addon style:'padding:0px;padding-left:7px;padding-right:7px; min-width:80px ' toggle:\tooltip  data-placement:\right title:'Масштаб карты (1–18: 1 – конинент, 18 – дом). Изменяется регулятором справа',  'Масштаб'		
# 			input type:\text class:'scale-value form-control form-control-cell-map-adress' style:'height:40px; background-color:white' disabled:\disabled value:scale
# 			span class:\input-group-addon style:\padding:0px,
# 				div class:\btn-group-vertical role:\group style:\align:center,
# 					button type:\button style:'width:20px;height:19px;padding:0px;border-bottom-left-radius:0px;border-top-left-radius:0px' class:'btn btn-default  btn-map-asc' onclick:'MapCell.Asc($(this))', i class:'fa fa-plus'  style:'position:relative;bottom:2px'
# 					button type:\button style:'width:20px;height:19px;padding:0px;border-bottom-left-radius:0px;border-top-left-radius:0px' class:'btn btn-default btn-map-desc' onclick:'MapCell.Desc($(this))', i class:'fa fa-minus' style:'position:relative;bottom:2px'
# 		div class:\input-group,
# 			span class:'input-group-addon lat-value' style:'padding:0px;padding-left:7px;padding-right:7px; min-width:80px'  toggle:\tooltip  data-placement:\right title:'Широта задается числом, дробная часть отделяется точкой', 'Широта:'
# 			input type:\text style:\height:40px class:'form-control  form-control-cell-map-adress form-control-cell-map-adress-lat onlyNum' name:\lat value:lat
# 		div class:\input-group,
# 			span class:'input-group-addon lon-value' style:'padding:0px;padding-left:7px;padding-right:7px;min-width:80px' toggle:\tooltip  data-placement:\right title:'Долгота задается числом, дробная часть отделяется точкой', 'Долгота:'
# 			input type:\text style:'height:40px; ' class:'form-control  form-control-cell-map-adress form-control-cell-map-adress-lon onlyNum' name:\lon  value:lon
# 		div class:\input-group,
# 			span class:\input-group-addon style:'padding:0px;padding-left:7px;padding-right:7px;min-width:80px' toggle:\tooltip  data-placement:\right title:'В этом поле можно указать адрес и примечания', 'Адрес:'
# 			div class:'form-control form-control-cell-map-adress adr' style:\height:42px contenteditable:\true, adressVal
# 			span class:\input-group-addon style:\padding:0px,
# 				div class:'btn btn-default' style:'height:40px;padding-bottom:5px;padding-top:8px; border-bottom-left-radius:0px;border-top-left-radius:0px'  onclick:'MapCell.getMap($(this))' toggle:\tooltip  data-placement:\left title:'Загрузить карту с выбранными координатами', 'Загрузить'
# 	getMap: (button) -> #метод собирает введенные данные и отрисовывает карту после панели
# 		z    = +button.parents('.input-group').find('.scale-value').val()
# 		lat  = button.parents('.input-group').find('.form-control-cell-map-adress-lat').val()
# 		lon  = button.parents('.input-group').find('.form-control-cell-map-adress-lon').val()
# 		if lat and lon #Проверяем введенные данные            
# 			src = 'https://static-maps.yandex.ru/1.x/?ll=' + lon + ',' + lat + '&z=' + z + '&l=map&size=600,250' # Формируем ссылку   
# 			button.parents('.MapCellContent').find('img').remove() # Удаляем предыдущую карту    
# 			button.parents('.MapCellContent').append '<img class = "map-image" src="' + src + '"  lat="' + lat + '"  lon="' + lon + '"  scale="' + z + '" >' #Вставляем новую карту

# class @VideoCellClass extends CellClass
# 	Tools:-> name:\VideoCell top:'Загрузить видео' bot:'Ячейка загрузки видео' ico:\fa-youtube-play
# 	Reg:(name,bool=true)-> div class:\btn-group-vertical style:'align:center; padding:0px; margin:0px;',
# 		a     style:'width:30px; height:16px; margin:0px; margin-bottom:4px; padding:0px; background-color:white; color:black' class:'btn btn-default btn-videotiming'  onclick:'VideoCell.T_CONTR($(this),true,true)', i class:'fa fa-angle-up'
# 		input type:\text class:\onlyNum style:'width:37px; height:26px; text-align:center; padding:0px' value:\00
# 		a     style:'width:30px; height:16px; padding:0px; margin:0px; background-color:white; color:black' class:'btn btn-default btn-videotiming'  onclick:"VideoCell.T_CONTR($(this),#{bool},false)", i class:'fa fa-angle-down'
# 		name
# 	panel:(src='', cls=\hidden)~> div {}, #Управляющие элементы. Задается время начала и ссылка
# 		div class:'input-group',
# 			a class:'input-group-addon btn-neutral btn' style:'color:black; border:solid; margin-bottom:2px; border-width:1px; border-color:rgb(223,215,203)' onclick:'VideoCell.getVideo($(this))', 'Получить видео по ссылке'	
# 			input {type:\text class:'input-div form-control youtube__link', placeholder:"Ссылка на видео YouTube", value:src}
# 		'Демонстрация видео с:   ' + @Reg(\ЧЧ,false)+\: + @Reg(\ММ)+\: + @Reg(\СС)
# 		div class:"embed-responsive embed-responsive-16by9 #cls",
# 			iframe {width:\100%, height:\315, class:\embed-responsive-item, frameborder:\0, src:src}
# 	T_CONTR:(B,NhourQ=true,asc=true,V=B.parent!find('input[type=text]'))->
# 		if +V.val! > 0 && +V.val()<=59 => V.val +V.val! + 2*(+asc)-1
# 		if +V.val! == 0 && !asc => V.val +NhourQ*59
# 		if +V.val! == 0 && asc => V.val 1
# 		if +V.val! < 0 || +V.val! > 59 => V.val 0	
# 	getVideo:(button,content=button.parents(\.VideoCellContent))->
# 		if $(content).find(\.youtube__link).val!length
# 			getVal=(N)->o=+$(content).find("input[type=text]:eq(#N)").val!;if o<0||isNaN(o)=> 0 else o
# 			[hour, min, sec]=getVal`map`[1,2,3]		
# 			codeId = $(content).find(\.youtube__link).val!match(/(?:https?:\/\/)?(?:youtu\.be\/|(?:www\.)?youtube\.com\/watch(?:\.php)?\?.*v=)([a-zA-Z0-9\-_]+)/)[1]
# 			src = "https://www.youtube.com/embed/#{codeId}?start=#{(min+hour*60)*60+sec}"
# 			$(content).find(\.embed-responsive-16by9).remove! #Если уже было видео – удаляем
# 			content.append div class:'embed-responsive embed-responsive-16by9',
# 				iframe width:\100% height:\315 class:\embed-responsive-item frameborder:\0 src:src; 

# class @TableCellClass extends CellClass
# 	Tools:-> name:\TableCell top:\Таблица bot:\Таблица ico:\fa-table
# 	Reg:(text,type,val)-> div class:'col-xs-10' style:'max-width:106px; height:30px; padding:0px',
# 		div class:'input-group tbl-input-group' style:'width:80px',
# 			span class:'input-group-addon ui-sortable-handle' style:'padding:0px;padding-left:7px;padding-right:7px', text		
# 			input class:'form-control' type:'text' style:'height:31px; width:30px; padding-left:5px; padding-right:5px; background-color:white; color:black; border-color:rgb(223, 215, 202)' value:"#val" disabled:'disabled'
# 			span class:'input-group-addon ui-sortable-handle' style:'padding:0px',
# 				div class:'btn-group-vertical' role:'group' style:'align:center',
# 					span class:'btn btn-neutral' type:'button' style:'width:20px; height:15px; padding:0px; border-bottom-left-radius:0px; border-top-left-radius:0px' onclick:"TableCell.DASC($(this), #type, true)",  i class:'fa fa-plus' style:'position:relative; bottom:2px'
# 					span class:'btn btn-neutral' type:'button' style:'width:20px; height:15px; padding:0px; border-bottom-left-radius:0px; border-top-left-radius:0px' onclick:"TableCell.DASC($(this), #type, false)", i class:'fa fa-minus' style:'position:relative; bottom:2px'

# 	panel:(cell={cols:3,style:\style1,cells:['','','','','','','','','']},btn__cls='',tbl__cls='hidden')-> div style:\padding:10px,	
# 		@SELECT {value:cell.style, arr:[ {value:\style1, text:'Основной'} {value:\style2 text:'Дополнительный'} {value:\style3 text:'Специальный'} ]},'table-select'
# 		@Reg(\строк, true, cell.cells.length/cell.cols)
# 		@Reg(\столбцов, false, cell.cols)
# 		span class:"btn btn-neutral btn-format get-table-btn #{btn__cls}"  style:'color:black; border:solid; margin-bottom:2px; border-width:1px; border-color:rgb(223,215,203); height:31px; padding-bottom:0px; padding-top:5px; margin-left:0px', 'Создать таблицу'
# 		table class:"table table-bordered table-edtr #{tbl__cls}" style:'border-top:0px; margin:0px',
# 			thead {},
# 				tr th! + unwords replicate cell.cols, th xml(\i)(class:'fa fa-times' onclick:'TableCell.COL_DEL($(this))' toggle:\tooltip title:'Удалить столбец')
# 				tr th! + unwords [th {placeholder:\Заголовок contenteditable:\true}, cell.cells[m-1] for m from 1 to cell.cols]
# 			tbody {},
# 				unwords <| for i from 1 to (cell.cells.length/cell.cols - 1)
# 					tr @DEL_R! + unwords [td {placeholder:\Ячейка contenteditable:\true}, cell.cells[cell.cols*i+j] for j from 0 to cell.cols-1]


# 	ROW_DEL:->  if confirm 'Удалить строку?' => it.parents(\tr).remove!;@REG_CONTR(M,0,-1)	
# 	COL_DEL:-> if confirm 'Удалить столбец?'  => @TBL(it, "tr>*:nth-child(#{it.parent!index!+1})").remove!; @REG_CONTR(M,1,-1)	
# 	DEL_R:->    th xml(\i)(class:'fa fa-times' toggle:\tooltip title:'Удалить строку' onclick:'TableCell.ROW_DEL($(this))')
# 	ROW:->      tr @DEL_R! + unwords replicate it, td(placeholder:\Ячейка contenteditable:\true)
# 	T:(M,q)->   $(M).parents(\.cont).find q
# 	TBL:(M,q)-> @T M, "table #q"
# 	COLC:->  @TBL(it, 'tr:last *').length - 2
# 	ROWC:->  @TBL(it, \tr).length - 2
# 	REG_CONTR:(M,N=0,D=1)->@T(M, "input:eq(#N)").val +@T(M, "input:eq(#N)").val!+D
# 	LAST_TX:(M,x)-> R=@TBL(M, "tr:eq(#x)>*:last-child").clone!; if x!=0 => R.text('') else R
# 	DASC:(M,R=true,A=true)~> switch
# 		| R&&A   && @ROWC(M)<20 => @TBL(M, \tbody).append @ROW(@COLC(M)); @REG_CONTR(M,0,1)
# 		| !R&&A  && @COLC(M)<10 => [$(r).append @LAST_TX(M,x) for r,x in @TBL(M, \tr)]; @REG_CONTR(M,1,1)
# 		| R&&!A  && @ROWC(M)>2 && confirm 'Удалить строку?'  => @TBL(M, \tr:last).remove!; @REG_CONTR(M,0,-1)	
# 		| !R&&!A && @COLC(M)>2 && confirm 'Удалить столбец'  => @TBL(M, \tr>*:last-child).remove!; @REG_CONTR(M,1,-1)

# @Cell 	      = new CellClass!
# @TextCell     = new TextCellClass!
# @HeaderCell   = new HeaderCellClass!
# @ListCell     = new ListCellClass!
# @FileCell     = new FileCellClass!
@MultiPicCell = new MultiPicCellClass!

# @MapCell      = new MapCellClass!
# @VideoCell    = new VideoCellClass!
# @TableCell    = new TableCellClass!
