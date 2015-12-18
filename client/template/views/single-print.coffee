Template.singlePrint.onCreated ->
  # # ======================================================================
  # # Reactive Vars
  # # ======================================================================
  # instance = @

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

  # instance.singlePrint = ->
  #   return Photos.findOne(Session.get('modalId'))

Template.singlePrint.helpers
  # singlePrint: ->
  #   return Template.instance().singlePrint()
  # url: ->
  #   if @orientation is 'portrait'
  #     return @url
  #   else
  #     l = $.cloudinary.url(@publicId, {
  #       transformation: [
  #         {angle: 90},
  #         {format: 'auto'},
  #         {quality: 1}
  #         ]
  #     })
  #     return l

Template.singlePrint.events
