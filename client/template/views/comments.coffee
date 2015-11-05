Template.comments.onCreated ->
  @comments = new Mongo.Collection null


Template.comments.helpers
  comments: ->
    t = Template.instance()
    trashId = Session.get('commentParentId')
    if trashId?
      t.comments.remove {}
      trash = Trashes.findOne(trashId)
      if trash and trash.comments
        t.comments.insert comment for comment in trash.comments
      t.comments.find {},
        sort:
          createdAt: -1

Template.comments.events
  'touchend #page-comments .back': (e)->
    e.preventDefault()
    $('.p-header').removeClass('p-header-up')
    pageFromRight('#page-list')
    Session.set('commentParentId')

  'touchend .btn-add-description': (e)->
    e.preventDefault()
    if Meteor.userId()
      commentContent = $.trim($('.comments-input textarea').val())

      if commentContent.length is 0
        return false

      obj =
        parentId: Session.get('commentParentId')
        description: commentContent

      Meteor.call 'addComment', obj, (err, res)->
        if err
          console.log ':( ', err.reason
        else
          console.log 'Yay!'
          $('.comments-input textarea').val('').trigger('autosize').autosize()
    else
      pageFromBottom('#page-accounts')

  'change #upload-comment-img': (e)->
    Session.set('commentPhotoUpload', true)

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
                      $('#page-desc textarea').val($('.comments-input textarea').val())
            ), 1000

        ), options


Template.comments.onRendered ->
  $('.comments-input textarea').autosize()