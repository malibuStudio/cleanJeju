Template.photoList.onCreated ->
  # 1. Set Page Name
  Session.set 'pageTitle', 'EccoNight'

Template.photoList.onRendered ->
  $('img').each ->
    img = $(this)
    img.imagesLoaded ()=>
      TweenMax.to $(this), 1,
        opacity: '1'
