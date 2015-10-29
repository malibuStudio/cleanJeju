Template.home.onCreated ->

Template.home.helpers

Template.home.events
  'touchend .p-tabbar-button': (e)->
    e.preventDefault()

    target = $(e.target).parent().attr('data-tab-target')

    if target is 'accounts'
      console.log 'Open accounts'
      pageFromBottom('#page-accounts')
    else
      $('.tab-view').removeClass('active')
      $("[data-tab-name=#{target}]").addClass('active')

  'change #upload-img input': (e)->
    # Show dimmer
    LOADER.show()

    e = e.originalEvent
    target = e.dataTransfer or e.target
    file = target and target.files and target.files[0]
    options =
      canvas: true
      maxWidth: 800

    if not file
      return
    else
      console.log 'File: ', file
      # if file.size > 4194304
      #   return false

      # Use the "JavaScript Load Image" functionality to parse the file data
      loadImage.parseMetaData file, (data) ->
        # Get the correct orientation setting from the EXIF Data
        if data.exif
          options.orientation = data.exif.get('Orientation')
          if data.exif.map
            console.log 'Exif.map: ',data.exif.map
          else
            console.log 'Location Data does not Exist'

        # Load the image from disk and inject it into the DOM with the correct orientation
        loadImage file, ((canvas) ->
          imgDataURL = canvas.toDataURL('img/jpg')

          Session.set('currentImg', imgDataURL)

          $('img.crop-target').attr(
            'src': Session.get('currentImg')
          )

          # $('.upload-container').css('display', 'block');
          # Meteor.setTimeout (->
          #   TweenMax.to '.upload-container', 0.5,
          #     opacity: 1
          #     y: 0
          # ), 500

          $('img.crop-target').imagesLoaded().done (instance)->
            console.log 'Image Done'
            Meteor.setTimeout (->
              $('img.crop-target').cropper
                aspectRatio: 1/1
                guides: false
                strict: true
                dragCrop: false
                cropBoxMovable: true
                cropBoxResizable: true
                responsive: true
                mouseWheelZoom: true
                built: ->
                  TweenMax.to '.malibu-crop-wrapper', 0.5,
                    opacity: 1
                    onComplete: ->
                      pageFromBottom('#page-cropper')
                      LOADER.destroy()
            ), 1000

        ), options




Template.home.onRendered ->
  # $('.p-body').on('scroll', ()->
  #   # console.log $('.trash-header').offset().top
  #   headerHeight = $('.p-header').height()

  #   if $('.trash-header').first().offset().top <= headerHeight

  #     # $('.trash-header').first().css(
  #     #   'position': 'fixed'
  #     #   'top' : headerHeight
  #     #   'left': 0
  #     #   'width': '100vw'
  #     # )

  #     $('.trash-header').first().addClass('c')

  #   if $('.trash-header').not('.c').first().offset().top <= (headerHeight + $('.trash-header.c').height())

  #     console.log (headerHeight + $('.trash-header.c').height())
  #     console.log $('.trash-header').not('.c').first().offset().top


  #     $('.trash-header').not('.c').first().addClass('c')
  #     $('.trash-header.c').first().removeClass('c')

  # )