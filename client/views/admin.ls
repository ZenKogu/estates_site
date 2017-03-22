# Template.Admin.helpers
#   'userName': -> 
#   'rolesRoute': ->
#     if MongoAccessGranted Meteor.userId(), 'roles', 'read' then '' else 'hidden'
#   'usersRoute': ->
#     if MongoAccessGranted Meteor.userId(),'users', 'read' then '' else 'hidden'
#   'colRoute': ->
#     if MongoAccessGranted Meteor.userId(), 'collections', 'read' then '' else 'hidden'
#   'materialRoute': ->
#     if MongoAccessGranted Meteor.userId(), 'materials', 'read' then '' else 'hidden'

Template.admin.rendered = ->
	li_a = (db,text)-> 
		if MongoAccessGranted Meteor.userId(), db, \read
			li {}, a class:\list-group-item href:'/admin/'+db, text
		else ''
	$ \.section-list .append div {},
		div class:'page-header', h3 'Добрый час, '+Meteor.user!username
		ul class:\list-group style:'width:400px',
			li_a \materials,   \Материалы
			li_a \collections, \Коллекции
			
			li_a \users,	   \Пользователи
			li_a \roles,	   \Роли
						
			# li_a \news,	       \Новости
			# li_a \videos,	   \Видео
			# li_a \files,	   \Файлы
			# li_a \events,	   \События
			# li_a \galleries,   \Галереи
			# li_a \comments,	   \Комментарии