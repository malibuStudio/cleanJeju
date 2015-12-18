Template.photoList.onDestroyed ->
  Session.set('query', '')

Template.photoList.onCreated ->
  # 1. Set Page Name
  Session.set 'pageTitle', '로딩중..'


  # ======================================================================
  # Reactive Vars
  # ======================================================================
  instance = @
  # instance.query = new ReactiveVar ''
  Session.set('query', '')
  instance.limit = new ReactiveVar 15
  instance.loaded = new ReactiveVar 0

  # ======================================================================
  # Autorun
  # ======================================================================
  instance.autorun ->
    # query = instance.query.get()
    query = Session.get('query')
    limit = instance.limit.get()

    if query.length isnt 0
      filter =
        ticket: parseInt(query)
        isDeleted: false
    else
      filter =
        isDeleted: false

    options =
      limit: limit
      sort:
        ticket: -1
      fields:
        _id: 1
        publicId: 1
        url: 1
        orientation: 1
        luckyDraw: 1
        isDeleted: 1
        ticket: 1
        printCount: 1

    # ====================================================================
    # Subscription
    # ====================================================================
    subscription = instance.subscribe('photoList', filter, options)
    if subscription.ready()
      instance.loaded.set(limit)
      console.log '//----Sub Ready----//'
      console.log 'subscription: photoList'
      console.log 'limit:', limit
      console.log 'loaded:', instance.loaded.get()
      console.log 'query:', query

      Session.set 'pageTitle', '사진목록'
      # $('img.i').each ->
      #   img = $(this)
      #   img.imagesLoaded ()=>
      #     TweenMax.to $(this), 1,
      #       opacity: '1'
    else
      console.log '//----Sub Waiting----//'
      console.log 'subscription: photoList'


  query = Session.get('query')
  if query.length isnt 0
      filter =
        ticket: parseInt(query)
        isDeleted: false
    else
      filter =
        isDeleted: false

  options =
    limit: instance.loaded.get()
    sort:
      ticket: -1

  instance.photoItem = ->
    Photos.find({}, options)




Template.photoList.helpers
  photoItem: ->
    return Template.instance().photoItem()
  hasMore: ()->
    return Counts.get('photoListCount') > Template.instance().limit.get()
  noSearchResult: ()->
    # return Counts.get('photoListCount') is 0 and Template.instance().query.get().length > 0
    return Counts.get('photoListCount') is 0 and Session.get('query').length > 0

  searchingDone: ()->
    Template.instance().subscriptionsReady()
    # if Template.instance().subscriptionsReady()
      # Meteor.setTimeout ->
      #   return true
      # , 500
  printed: ()->
    return @printCount > 0
  loadingClass: ()->
    if not Template.instance().subscriptionsReady()
      return 'loading'
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
  ticket: ->
    if @ and @ticket
      str = "" + @ticket
      pad = "0000"
      ans = pad.substring(0, pad.length - str.length) + str
      return ans

Template.photoList.events
  # https://stackoverflow.com/questions/19204993/how-do-i-do-a-parameter-based-publication-in-meteor-and-remove-old-subscription
  'keyup input#search ': _.debounce(((e, t)->
      e.preventDefault()
      val = $(e.currentTarget).val()
      Session.set('query', val)
      if val.length > 0
        newHandler = t.photoItem()
        if handler
          handler.stop();

        handler = newHandler
    ), 300)
      # e.preventDefault()
      # val = $(e.currentTarget).val()
      # console.log val
      # Template.instance().query.set(val)


  'click .photo-item:not(.load-more)': (e)->
    Session.set('modalId', @_id)
    console.log @_id
    MODAL('photo-item-modal')

  'click .load-more': (e, t)->
    e.preventDefault()

    # get current value for limit, i.e. how many posts are currently displayed
    limit = Template.instance().limit.get()

    # increase limit by 10 and update it
    limit += 1
    Template.instance().limit.set(limit)

  'click [data-action=delete-image]': (e)->
    e.preventDefault()

    TweenMax.to '.action-wrapper', 0.3,
      display: 'none'
      opacity: 0
    TweenMax.to '.delete-message', 0.3,
      display: 'flex'
      opacity: 1

  'click button.close': (e)->
    e.preventDefault()

    settings = $('.settings-container')
    settingsBody = $('.settings-body')

    settings.removeClass('show')
    # settings.one constants.transitionEnd, ->
    settingsBody.removeClass('show')
    settingsBody.css('style', '')


Template.photoList.onRendered ->
  $('input#search').on 'focus', (e)->
    $(e.currentTarget).parent().addClass('input-on')
  $('input#search').on 'blur', (e)->
    target = $(e.currentTarget)
    if target.val().length is 0
      target.parent().removeClass('input-on')
