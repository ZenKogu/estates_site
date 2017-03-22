# pageSession = new ReactiveDict

# Template.Projects.rendered = ->

# Template.Projects.events {}
# Template.Projects.helpers {}

# ProjectsListItems = (cursor) ->
# 	if !cursor
# 		return []
# 	searchString = pageSession.get('ProjectsListSearchString')
# 	sortBy = pageSession.get('ProjectsListSortBy')
# 	sortAscending = pageSession.get('ProjectsListSortAscending')
# 	if typeof sortAscending == 'undefined'
# 		sortAscending = true
# 	raw = cursor.fetch()
# 	# filter
# 	filtered = []
# 	if !searchString or searchString == ''
# 		filtered = raw
# 	else
# 		searchString = searchString.replace('.', '\\.')
# 		regEx = new RegExp(searchString, 'i')
# 		searchFields = [
# 			'name'
# 			'description'
# 			'createdBy'
# 			'collection'
# 		]
# 		filtered = _.filter(raw, (item) ->
# 			match = false
# 			_.each searchFields, (field) ->
# 				value = (getPropertyValue(field, item) or '') + ''
# 				match = match or value and value.match(regEx)
# 				if match
# 					return false
# 				return
# 			match
# 		)
# 	# sort
# 	if sortBy
# 		filtered = _.sortBy(filtered, sortBy)
# 		# descending?
# 		if !sortAscending
# 			filtered = filtered.reverse()
# 	filtered

# ProjectsListExport = (cursor, fileType) ->
# 	data = ProjectsListItems(cursor)
# 	exportFields = []
# 	str = convertArrayOfObjects(data, exportFields, fileType)
# 	filename = 'export.' + fileType
# 	downloadLocalResource str, filename, 'application/octet-stream'
# 	return

# Template.ProjectsList.rendered = ->
# 	pageSession.set 'ProjectsListStyle', 'table'
# 	return

# Template.ProjectsList.events
# 	'click .dataview-insert-button': (e, t) ->
# 		e.preventDefault()
# 		Router.go 'projects.insert', {}
# 		return

# Template.ProjectsList.helpers
# 	'insertButtonClass': ->
# 		if Projects.userCanInsert(Meteor.userId(), {}) then '' else 'hidden'
# 	'isEmpty': ->
# 		!@projects or @projects.count() == 0
# 	'isNotEmpty': ->
# 		@projects and @projects.count() > 0
# 	'isNotFound': ->
# 		@projects and pageSession.get('ProjectsListSearchString') and ProjectsListItems(@projects).length == 0
# 	'searchString': ->
# 		pageSession.get 'ProjectsListSearchString'
# 	'viewAsTable': ->
# 		pageSession.get('ProjectsListStyle') == 'table'
# 	'viewAsList': ->
# 		pageSession.get('ProjectsListStyle') == 'list'
# 	'viewAsGallery': ->
# 		pageSession.get('ProjectsListStyle') == 'gallery'
# 	'insertButtonClass': ->
# 		if MongoAccessGranted(Meteor.userId(), 'projects', 'insert') then '' else 'hidden'

# Template.ProjectsListTable.rendered = ->

# Template.ProjectsListTable.events 'click .th-sortable': (e, t) ->
# 	e.preventDefault()
# 	oldSortBy = pageSession.get('ProjectsListSortBy')
# 	newSortBy = $(e.target).attr('data-sort')
# 	pageSession.set 'ProjectsListSortBy', newSortBy
# 	if oldSortBy == newSortBy
# 		sortAscending = pageSession.get('ProjectsListSortAscending') or false
# 		pageSession.set 'ProjectsListSortAscending', !sortAscending
# 	else
# 		pageSession.set 'ProjectsListSortAscending', true
# 	return
# Template.ProjectsListTable.helpers 'tableItems': ->
# 	ProjectsListItems @projects

# Template.ProjectsListTableItems.rendered = ->


# Template.ProjectsListTableItems.events
# 	'click .inline-checkbox': (e, t) ->
# 		e.preventDefault()
# 		if !this or !@_id
# 			return false
# 		fieldName = $(e.currentTarget).attr('data-field')
# 		if !fieldName
# 			return false
# 		values = {}
# 		values[fieldName] = !@[fieldName]
# 		Projects.update { _id: @_id }, $set: values
# 		false
# 	'click .delete-button': (e, t) ->
# 		e.preventDefault()
# 		me = this
# 		bootbox.dialog
# 			message: 'Вы действительно хотите удалить?'
# 			title: 'Удалить'
# 			animate: false
# 			buttons:
# 				success:
# 					label: 'Yes'
# 					className: 'btn-success'
# 					callback: ->
# 						Projects.remove _id: me._id
# 						return
# 				danger:
# 					label: 'No'
# 					className: 'btn-default'
# 		false
# 	'click .edit-button': (e, t) ->
# 		e.preventDefault()
# 		Router.go 'projects.edit',
# 			projectId: @_id
# 			# fileId: null
# 		false
# Template.ProjectsListTableItems.helpers
# 	'autName': ->
# 		userId = Projects.findOne({_id: @_id }).createdBy
# 		return Meteor.users.findOne({_id: userId}).profile.name
# 	'colName': ->
# 		colId = Projects.findOne({_id: @_id }).collection
# 		return Estates.findOne({_id: colId}).name

# 	'checked': (value) ->
# 		if value then 'checked' else ''
# 	'editButtonClass': ->
# 		if MongoAccessGranted(Meteor.userId(),'projects','update') then '' else 'hidden'
# 	'deleteButtonClass': ->
# 		if MongoAccessGranted(Meteor.userId(), 'projects', 'remove') then '' else 'hidden'
# 	'positiveClass': ->
# 		if Projects.findOne({_id:@_id}).published == 'да' then 'positive-class' else ''