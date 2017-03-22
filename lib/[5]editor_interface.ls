# class @editorClass
# 	text__format:->it.replace /<\/?div.*?>|<br>|<\/?span.*?>|\&nbsp;|[\s]+|<\/?span.*?>|\n/g ' '
 
# 	LOAD:-> for cell in Materials.findOne(_id:currentID!).obj__article
# 		switch cell.type
# 		| \text    => TextCell.createCell   TextCell.panel(cell.style, cell.text)
# 		| \header  => HeaderCell.createCell HeaderCell.panel(cell.tag, cell.text)
# 		| \list    => ListCell.createCell   ListCell.panel( cell.listType, cell.liArr )
# 		| \video   => VideoCell.createCell  VideoCell.panel( cell.src, '' )
# 		| \file    => FileCell.createCell   FileCell.panel cell
# 		| \table   => TableCell.createCell TableCell.panel(cell, 'hidden','')
# 		| \gallery => MultiPicCell.createCell MultiPicCell.panel cell
# 		| \map      => MapCell.createCell  MapCell.panel(cell.scale, cell.lat, cell.lon, cell.adress) + img {class:\map-image src:"https://static-maps.yandex.ru/1.x/?ll=#{cell.lon},#{cell.lat}&z=#{cell.scale}&l=map&size=600,250", lat:cell.lat,lon:cell.lon, scale:cell.scale}
 

# 	SAVE:(arr=[],article='',fileSeq=false)-> 
# 		for W in $(\.form-control-cell-wrapper)
# 			switch 
# 			case $ W .hasClass \HeaderCellContent
# 				text =  $(W).find(\input).val!
# 				tag  =  $(W).find(\.btn-default).attr(\name)
# 				arr.push {type:\header, text, tag}
# 				article+= xml("h#tag") text
				
# 			case $ W .hasClass \TextCellContent 
# 				text  = @text__format $(W).find('[contenteditable="true"]').html!
# 				style = $(W).find('option:selected').attr(\value)
# 				arr.push {type:\text, text, style}
# 				article+= p text

# 			case $ W .hasClass \ListCellContent
# 				listType = if $(W).find(\.sortable-handle).html! is \• => [\ul,ul] else [\ol,ol]		
# 				liArr = []
# 				map ($ _)>>(.html!)>>(@text__format _)>>(liArr.push _), $(W).find(\.list-unit)				
# 				arr.push {type:\list, listType:listType.0, liArr}
# 				article+= listType.1 unwords(map li, liArr)

# 			case $ W .hasClass \TableCellContent
# 				cells=txAr=[]; str=row=''; M=$(W).clone!
# 				M.find('tr:eq(0), th:first-child').remove!
# 				cols= $(M).find(\th).length
# 				style = $(W).find('option:selected').attr(\value)
# 				for $t in $(M).find 'td, th'
# 					tag = if $($t)[0]tagName==\TD then td else th
# 					txAr.push $($t).text!
# 					str+= tag $($t).text!
# 					if txAr.length%cols==0 
# 						if tag==th => row+=thead(tr(str))+\<tbody>; str=''
# 						else row+=tr(str); str=''
# 				arr.push {type:\table, cells; cols; style}
# 				article+= table(row+\</tbody>)

# 			case $ W .hasClass \VideoCellContent
# 				src = $(W).find(\iframe).attr \src 
# 				arr.push {type:\video, src}
# 				article+= div class:\video, iframe width:\435 height:\286 src:src; frameborder:\0 allowfullscreen:\allowfullscreen



# 			case $ W .hasClass \MultiPicCellContent
# 				imgAr=$(W).find(\.img__container); buffAr=[]
# 				opts=(IMG)->{trueSrc:$(IMG).find(\img).attr(\truesrc), src:$(IMG).find(\img).attr(\truesrc), alt:$(IMG).find(\.img__text).text!, com:$(IMG).find(\.img__comment).text!}
# 				for I in imgAr
# 					buffAr.push {src:opts(I).src, alt:opts(I).alt, com:opts(I).com, trueSrc:opts(I).trueSrc}
			
# 				if imgAr.length==1 => article+= a class:\img__preview href:\#win4, 
# 					figure class:\left, 
# 						img(alt:opts(I).alt, src:opts(I).trueSrc, style:'height:151px')
# 						figcaption(a opts(I).alt)
# 				else article+= section div class:\gallery, div class:\gallery__wrapper,
# 					button class:\gallery__prev",\&nbsp
# 					unwords <| for I,n in imgAr when n%2==0
# 						if imgAr[n+1]!=undefined
# 							console.log n
# 							div class:"gallery__slide #{if n==0 => \active else 'hidden' }", 'data-slide':n/2, 
# 								div class:\table__cell, 
# 									a class:\img__preview href:\#win4, 
# 										figure {},
# 											img {alt:opts(imgAr[n]).alt, src:opts(imgAr[n]).trueSrc, style:'height:151px'}
# 											figcaption(a opts(imgAr[n]).alt)+"<!--- #{opts(imgAr[n]).com}---->"
# 								div class:\table__cell, 
# 									a class:\img__preview href:\#win4, 
# 										figure {},
# 											img {alt:opts(imgAr[n+1]).alt, src:opts(imgAr[n+1]).trueSrc, style:'height:151px'}
# 											figcaption(a opts(imgAr[n+1]).alt)+"<!--- #{opts(imgAr[n+1]).com}---->"							
# 						else
# 							div class:"gallery__slide #{if n==0 => \active else 'hidden' }", 'data-slide':n/2,
# 								div class:\table__cell, 
# 									a class:\img__preview href:\#win4, 
# 										figure {},
# 											img(alt:opts(imgAr[n]).alt, src:opts(imgAr[n]).trueSrc, style:'height:151px'), 
# 											figcaption(a opts(imgAr[n]).alt)+"<!--- #{opts(imgAr[n]).com}---->"
# 					div class:\gallery__dots,
# 						unwords <| for I,n in imgAr	
# 							if n%2==0=> button class:"#{if n==0 => \active else 'hidden' }" 'data-slide':n/2, \&nbsp
# 					button class:\gallery__next, \&nbsp
# 					a href:\#x class:\overlay id:\win4
# 					div class:\popup,
# 						img class:\is-image src:"ваша-картинка.jpg" alt:""
# 						a class:\close title:\Закрыть href:\#close"
					

# 				arr.push {type:\gallery,  img__arr:buffAr}

# 			case $ W .hasClass \FileCellContent
# 				fileAr=$(W).find(\.file__container); buffAr=[]
# 				opts=(F)->{text:$(F).find(\.file__text).text!, ext:$(F).find(\.file__icon).html!, source:$(F).find(\.file__icon).attr(\href), fileName:$(F).find(\.file__filename).text!}
				
# 				article+= section class:\grayfield,
# 					h3 \Скачать:
# 					unwords <| for F in fileAr
# 						buffAr.push {text:opts(F).text, ext:opts(F).ext, source:opts(F).source, fileName:opts(F).fileName}
# 						div a {class:"download #{opts(F).ext}", href:opts(F).source, 'data-ext':'.'+opts(F).ext, 'data-count':\2}, opts(F).text
# 				arr.push {type:\file, file__arr:buffAr}
					
# 						# class="download img" href="#" data-ext=".jpg" data-count="1623"
# 			case $ W .hasClass \MapCellContent
# 				lat   = $(W).find(\img).attr(\lat)
# 				lon   = $(W).find(\img).attr(\lon)
# 				scale = $(W).find(\img).attr(\scale)
# 				adress = $(W).find(\.form-control-cell-map-adress).text!
# 				arr.push {type:\map, lat,lon,scale, adress}
# 				id=drop(2,String(Math.random()))
# 				article+= section div {},
# 					div {id:id, style:'width:100%; height:300px'}
# 					script src:\https://api-maps.yandex.ru/2.1/?lang=ru_RU type:\text/javascript
# 					script "$(document).ready(function(){
# 						ymaps.ready(function(){
# 						  var myMap = new ymaps.Map('#{id}', {
# 						      center:    [#{lat}, #{lon}],
# 						      zoom:      #{scale},
# 						      controls:  ['smallMapDefaultSet']
# 						    }, {searchControlProvider: 'yandex\#search'}),
# 						    myPlacemark = new ymaps.Placemark(myMap.getCenter(), {}, {
# 						      iconLayout:      'default\#image',
# 						      iconImageHref:   '/img/yamap.png',
# 						      iconImageSize:   [84, 53],
# 						      iconImageOffset: [-60, -50]
# 						    });
# 						  myMap.geoObjects.add(myPlacemark);
# 						});})"
# 		out = {obj__article:arr, str__article:article}

# @editor = new editorClass()