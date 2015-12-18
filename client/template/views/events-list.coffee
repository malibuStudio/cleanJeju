Template.eventsList.onCreated ->
  # 1. Set Page Name
  Session.set 'pageTitle', '이벤트 목록'

  # ======================================================================
  # Reactive Vars
  # ======================================================================
  instance = this
  instance.limit = new ReactiveVar 10
  instance.loaded = new ReactiveVar 0

  # ======================================================================
  # Autorun
  # ======================================================================
  instance.autorun ->
    limit = instance.limit.get()

    # filter =
    #   'user._id': Meteor.userId()

    options =
      limit: limit
      sort:
        createdAt: -1

    subscription = Meteor.subscribe('eventsList', options)

    # Sub Ready? Sub Waiting?
    if subscription.ready()
      instance.loaded.set(limit)
      console.log '//----Sub Ready----//'
      console.log 'subscription: eventsList'
      console.log 'limit:', limit
      console.log 'loaded:', instance.loaded.get()
    else
      console.log '//----Sub Waiting----//'
      console.log 'subscription: eventsList'

  # ======================================================================
  # Cursors
  # ======================================================================
  options =
    limit: instance.loaded.get()
    sort:
      createdAt: -1

  instance.eventItem = ->
    return Events.find {'user._id': Meteor.userId()}, options

Template.eventsList.helpers
  eventItem: ->
    return Template.instance().eventItem()

Template.eventsList.events
  'click .create-event': (e)->
    e.preventDefault()
    MODAL('create-event-modal')


Template.eventsList.onRendered ->