Template.photoListModal.onCreated ->
  # ======================================================================
  # Reactive Vars
  # ======================================================================
  instance = @

  # # ======================================================================
  # # Autorun
  # # ======================================================================
  # instance.autorun ->
  #   # ====================================================================
  #   # Subscription
  #   # ====================================================================
  #   filter =
  #     _id: Session.get('modalId')

  #   subscription = instance.subscribe('singlePhoto', filter)
  #   if filter._id? and filter._id.length isnt 0 and subscription.ready()
  #     console.log '//----Sub Ready----//'
  #     console.log 'subscription: singlePhoto'
  #   else
  #     console.log '//----Sub Waiting----//'
  #     console.log 'subscription: singlePhoto'

  # filter =
  #     _id: Session.get('modalId')

  instance.singlePhoto = ->
    return Photos.findOne(Session.get('modalId'))

Template.photoListModal.helpers
  singlePhoto: ->
    return Template.instance().singlePhoto()
  ticket: ->
    if @ and @ticket
      str = "" + @ticket
      pad = "0000"
      ans = '#' + pad.substring(0, pad.length - str.length) + str
      return ans
  url: ->
    if @orientation is 'portrait'
      return @url
    else
      l = $.cloudinary.url(@publicId, {
        transformation: [
          {angle: 90},
          {format: 'auto'},
          {quality: 1}
          ]
      })
      return l

Template.photoListModal.events
  'click .modal-overlay': ->
    Session.set('modalId')

    if $('#photo-item-modal').hasClass('delete-mode')
      actions = $('#photo-item-modal .actions')
      $('#photo-item-modal').removeClass('delete-mode')
      TweenMax.to actions, 0.1,
        opacity: 1
        display: 'flex'
        clearProps: 'all'
      TweenMax.to '.delete-message', 0.1,
        opacity: 0
        display: 'none'

  'click [data-action=print]': ->
    targetId = @_id
    $('.single-print img').imagesLoaded().done (instance)->
      Meteor.call 'printCountInc', targetId,  (err, res)->
        if err
          console.log err
        else
          console.log 'incremented printCount by 1'
      # Show Print dialog on load
      window.print()

      # After dialog is closed
      # Close GSAP
      TweenMax.to '#photo-item-modal', 0.3,
        scale: 1.1
        opacity: 0
        display: 'none'
        clearProps: 'all'

      # Close Modal Overlay GSAP
      # if $('.modal-overlay').length isnt 0
      TweenMax.to '.modal-overlay', 0.3,
        opacity: 0,
        clearProps: 'all'
        onComplete: ->
          $('.modal-overlay').remove()

  'click [data-action=remove]': (e)->
    e.preventDefault()

    actions = $('#photo-item-modal .actions')

    TweenMax.to actions, 0.3,
      opacity: 0
      display: 'none'
      onStart: ()->
        $('#photo-item-modal').addClass('delete-mode')


    TweenMax.fromTo '.delete-message', 0.3,
      opacity: 0
      display: 'flex'
    ,
      opacity: 1

  'click [data-action=delete-cancel]': ()->
    if $('#photo-item-modal').hasClass('delete-mode')
      actions = $('#photo-item-modal .actions')
      $('#photo-item-modal').removeClass('delete-mode')
      TweenMax.to actions, 0.3,
        opacity: 1
        display: 'flex'
        clearProps: 'all'
      TweenMax.to '.delete-message', 0.3,
        opacity: 0
        display: 'none'

  'click [data-action=delete-confirm]': ()->
      Meteor.call 'deleteSingle', @_id, (error, result)->
        if error
          console.log('deleteSingle error')
          console.log('> ' + error.reason)
        else
          console.log('deleteSingle success')
          Session.set('modalId')
          if $('#photo-item-modal').hasClass('delete-mode')
            actions = $('#photo-item-modal .actions')
            $('#photo-item-modal').removeClass('delete-mode')
            TweenMax.to actions, 0.1,
              opacity: 1
              display: 'flex'
              clearProps: 'all'
            TweenMax.to '.delete-message', 0.1,
              opacity: 0
              display: 'none'
            # Close GSAP
            TweenMax.to '#photo-item-modal', 0.3,
              scale: 1.1
              opacity: 0
              display: 'none'
              clearProps: 'all'

            # Close Modal Overlay GSAP
            # if $('.modal-overlay').length isnt 0
            TweenMax.to '.modal-overlay', 0.3,
              opacity: 0,
              clearProps: 'all'
              onComplete: ->
                $('.modal-overlay').remove()


