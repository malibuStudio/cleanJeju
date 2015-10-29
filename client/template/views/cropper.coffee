Template.cropper.events
  'touchend .btn-cropper-close': (e)->
    e.preventDefault()

    pageSlideDown('#page-list', ()->
      cropperImg = $('img.crop-target')
      cropperImg.cropper('destroy')
      cropperImg.attr('src', '')
      clearSessions('currentImg', 'croppedImg')
      console.log 'Cropper Destroyed'
    )



