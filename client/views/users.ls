class @FEUclass extends FElibClass
	rusName:-> map (\пользовател + ), <[ь я ю я ем е и ей ям ей ями ях]>
	mongo:\users  
	DB:-> Users

	cellsArr: (doc) ~> 
		roleArrNames=[]
		if doc?roles 
			for role in doc?roles
				roleArrNames.push Meteor.roles.findOne(_id:role)?name    
		arr = [
			td doc?username  ||\————— 
			td roleArrNames*', '  ]

	headersArr:-> <[ Имя Роли ]>

	EditComponents:~> div {},
		@TextInput input, 'Имя '+@rusName!1, \username, @Doc?username||''
		@TextInput input, 'E-mail '+@rusName!1, \email, @Doc(\emails)?0?address||'' ##, @DB!findOne(_id:currentID!)?profile?email || ''

		@PassInput!
		div class:\page-header,
			h4 'Выбор ролей пользователя'
		div class:'rolesList list-group', @RolesList!
		# @SpecTextInput 'Имя '+@rusName!1, \profile-name, @DB!findOne(_id:currentID!)?profile?name||''
		# @SpecTextInput 'E-mail '+@rusName!1, \email, @DB!findOne(_id:currentID!)?emails?[0]?address || ''

	PassInput:->
		div class:'input-group input-group-section',
			div class:'input-group-addon', @RedStar!+\Пароль
			if currentID! == \insert => input {class: 'input-div form-control pass-input', type:\password, name:\password}
			else a class:'btn form-control password-button' style:'background-color:rgb(248,245,240); color:black; border-color:rgb(223,215,203)', 'Изменить пароль'	



	RolesList:(out='')~> 
		for role in Meteor.roles.find!fetch!
			if not empty intersection role._id, @Doc(\roles) then cls = 'list-group-item active'
			else cls='list-group-item'
			out+=div {class:cls, name:role._id}, role.name
		out

	CustomEvents:~> do 
		'click .list-group-item':~> 
			$(event.target).toggleClass('active')
		'click .password-button':~> 
			$('.password-button').parent!append input {class: 'input-div form-control pass-input', type:\password, name:\password}	
			$('.password-button').remove!

# Template.RolesUserInsertList.rendered = ->
#   global.rolesArray = []
  # for role in Meteor.roles.find!.fetch!
#     div {class:\list-group-item name:role._id}, role.name


# Template.RolesUserInsertList.events

    # if _.contains global.rolesArray, $(event.target).attr('name') 
    #   global.rolesArray.pop $(event.target).attr('name')
    # else global.rolesArray.push $(event.target).attr('name')
    

	SaveManager:-> 	
		# data={}
		# data.roles = []
		
		# for field in $ \.text-input 
		# 	data[$(field).attr \name] = $(field)?value || $(field).text! || $(field).val()
		# 	if data[$(field).attr \name]=='' 
		# 		$(field).parent!addClass 'has-error'
		
		# for field in $ \.list-group-item.active 
		# 	data['roles'].push $(field).attr \name 
		
		# if not isValidEmail(data.email)
		# 	$('.text-input[name="email"]').parent!addClass 'has-error'

		# if $(\.pass-input).length
		# 	data.password = $(\.pass-input).val!

		# if $(\.pass-input).val!	== ''
		# 	$(\.pass-input).parent!addClass 'has-error'

		# if data.password == '' 
		# 	$(\.pass-input).parent!addClass 'has-error'
		# if currentID! == \insert and $('.password-button').length
		# 	$('.password-button').attr 'class', 'btn form-control btn-danger has-error password-button'
		# 	$(\.password-button).parent!addClass 'has-error'
		# 	$('.password-button').attr 'style', ''
		# data = 
		# 	profile: name: $('.text-input[name="name"]').val!
		# 	email: $('.text-input[name="email"]').val!
		# 	password: $('.pass-input').val!

		# Meteor.call 'createUserAccount', data, (e)-> console.log e
		# if not $(\.has-error).length			
		# 	if currentID! is \insert then Meteor.call 'createUserAccount', data, (e)-> console.log e
		# 	else Meteor.call 'updateUserAccount', currentID!, data
		# 	Router.go '/admin/users'


@FEU = new FEUclass

FEU.SaveManager=-> 	

	data = 
		username: $('.text-input[name="username"]').val!
		email: $('.text-input[name="email"]').val!
		roles: []

	data.emails = [{address:data.email, verified:false}]

	unless data.email    => $('[name="email"]').parent!addClass 'has-error'
	unless data.username => $('[name="username"]').parent!addClass 'has-error'

	unless isValidEmail(data.email) => $('[name="email"]').parent!addClass 'has-error'
		# 	$('.text-input[name="email"]').parent!addClass 'has-error'




	if $(\.pass-input).length 
		data.password = $('.pass-input').val!
		unless data.password => $('[name="password"]').parent!addClass 'has-error'

	for field in $ \.list-group-item.active 
		data['roles'].push $(field).attr \name 

	
	if not $(\.has-error).length
		if currentID! is \insert => Meteor.call 'createUserAccount', data, (e)-> 
			if not e then Router.go '/admin/users' else console.log e
		else Meteor.call 'updateUserAccount', currentID!, data, (e)-> 
			if not e then Router.go '/admin/users' else console.log e




FEU.Init!






# Template.RolesUserEditList.rendered = ->
#   currentRoleList = Meteor.users.findOne({ _id: currentID() }).roles
#   _.each Meteor.roles.find({},{}).fetch(), (col) ->
#     if _.contains currentRoleList, col._id then  active = 'list-group-item-success' else active = ''
#     $('.rolesList').append( '<div class = "list-group-item '+active+'" name="'+col._id+'">'+col.name+'</div>')  



# Template.RolesUserEditList.events
#   'click .list-group-item': (event,target) ->
#     obj = {}
#     obj['roles']= $(event.target).attr('name')
#     if _.contains Meteor.users.findOne({ _id: currentID() }).roles, $(event.target).attr('name')
#       Meteor.users.update { _id: currentID() }, {$pull: obj }
#       # $(event.target).removeClass('list-group-item')
#     else  
#       Meteor.users.update { _id: currentID() }, {$addToSet: obj }
#     $(event.target).toggleClass('list-group-item-success')
