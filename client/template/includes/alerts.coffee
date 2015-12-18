# Local (client-only) collection
Alerts = new (Mongo.Collection)(null)

################################

@throwSuccess = (message) ->
  id = Alerts.insert
    message: message
    success: true
  alert = $('#' + id)
  TweenMax.to alert, 0.15,
    ease: Power3.easeOut
    opacity: 1
    x: '0%'
    onComplete: ()->
      alert.addClass('show')

@throwError = (message) ->
  id = Alerts.insert
    message: message
    error: true

  alert = $('#' + id)
  TweenMax.to alert, 0.15,
    ease: Power3.easeOut
    opacity: 1
    x: '0%'
    onComplete: ()->
      alert.addClass('show')



################################

Template.alerts.helpers
  alerts: ->
    Alerts.find()

Template.alert.events
  # 'click .alert-close': (e, t) ->
  #   $('#' + @_id).removeClass 'alert-show'
  #   $('#' + @_id).addClass 'alert-hide'
  #   # setTimeout (=>
  #   #   Alerts.remove @_id
  #   # ), 300

Template.alert.onRendered ->
  alert = @data

  target = $('#' + alert._id)

  TweenMax.to target, 0.15,
    delay: 5
    opacity: 0
    scale: 1.25
    onComplete: ()->
      target.remove()
      Alerts.remove alert._id


  # ), 5000


