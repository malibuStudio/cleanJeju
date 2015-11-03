Template.body.onCreated ->
  console.log 'CLEAN JEJU Initialized'
  #  @pageIndex = new ReactiveVar 1
  navigator.geolocation.getCurrentPosition (loc)=>
    Session.set 'location',
      coords:
        latitude: loc.coords.latitude
        longitude: loc.coords.longitude
  @touchstart =
    x: 0
    y: 0
  @comments = new Mongo.Collection null
  @autorun =>
    loc = Session.get 'location'
    if loc?
      @locationSubs and @locationSubs.stop()
      @locationSubs = @subscribe 'getTrashLocations', [
        loc.coords.longitude,
        loc.coords.latitude
      ]


Template.body.events



Template.body.onRendered ->
  if platform.os.family is 'iOS' and (parseInt(platform.os.version, 10) >= 8)
    console.log platform.os.version

  scrollHide()

  $(document).on 'keydown', (e)->
    key = e.keyCode or e.which
    # Disable Tab Index (9)
    if key in [9]
      e.preventDefault()
      return false
