# class @Fclass
# 	m__link:-> "/collections/#{it.collection}/#{it._id}-#{it.translitName}"
# 	c__link:-> "/collections/#{it._id}-#{it.translitName}"
# 	c__tree:~>  
# 		unwords <| for C in Collections.find(unpublished:false).fetch!
# 			li a href:@c__link(C), C.name
# 	m__tree:(colId,M_cur)~>
# 		open_q=(O)-> if O===M_cur || O?_id===M_cur?parentMaterial || O?_id===Materials.findOne(_id:M_cur?parentMaterial)?parentMaterial => class:\open else {}
# 		unwords <| for M in Materials.find(parentMaterial:\noname, collection:colId, published:true).fetch!
# 			li open_q(M),
# 				span a href:@m__link(M), M.name
# 				ul {},
# 					unwords <| for CM in Materials.find(parentMaterial:M._id, collection:colId, published:true).fetch!
# 						li open_q(CM),
# 							a href:@m__link(CM), span CM.name
# 							ul {},				
# 								unwords <| for CCM in Materials.find(parentMaterial:CM._id, collection:colId, published:true).fetch!
# 									li a href:@m__link(CCM), CCM.name

# 	HEAD    :(DB, id)-> 
# 		o = DB?findOne(_id:String(id)) if DB
# 		name      = o?name||''
# 		desc      = o?description||''
# 		keywords  = o?keywords*', ' if o?keywords
# 		index     = if o?index==false  => \noindex else \index
# 		follow    = if o?follow==false => \nofollow else \follow
# 		head {},
# 			meta name:\robots      content:index+','+follow
# 			meta name:\Description content:desc
# 			meta name:\Keywords    content:keywords
# 			meta charset:\utf-8
# 			meta name:\viewport content:"width=device-width, initial-scale=1, shrink-to-fit=no"
# 			meta http-equiv:\x-ua-compatible content:\ie=edge 
# 			link rel:\stylesheet type:\text/css href:\/css/style.css 
# 			link rel:\stylesheet type:\text/css href:\/css/style_plus.css
# 			title "#name | Школа 2100"
# 			script src:\https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js
# 			link rel:\stylesheet href:\https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css
# 			script src:\https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js
# 	HEADER          :-> 
# 		header class:\header,
# 			div class:\container,
# 				div class:\header__social,
# 					a href:\# class:\header__social__oldsite, 'прежний сайт'
# 					a href:\# title:\ВКонтакте class:\header__social__vk
# 					a href:\# title:\Facebook class:\header__social__fb
# 					a href:\# title:\Twitter class:\header__social__twitter
# 					a href:\# title:\Youtube class:\header__social__youtube
# 				a href:\/ class:\header__logo title:"На главную",
# 					img src:'data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==' alt:'Школа 2100'
# 				div class:\header__text,
# 					p class:\header__text__main, 'Образовательная система “Школа 2100”'
# 					p class:\header__text__slogan, 'Живём в настоящем, думаем о будущем'
# 				div class:\header__auth,
# 					a href:\#, 'Войти'
# 					a href:\#, 'Зарегистрироваться'
# 	NAV             :-> 
# 		nav class:\nav,
# 			div class:\nav__base,
# 				div class:"container table",
# 					div class:\nav__links,
# 						a href:\# class:\nav__item, 'Школа 2100'
# 						a href:\# class:\nav__item, 'Каталог'
# 						a href:\# class:\nav__item, 'Электронные учебники'
# 						a href:\/info class:\nav__item, 'Курсы'
# 						a href:\# class:\nav__item, 'Вебинары'
# 						a href:\# class:\nav__item, 'Форум'
# 						a href:\# class:\nav__item, 'Контакты'
# 					div class:\nav__search,
# 						input class:\nav__search__input type:\text 
# 			div class:\nav__extra,
# 				div class:"container table_fixed",
# 					a href:\# class:\nav__extra__konspekt,
# 						span 'Конспекты уроков'
# 					a href:\# class:\nav__extra__forum,
# 						span 'Форум'
# 					a href:\# class:\nav__extra__efu,
# 						span 'ЭФУ'
# 					a href:\# class:\nav__extra__kindergarden,
# 						span 'Детский сад 2100'			
# 	FOOTER          :-> 
# 		footer class:\footer,
# 			div class:\footer__social,
# 				div class:\container,
# 					a href:\# class:\footer__social__item,
# 						span class:\vk, 'Поделиться 87'
# 					a href:\# class:\footer__social__item,
# 						span class:\fb, 'Поделиться 187'
# 					a href:\# class:\footer__social__item,
# 						span class:\twitter, 'Твитнуть 66'
# 					a href:\# class:\footer__social__item,
# 						span class:\youtube, 'Подписаться 59'
# 			div class:\footer__nav,
# 				div class:"container table",
# 					div class:\footer__nav__links,
# 						a href:\#, 'Главная'
# 						a href:\#, 'О “Школе 2100”'
# 						a href:\#, 'Каталог'
# 						a href:\#, 'Электронные учебники'
# 						a href:\/info.html, 'Курсы'
# 						a href:\#, 'Вебинары'
# 					div class:\footer__nav__links,
# 						a href:\#, 'Новости и объявления'
# 						a href:\#, 'Видео'
# 						a href:\#, 'Календарь событий'
# 						a href:\#, 'Конспекты уроков'
# 						a href:\#, 'Экспертные заключения'
# 					div class:\footer__nav__links,
# 						a href:\#, 'Контакты'
# 						a href:\#, 'Карта сайта'
# 					div class:\footer__nav__links,
# 						a href:\#, 'Прайс-лист'
# 					div class:\footer__nav__links__empty
# 					div class:\footer__nav__contacts,
# 						div class:\footer__nav__contacts__social,
# 							a href:\# class:\footer__nav__contacts__social__vk
# 							a href:\# class:\footer__nav__contacts__social__fb
# 							a href:\# class:\footer__nav__contacts__social__twitter
# 							a href:\# class:\footer__nav__contacts__social__youtube
# 						span '© ООО «Баласс», 2011–2016'
# 						a href:\#, 'Информация об ограничениях'
# 						a href:\#, 'Условия использования'
# 						a href:\#, 'Политика конфиденциальности'
# 	ARTICLE__HEADER :-> 
# 		section div class:\container, 
# 			h1 it,
# 			a href:\/ class:\page_header_back title:'На главную', 'на главную страницу'
# 	COMMENTS        :-> 
# 		section class:\comments,
# 			h4 'Комментарии (2)'
# 			div {},
# 				div class:\comments__comment,
# 					div class:\comments__comment__header,
# 						img src:\img/avatar1.png alt:'Ivan Ivanov'
# 						'| Ivan Ivanov '
# 						date datetime:\2016-09-06T16:10:11+04:00, '06.09.16г. | 16:10:43'
# 						a href:\# class:\comments__comment__header__cell
# 						div class:\comments__comment__header__right,
# 							a href:\# class:\comments__comment__header__like, '1125'
# 							a href:\# class:\comments__comment__header__dislike, '23'
# 					p 'Мои расчеты, действительно, вписались в заявленные параметры производителя. Но статья не об этом, она немного глубже, в частности она отвечает, почему параметры именно такие и как этим можно попробовать поуправлять. в частности в этом data sheet нет ничего о принципах работы роуминга и как он влияет на частоту замеров и, следовательно точность и достоверность результатов, что я считаю ключевым моментом для понимания данной темы.'
# 					div class:\comments__comment,
# 						div class:\comments__comment__header,
# 							img src:\img/avatar.png alt:'Ivan Ivanov'
# 							'| Ivan Ivanov '
# 							date datetime:\2016-09-06T16:10:11+04:00, '06.09.16г. | 16:10:43'
# 							a href:\# class:\comments__comment__header__cell
# 							a href:\# class:\comments__comment__header__down
# 							a href:\# class:\comments__comment__header__up
# 							div class:\comments__comment__header__right,
# 								a href:\# class:\comments__comment__header__like, '1125'
# 								a href:\# class:\comments__comment__header__dislike, '23'
# 						p 'Мои расчеты, действительно, вписались в заявленные параметры производителя. Но статья не об этом, она немного глубже, в частности она отвечает, почему параметры именно такие и как этим можно попробовать поуправлять.'
# 						div class:\comments__comment,
# 							div class:\comments__comment__header,
# 								img src:\img/avatar1.png alt:'Ivan Ivanov'
# 								'| Ivan Ivanov '
# 								date datetime:\2016-09-06T16:10:11+04:00, '06.09.16г. | 16:10:43'
# 								a href:\# class:\comments__comment__header__cell
# 								a href:\# class:\comments__comment__header__down
# 								a href:\# class:\comments__comment__header__up
# 								div class:\comments__comment__header__right,
# 									a href:\# class:\comments__comment__header__like, '1125'
# 									a href:\# class:\comments__comment__header__dislike, '23'
# 							p 'Мои расчеты, действительно, вписались в заявленные параметры производителя. Но статья не об этом, она немного глубже, в частности она отвечает, почему параметры именно такие и как этим можно попробовать поуправлять.'
# 			div class:\comments__comment,
# 				div class:\comments__comment__header,
# 					img src:\img/avatar1.png alt:'Ivan Ivanov'
# 					'| Ivan Ivanov '
# 					date datetime:\2016-09-06T16:10:11+04:00, '06.09.16г. | 16:10:43'
# 					a href:\# class:\comments__comment__header__cell
# 					div class:\comments__comment__header__right,
# 						a href:\# class:\comments__comment__header__like, '1125'
# 						a href:\# class:\comments__comment__header__dislike, '23'
# 				p 'Мои расчеты, действительно, вписались в заявленные параметры производителя. Но статья не об этом, она немного глубже, в частности она отвечает, почему параметры именно такие и как этим можно попробовать поуправлять. в частности в этом data sheet нет ничего о принципах работы роуминга и как он влияет на частоту замеров и, следовательно точность и достоверность результатов, что я считаю ключевым моментом для понимания данной темы.'
# 			div class:'comments__comment inactive',
# 				div class:\comments__comment__header,
# 					img src:\img/avatar1.png alt:'Ivan Ivanov'
# 					'| Ivan Ivanov '
# 					date datetime:\2016-09-06T16:10:11+04:00, '06.09.16г. | 16:10:43'
# 					a href:\# class:\comments__comment__header__cell
# 					div class:\comments__comment__header__right,
# 						a href:\# class:\comments__comment__header__like, '1125'
# 						a href:\# class:\comments__comment__header__dislike, '23'
# 				p 'Мои расчеты, действительно, вписались в заявленные параметры производителя. Но статья не об этом, она немного глубже, в частности она отвечает, почему параметры именно такие и как этим можно попробовать поуправлять. в частности в этом data sheet нет ничего о принципах работы роуминга и как он влияет на частоту замеров и, следовательно точность и достоверность результатов, что я считаю ключевым моментом для понимания данной темы.'
# 			div class:\comments__notlogged, 'Только зарегистрированные пользователи могут оставлять комментарии.',
# 				a href:\#, 'Войдите'
# 				', пожалуйста.'
# #--------------------------------------------- PAGES --------------------------
# 	INDEX__CONTENT  :-> 
# 		div class:\article__content,
# 			article class:\materials__article,
# 				h2 class:\peach, 'Нормативный акт'
# 				a href:\# class:\pdf
# 				a href:\#,
# 					h3 'О работе в 5 – 7 классах с учебным пособием «Мои первые исследования»'
# 				p 'Учебное пособие «Мои первые исследования» было задумано не столько как элективный или обязательный специальный курс исследовательской деятельности в школе...'
# 				div class:\materials__article__tags,
# 					a href:\#, 'Ключевое слово 1'
# 					a href:\#, 'Ключевик 2'
# 					a href:\#, 'Слово 3'
# 				div class:\materials__article__bottom,
# 					time datetime:\2015-12-22T18:18:18+04:00, '22.15.2015г.' #!-- Дата и время задается в международном формате ISO 8601 --
# 					div class:\social,
# 						a href:\# class:\vk
# 						a href:\# class:\fb
# 						a href:\# class:\twitter
# 						a href:\# class:\ok
# 						a href:\# class:\gplus
# 						a href:\# class:\lj
# 						div class:\plus,
# 							div class:\icon
# 							span '123 456'
# 			article class:\materials__article,
# 				h2 class:\green, 'Презентация'
# 				a href:\# class:\docx
# 				a href:\#,
# 					h3 'Правовые основания выбора учебников ОС «Школа 2100»'
# 				p 'Наступил новый учебный год, и стало очевидным, что во многих образовательных организациях учителя продолжают работать по учебникам Образовательной системы «Школа 2100»...'
# 				div class:\materials__article__tags,
# 					a href:\#, 'Ключевое слово 1'
# 					a href:\#, 'Ключевик 2'
# 				div class:\materials__article__bottom,
# 					time datetime:\2015-12-22T18:18:18+04:00, '22.15.2015г.' #!-- Дата и время задается в международном формате ISO 8601 --
# 					div class:\social,
# 						a href:\# class:\vk
# 						a href:\# class:\fb
# 						a href:\# class:\twitter
# 						a href:\# class:\ok
# 						a href:\# class:\gplus
# 						a href:\# class:\lj
# 						div class:\plus,
# 							div class:\icon
# 							span '123 456'
# 			article class:\materials__article,
# 				h2 class:\blue, 'Уроки'
# 				a href:\# class:\pptx
# 				a href:\#,
# 					h3 'Об использовании учебников «Основы светской этики» (авторы Р.Н. Бунеев, Д.Д. Данилов, И.И. Кремлева) и «Основы мировых религиозных культур»'
# 				p 'Учебное пособие «Мои первые исследования» было задумано не столько как элективный или обязательный...'
# 				div class:\materials__article__tags,
# 					a href:\#, 'Ключевое слово 1'
# 					a href:\#, 'Ключевик 2'
# 				div class:\materials__article__bottom,
# 					time datetime:\2015-12-22T18:18:18+04:00, '22.15.2015г.' #!-- Дата и время задается в международном формате ISO 8601 --
# 					div class:\social,
# 						a href:\# class:\vk
# 						a href:\# class:\fb
# 						a href:\# class:\twitter
# 						a href:\# class:\ok
# 						a href:\# class:\gplus
# 						a href:\# class:\lj
# 						div class:\plus,
# 							div class:\icon
# 							span '123 456'
# 			article class:\materials__article,
# 				h2 class:\pink, 'Статьи'
# 				a href:\# class:\docx
# 				a href:\#,
# 					h3 'Правовые основания выбора учебников ОС «Школа 2100»'
# 				p 'Учебное пособие «Мои первые исследования» было задумано не столько как элективный или обязательный специальный курс исследовательской деятельности в школе со своей программой и методическим пособием для учителя, сколько как задачник и самоучитель для внеклассной работы...'
# 				div class:\materials__article__tags,
# 					a href:\#, 'Ключевое слово 1'
# 					a href:\#, 'Ключевик 2'
# 				div class:\materials__article__bottom,
# 					time datetime:\2015-12-22T18:18:18+04:00, '22.15.2015г.' #!-- Дата и время задается в международном формате ISO 8601 --
# 					div class:\social,
# 						a href:\# class:\vk
# 						a href:\# class:\fb
# 						a href:\# class:\twitter
# 						a href:\# class:\ok
# 						a href:\# class:\gplus
# 						a href:\# class:\lj
# 						div class:\plus,
# 							div class:\icon
# 							span '123 456'
# 			hr!
# 			div class:\pagination,
# 				a href:\# class:\prev
# 				span class:\active, '1'
# 				a href:\#, '2,'
# 				a href:\#, '3,'
# 				a href:\#, '4,'
# 				a href:\#, '5,'
# 				span class:\etc, '...'
# 				a href:\#, '25'
# 				a href:\# class:\next
# 	SEARCH__TOOLS   :-> 
# 		form id:\search_tools,
# 			p 'Школьная ступень:'
# 			div class:\steps,
# 				input type:\checkbox class:\checkbox id:\step0 
# 				label for:\step0, 'Дошкольное образование'
# 				div class:\content,
# 					input type:\checkbox class:\checkbox id:\step01 
# 					label for:\step01, 'Ясли'
# 					input type:\checkbox class:\checkbox id:\step02 
# 					label for:\step02, 'Основной курс'
# 					input type:\checkbox class:\checkbox id:\step03 
# 					label for:\step03, 'Подготовишки'
# 			div class:"steps open",
# 				input type:\checkbox class:\checkbox id:\step1 
# 				label for:\step1, 'Начальная школа'
# 				div class:\content,
# 					input type:\checkbox class:\checkbox id:\step11 
# 					label for:\step11, '1 класс'
# 					input type:\checkbox class:\checkbox id:\step12 
# 					label for:\step12, '2 класс'
# 					input type:\checkbox class:\checkbox id:\step13 
# 					label for:\step13, '3 класс'
# 					input type:\checkbox class:\checkbox id:\step14 
# 					label for:\step14, '4 класс'
# 			div class:\steps,
# 				input type:\checkbox class:\checkbox id:\step2 
# 				label for:\step2, 'Основная школа'
# 				div class:\content,
# 					input type:\checkbox class:\checkbox id:\step21 
# 					label for:\step21, '5 класс'
# 					input type:\checkbox class:\checkbox id:\step22 
# 					label for:\step22, '6 класс'
# 					input type:\checkbox class:\checkbox id:\step23 
# 					label for:\step23, '7 класс'
# 					input type:\checkbox class:\checkbox id:\step24 
# 					label for:\step24, '8 класс'
# 					input type:\checkbox class:\checkbox id:\step25 
# 					label for:\step25, '9 класс'
# 			div class:\steps,
# 				input type:\checkbox class:\checkbox id:\step3 
# 				label for:\step3, 'Старшая школа'
# 				div class:\content,
# 					input type:\checkbox class:\checkbox id:\step31 
# 					label for:\step31, '10 класс'
# 					input type:\checkbox class:\checkbox id:\step32 
# 					label for:\step32, '11 класс'
# 			p 'Предметы:'
# 			select class:\select,
# 				option 'Все'
# 				option 'Русский язык'
# 				option 'Математика'
# 			hr!
# 			p 'Материалы за период:'
# 			div class:\radiogroup,
# 				div {},
# 					input type:\radio class:\radio id:\radio1 
# 					label for:\radio1, 'Всё время'
# 				div {},
# 					input type:\radio class:\radio id:\radio2 
# 					label for:\radio2, 'Месяц'
# 				div {},
# 					input type:\radio class:\radio id:\radio3 
# 					label for:\radio3, 'Год'
# 			div class:\daterange,
# 				label for:\from, 'с'
# 				input type:\text class:\date id:\from 
# 				label for:\until, 'по'
# 				input type:\text class:\date id:\until 
# 			hr!
# 			p 'Тип материала:'
# 			div {},
# 				input type:\checkbox class:\checkbox id:\type1 
# 				label for:\type1, 'Нормативные акты'
# 			div {},
# 				input type:\checkbox class:\checkbox id:\type2 
# 				label for:\type2, 'Презентации'
# 			div {},
# 				input type:\checkbox class:\checkbox id:\type3 
# 				label for:\type3, 'Статьи'
# 			div {},
# 				input type:\checkbox class:\checkbox id:\type4 
# 				label for:\type4, 'Уроки'
# 			div {},
# 				input type:\checkbox class:\checkbox id:\type5 
# 				label for:\type5, 'Другое'
# 			hr!
# 			p 'Ключевые слова:'
# 			textarea placeholder:"Введите ключевые слова через запятую"
# 			hr!
# 			p 'Сайт:'
# 			div {},
# 				input type:\checkbox class:\checkbox id:\school1 
# 				label for:\school1, 'school2100.com'
# 			div {},
# 				input type:\checkbox class:\checkbox id:\school2 
# 				label for:\school2, 'world.school2100.com'
# 			div {},
# 				input type:\checkbox class:\checkbox checked:\checked id:\school3 
# 				label for:\school3, 'app.school2100.com'
# 			div {},
# 				input type:\checkbox class:\checkbox id:\school4 
# 				label for:\school4, 'doo.school2100.com'
# 			hr!
# 			input type:\submit value:\применить 
# 			a href:\# class:\refresh onclick:"document.getElementById('search_tools').reset(); return false;", 'параметры по умолчанию'

# 	INDEX           :~> 
# 		'<!DOCTYPE html>' + html lang:\ru,
# 			@HEAD!
# 			body div class:\body_wrapper,
# 				@HEADER!
# 				@NAV!
# 				section class:"container main",
# 					div class:\article,
# 						div class:\article__tools,
# 							@SEARCH__TOOLS!
# 						@INDEX__CONTENT!
# 					a href:\# class:\goup, 'наверх'
# 				div class:\push
# 				@FOOTER!
# 			script src:\/js/layout-support.js
# 	INFO         :(O)~> 
# 		'<!DOCTYPE html>' + html lang:\ru,
# 			@HEAD O.DB, O.id
# 			body div class:\body_wrapper,
# 				@HEADER!
# 				@NAV!
# 				section div class:\container,
# 					h1 O.header__text
# 					a href:\/ class:\page_header_back title:'На главную', 'на главную страницу'
# 				section class:'container main', div class:\article,
# 					div class:\article__tools, O.article__tools
# 					div class:\article__content, article O.content		
# 				@FOOTER!
# 			script src:\/js/layout-support.js
				
# 	MATERIAL    :(IN)-> @INFO do
# 		content: 		 IN.str__article
# 		colId: 			 IN.collection
# 		article__tools:	 ul(class:\article__tools__tree, @m__tree(IN.collection, IN))
# 		header__text:	 IN.name
# 		DB:				 Materials
# 		id:				 IN._id
# 	COLLECTION  :(IN)-> @INFO do
# 		content: 		 IN.description
# 		colId: 			 IN._id
# 		article__tools:	 ul(class:\article__tools__tree, @m__tree(IN._id))
# 		header__text:	 IN.name
# 		DB:				 Collections
# 		id:				 IN._id
# 	COLLECTIONS     :-> @INFO do
# 		content: 		 'Список всех коллекций'
# 		colId: 			 \1
# 		article__tools:	 ul(class:\article__tools__tree, @c__tree!)
# 		header__text:	 'Список всех коллекций'
# 	NOT__FOUND      :-> 
# 		'<!DOCTYPE html>' + html lang:\ru,
# 			@HEAD!
# 			body div class:\body_wrapper,
# 				@HEADER!
# 				@NAV!
# 				section div class:\container,
# 					h1 'Страница не найдена'
# 					a href:\/ class:\page_header_back title:'На главную', 'на главную страницу'
# 				section class:'container main', div class:\article style:'height:400px'
# 				@FOOTER!


# 	# LOGIN         :~> 
# 	# 	'<!DOCTYPE html>' + html lang:\ru,
# 	# 		@HEAD!
# 	# 		body div class:\body_wrapper,
# 	# 			@HEADER!
# 	# 			nav class:\nav,
# 	# 				div class:\nav__base,
# 	# 					div class:"container table",
# 	# 						div class:\nav__links,
# 	# 							a href:\# class:\nav__item, 'Школа 2100'
# 	# 							a href:\# class:\nav__item, 'Каталог'
# 	# 							a href:\# class:\nav__item, 'Электронные учебники'
# 	# 							a href:\/info class:\nav__item, 'Курсы'
# 	# 							a href:\# class:\nav__item, 'Вебинары'
# 	# 							a href:\# class:\nav__item, 'Форум'
# 	# 							a href:\# class:\nav__item, 'Контакты'
# 	# 						div class:\nav__search,
# 	# 							input class:\nav__search__input type:\text 
# 	# 			section div class:\container style:'height:400px; align:center; margin-left:40%',

# 	# 				form id:"login_form" class:"account-form" role:\form style:'width:300px; height:150px; align:center; margin:50px',
# 	# 					h2 'Вход в систему'					
# 	# 					div id:\login-with-password style:\padding-top:10px
# 	# 						input id:\login_email type:\text class:\form-control placeholder:\Email required:\required autofocus:\autofocus
# 	# 						input id:\login_password type:\password class:\form-control placeholder:\Пароль required:\required
# 	# 						button class:'btn btn-lg btn-primary btn-block' type:\submit data-loading-text:"Пожалуйста, подождите...", 'Войти'      
# 	# 			@FOOTER!
			
		


# @F = new Fclass
