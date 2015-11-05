Template.cropper.events
  'touchend #page-desc .back': (e)->
    e.preventDefault

    pageFromRight('#page-cropper')

  'touchend .btn-cropper-close': (e)->
    e.preventDefault()

    pageSlideDown('#page-list', ()->
      cropperImg = $('img.crop-target')
      cropperImg.cropper('destroy')
      cropperImg.attr('src', '')
      clearSessions('currentImg', 'croppedImg')
      console.log 'Cropper Destroyed'
    )
    Session.set('commentPhotoUpload', false)

  'touchend .btn-upload-cropped': (e)->
    pageFromLeft('#page-desc')

  'touchend .btn-upload-trash': (e)->
    e.preventDefault()

    $('.btn-upload-trash').addClass('loading')

    # Get Image
    croppedImg = $('img.crop-target').cropper('getCroppedCanvas', {width: 800, height: 800})
    Session.set('croppedImg', croppedImg.toDataURL())
    cropped = Session.get('croppedImg')

    # Get Desc
    desc = $.trim($('#page-desc textarea').val())
    desc = '향기로운 쓰레기님이 탄생하셨습니다' if desc.length is 0

    Cloudinary._upload_file cropped, {}, (err, res) ->
      if err
        # Show Error in console, then remove loading state
        console.log err
        $('.btn-upload-trash').removeClass('loading')
      else
        if Session.get('commentPhotoUpload') is true
          geoloc = Geolocation.currentLocation()
          obj =
            parentId: Session.get('commentParentId')
            imageUrl: res.url
            geo:
              coords:
                longitude: geoloc.coords.longitude
                latitude: geoloc.coords.latitude
              timestamp: geoloc.timestamp
            description: desc

          Meteor.call 'addComment', obj, (err, res)->
            if err
              console.log ':( ', err.reason
              $('.btn-upload-cropped').removeClass('loading')
              $('img.crop-target').cropper('enable')
            else
              console.log 'Yay!'
              # $('textarea.comment-text').val('')
              Session.set('commentPhotoUpload', false)
              $('.btn-upload-trash').removeClass('loading')
              $('.comments-input textarea').val('')
              pageSlideDown('#page-list', ()->
                cropperImg = $('img.crop-target')
                cropperImg.cropper('destroy')
                cropperImg.attr('src', '')
                clearSessions('currentImg', 'croppedImg')
                console.log 'Cropper Destroyed'
              )
        else
          console.log 'Cloudinary Complete: ', res
          geoloc = Geolocation.currentLocation()

          obj =
            description: desc
            url: res.url
            publicId: res.public_id
            geo:
              coords:
                longitude: geoloc.coords.longitude
                latitude: geoloc.coords.latitude
              timestamp: geoloc.timestamp
          Meteor.call 'addTrash', obj, (err, res)->
            if err
              console.log err.reason
              $('.btn-upload-trash').removeClass('loading')
            else
              $('.btn-upload-trash').removeClass('loading')
              pageSlideDown('#page-comments', ()->
                cropperImg = $('img.crop-target')
                cropperImg.cropper('destroy')
                cropperImg.attr('src', '')
                clearSessions('currentImg', 'croppedImg')
                console.log 'Cropper Destroyed'
              )
              Session.set('commentPhotoUpload', false)