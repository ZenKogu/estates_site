
Template.registerHelper \isUser, -> !!Meteor.user!
Template.registerHelper \userEmail, -> Meteor.user!emails[0].address
Template.registerHelper \userId, -> Meteor.userId!
Template.registerHelper \isAdmin, -> Meteor.user!roles[0]==\1
  # if Meteor.user() and Meteor.user().profile
  #   name = Meteor.user().profile.name
  # name\




# global.ProjectsListItems = (cursor) ->
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
