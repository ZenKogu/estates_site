$ ->
  $form = $ \#search_tools   ### Materials page. Left column tools checkbox engine ###

  $form.on \click, \.steps, (e) ->
    e.preventDefault!
    $clicked = $(e.target)
    $parent  = $clicked.parent!
    if $clicked.hasClass \steps  or !$parent.hasClass \content
      $(this).toggleClass 'open'
    else
      $input = $(\# + $clicked.attr(\for))
      res = !$input.prop \checked
      $input.prop \checked, res
      $parent.parent!find('> input').prop \checked, ! !$parent.find('> input:checked').length
    
  $form.on \click, '.radiogroup label', (e)->  ### Materials page. Left column tools radio engine ###
    e.preventDefault!
    $ '.radiogroup input[type="radio"]' .prop 'checked', false
    $ \# + $(e.target).attr \for .prop \checked, true
    $ '.daterange input' .val ''
    
  $form.on \change, '.daterange input', (e)-> 
  	if e.target.value.length => $ '.radiogroup input[type="radio"]' .prop \checked, false
   
  $ \input.date .datepicker!
  $ \.article__tools__tree .on \click, \li, (e)->
    e.stopImmediatePropagation!
    $clicked = $ e.target
    $clicked.parent!toggleClass 'open'
    
  videoControls =  ### -----------Video------------- ###
    parent:    $ \.video
    video:     $ '.video video:first'
    playpause: $ \.video__playpause
    togglePlayback:-> if video.paused => video.play! else video.pause!
      
  video = videoControls.video[0]
  videoControls.playpause.click ->
    if video.paused then video.play!
    else video.pause!; videoControls.parent.toggleClass \paused
    
  videoControls.video.click -> videoControls.togglePlayback!
    
  video.addEventListener \ended, -> video.pause!; videoControls.parent.toggleClass \paused  
  video.addEventListener \play,  -> videoControls.parent.toggleClass \paused    
  video.addEventListener \pause, -> videoControls.parent.toggleClass \paused
    
  