class @FERclass extends FElibClass
	rusName:-> map (\рол + ), <[ь и и ь ью и и ей ям и ями ях]>
	mongo: \roles 
	DB:-> Meteor.roles
	cellsArr:~> [td it?name ||\—————]
	headersArr:-> <[ Название ]>
	canIremove:-> empty intersection (flatten map (.roles), Meteor.users.find!fetch!), [String it]

	EditComponents:~> div {},
		@TextInput input, 'Название '+@rusName!1, \name
		@TextInput input, 'Описание '+@rusName!1, \description
		div class:\page-header,
			h4 'Выбор полномочий роли'

		@RolesTable!

	RolesTable:~> table class:'table form-group' style:'width:600px' name :'MongoAccessList' value:'',
		thead {}, tr {},
			th style :'width:150px', 'Группа объектов'
			th \Чтение
			th \Создание
			th \Изменение
			th \Удаление
		tbody {}, @RolesTbody!

	RolesTbody:(res='')~> 
		for mongo in <[ users roles collections materials  ]> # news events files videos galleries comments
			tdRow=''
			for op in <[ read insert update remove ]>
				if any (==mongo+'.'+op), @Doc(\MongoAccessList) then val=\Да; cls=\btn-success else val=\Нет; cls=\btn-danger
				tdRow+= td a {class:'btn mongo-access '+cls, style:'width:100%', name:mongo+'.'+op}, val
			res+= tr td @TranslateSection(mongo), tdRow
		console.log @Doc(\MongoAccessList)
		res

	TranslateSection:-> switch it
		| \users => \Пользователи 
		| \roles => \Роли 
		| \materials => \Материалы
		| \collections => \Коллекции
		| \news => \Новости
		| \events => \События
		| \comments => \Комментарии
		| \files => \Файлы
		| \videos => \Видео
		| \galleries => \Галереи

@FER = new FERclass

FER.Init!
