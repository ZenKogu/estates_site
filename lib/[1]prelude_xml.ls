# @xml = (tag, o={}) -> 
# 	if o?noClose
# 		(opts, ...inner)~> 
# 			strOpts = ''
# 			for i of opts
# 				strOpts+=" #{i}=\"#{opts[i]}\""		
# 			"<#tag#strOpts>"
# 	else if o?selfClose
# 		(opts, ...inner)~> 
# 			strOpts = ''
# 			for i of opts
# 				strOpts+=" #{i}=\"#{opts[i]}\""		
# 			"<#tag#strOpts/>"
# 	else
# 		(opts, ...inner)~> 		
# 			strOpts = ''
# 			if _.isObject opts # если первый аргумент не объект, то opts считаем дочерним элементом
# 				for i of opts
# 					strOpts+=" #{i}=\"#{opts[i]}\""			
# 				"<#tag#strOpts>#{inner*' '}</#tag>"
# 			else if opts => "<#tag>#opts  #{inner*' '}</#tag>"
# 			else "<#tag></#tag>"

@xml=(o={tag:\div self:false})->(opts,...inner)~> switch
	| !o.self*opts?length => "<#{o.tag}>#opts #{inner*' '}</#{o.tag}>"
	| !o.self*!opts?length=> '<'+o.tag+[" #{i}=\"#{opts[i]}\"" for i of opts]+">#{inner*' '}</#{o.tag}>"		 
	| _=> '<'+o.tag+[" #i=\"#{opts[i]}\"" for i of opts]+\/>
		
@xml__init=(self)~>(tag)~>this[tag]=xml {tag, self}
prelude.each xml__init(false), <[ div span a p h4 h3 h2 h1 button table thead tr th tbody td small ul ol li span label select option textarea form output i sub time section html head body title script footer header article link nav figure figcaption tfoot video source type iframe ]>
prelude.each xml__init(true), <[ input link img meta source br hr ]>

# <[ is-type abs acos all and-list any apply asin at atan atan2 average break-list break-str camelize capitalize ceiling chars compact concat concat-map cos count-by curry dasherize difference drop drop-while each elem-index elem-indices empty even exp filter find find-index find-indices first fix flatten flip floor fold fold1 foldl foldl1 foldr foldr1 Func gcd group-by initial intersection is-it-NaN join keys last lcm lines lists-to-obj ln map max maximum maximum-by mean memoize min minimum minimum-by mod negate Num Obj obj-to-lists obj-to-pairs odd or-list over pairs-to-obj partition pi pow product quot recip reject reject rem repeat reverse replicate round scan scan1 scanl scanl1 scanr scanr1 signum sin slice sort sort-by sort-with split split-at sqrt Str sum tail take take-while tan tau truncate unchars unfoldr union unique unique-by unlines unwords values words zip zip-all zip-all-with zip-with ]>


# @xml__init=(tag)~>(self)~>this[tag]=xml tag; self
# prelude.each xml__init(false), <[ div span a p ]>
# @div   = xml     tag:\div
# @span   = xml    tag:\span
# @a      = xml    tag:\a 
# @p      = xml    tag:\p 
# @h4     = xml    tag:\h4  
# @h3     = xml    tag:\h3
# @h2     = xml    tag:\h2
# @h1     = xml    tag:\h1
# @button = xml    tag:\button 
# @table  = xml    tag:\table
# @thead  = xml    tag:\thead
# @tr     = xml    tag:\tr 
# @th     = xml    tag:\th 
# @tbody  = xml    tag:\tbody
# @td     = xml    tag:\td 
# @small  = xml    tag:\small 
# @ul     = xml    tag:\ul 
# @ol     = xml    tag:\ol 
# @li     = xml    tag:\li 
# @span   = xml    tag:\span 
# @label  = xml    tag:\label 
# @select = xml    tag:\select 
# @option = xml    tag:\option 
# @textarea = xml  tag:\textarea
# @form   = xml    tag:\form 
# @output = xml    tag:\output
# @i      = xml    tag:\i 
# @sub    = xml    tag:\sub 
# @time   = xml    tag:\time 
# @section = xml   tag:\section
# @input  = xml    tag:\input, self:true 
# @link = xml      tag:\link, self:true 
# @img   = xml     tag:\img, self:true
# @meta   = xml    tag:\meta, self:true 
# @source = xml    tag:\source, self:true 
# @html  = xml     tag:\html 
# @head  = xml     tag:\head
# @body  = xml     tag:\body
# @title  = xml    tag:\title 
# @script  = xml   tag:\script
# @footer = xml    tag:\footer
# @header = xml    tag:\header
# @article = xml   tag:\article
# @nav = xml       tag:\nav 
# @figure = xml    tag:\figure
# @figcaption= xml tag:\figcaption
# @tfoot = xml     tag:\tfoot
# @video = xml     tag:\video 
# @type = xml      tag:\type 
# @iframe = xml    tag:\iframe


# @br = -> \<br> 
# @hr = -> '<hr/>'


@is-type	    = prelude.is-type
@abs            = prelude.abs
@acos           = prelude.acos
@all            = prelude.all
@and-list       = prelude.and-list
@any            = prelude.any
@apply          = prelude.apply
@asin           = prelude.asin
@at             = prelude.at
@atan           = prelude.atan
@atan2          = prelude.atan2
@average        = prelude.average
@break-list     = prelude.break-list
@break-str      = prelude.break-str
@camelize       = prelude.camelize
@capitalize     = prelude.capitalize
@ceiling        = prelude.ceiling
@chars          = prelude.chars
@compact        = prelude.compact
@concat         = prelude.concat
@concat-map     = prelude.concat-map
@cos            = prelude.cos
@count-by       = prelude.count-by
@curry          = prelude.curry
@dasherize      = prelude.dasherize
@difference     = prelude.difference
@drop           = prelude.drop
@drop-while     = prelude.drop-while
@each           = prelude.each
@elem-index     = prelude.elem-index
@elem-indices   = prelude.elem-indices
@empty          = prelude.empty
@even           = prelude.even
@exp            = prelude.exp
@filter         = prelude.filter
@find           = prelude.find
@find-index     = prelude.find-index
@find-indices   = prelude.find-indices
@first          = prelude.first
@fix            = prelude.fix
@flatten        = prelude.flatten
@flip           = prelude.flip
@floor          = prelude.floor
@fold           = prelude.fold
@fold1          = prelude.fold1
@foldl          = prelude.foldl
@foldl1         = prelude.foldl1
@foldr          = prelude.foldr
@foldr1         = prelude.foldr1
@Func           = prelude.Func
@gcd            = prelude.gcd
@group-by       = prelude.group-by
@initial        = prelude.initial
@intersection   = prelude.intersection
@is-it-NaN      = prelude.is-it-NaN
@join           = prelude.join
@keys           = prelude.keys
@last           = prelude.last
@lcm            = prelude.lcm
@lines          = prelude.lines
@lists-to-obj   = prelude.lists-to-obj
@ln             = prelude.ln
@map            = prelude.map
@max            = prelude.max
@maximum        = prelude.maximum
@maximum-by     = prelude.maximum-by
@mean           = prelude.mean
@memoize        = prelude.memoize
@min            = prelude.min
@minimum        = prelude.minimum
@minimum-by     = prelude.minimum-by
@mod            = prelude.mod
@negate         = prelude.negate
@Num            = prelude.Num
@Obj            = prelude.Obj
@obj-to-lists   = prelude.obj-to-lists
@obj-to-pairs   = prelude.obj-to-pairs
@odd            = prelude.odd
@or-list        = prelude.or-list
@over           = prelude.over
@pairs-to-obj   = prelude.pairs-to-obj
@partition      = prelude.partition
@pi             = prelude.pi
@pow            = prelude.pow
@product        = prelude.product
@quot           = prelude.quot
@recip          = prelude.recip
@reject         = prelude.reject
@reject         = prelude.reject
@rem            = prelude.rem
@repeat         = prelude.repeat
@reverse        = prelude.reverse
@replicate		= prelude.replicate
@round          = prelude.round
@scan           = prelude.scan
@scan1          = prelude.scan1
@scanl          = prelude.scanl
@scanl1         = prelude.scanl1
@scanr          = prelude.scanr
@scanr1         = prelude.scanr1
@signum         = prelude.signum
@sin            = prelude.sin
@slice          = prelude.slice
@sort           = prelude.sort
@sort-by        = prelude.sort-by
@sort-with      = prelude.sort-with
@split          = prelude.split
@split-at       = prelude.split-at
@sqrt           = prelude.sqrt
@Str            = prelude.Str
@sum            = prelude.sum
@tail           = prelude.tail
@take           = prelude.take
@take-while     = prelude.take-while
@tan            = prelude.tan
@tau            = prelude.tau
@truncate       = prelude.truncate
@unchars        = prelude.unchars
@unfoldr        = prelude.unfoldr
@union          = prelude.union
@unique         = prelude.unique
@unique-by      = prelude.unique-by
@unlines        = prelude.unlines
@unwords        = prelude.unwords
@values         = prelude.values
@words          = prelude.words
@zip            = prelude.zip
@zip-all        = prelude.zip-all
@zip-all-with   = prelude.zip-all-with
@zip-with       = prelude.zip-with

@contains 		= _.contains