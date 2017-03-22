# class @FENclass extends FElibClass
# 	rusName:-> map (\новост + ), <[ ь и и ей и ям ь и ью ями и ях ]> 
# 	mongo:\news	
# 	DB:-> News
# 	canIremove:(id)-> !Materials.find collection:String(id) .count!
# 	EditComponents:~> div {},
# 		@CheckBoxInput 'Снята с публикации', \unpublished
# 		@ShortLinksManager!
# 		@TextInput input, 'Название '+@rusName!1, \name
# 		@TextInput div, 'Описание '+@rusName!1, \description
# @FEN = new FENclass
# FEN.Init!
# 		