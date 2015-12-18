Template.eventsListModal.events
  'click .btn-create-event': (e, t)->
    e.preventDefault()

    # Disable Button
    t.$('.btn-create-event').addClass 'loading'

    # Input Value of Event Name
    eventName = $.trim($('[name=event-name]').val())

    # Call Method - createEvent
    Meteor.call 'createEvent', eventName, (err, res)->
      if err
        # if error, throwError and Enable Button
        throwError err.reason
        t.$('.btn-create-event').removeClass 'loading'
      else
        # if Success, remove modal, throwSuccess, Clear Input and Enable Button
        throwSuccess eventName + '가 성공적으로 생성됐습니다.'
        $('[name=event-name]').val('')
        t.$('.btn-create-event').removeClass 'loading'
        closeD = 0.23
        # Close GSAP
        TweenMax.to '#create-event-modal', closeD,
          scale: 1.1
          opacity: 0
          display: 'none'
          clearProps: 'all'

        # Close Modal Overlay GSAP
        TweenMax.to '.modal-overlay', closeD,
          opacity: 0,
          clearProps: 'all'
          onComplete: ->
            $('.modal-overlay').remove()