Template.body.onCreated ->
  console.log 'CLEAN JEJU Initialized'
  #  @pageIndex = new ReactiveVar 1
  navigator.geolocation.getCurrentPosition (loc)=>
    @locationSubs and @locationSubs.stop()
    @locationSubs = @subscribe 'getTrashLocations', [
      loc.coords.longitude,
      loc.coords.latitude
    ]
  @touchstart =
    x: 0
    y: 0
  @comments = new Mongo.Collection null


Template.body.events
  # 'click .blue button.transition': (e)->
  #   pageFromLeft('.yellow')

  # 'click .yellow button.transition': (e)->
  #   pageFromRight('.pink')

  # 'click .pink button.transition': (e)->
  #   pageFromTop('.green')

  # 'click .green button.transition': (e)->
  #   pageFromBottom('.blue')



Template.body.onRendered ->
  if platform.os.family is 'iOS' and (parseInt(platform.os.version, 10) >= 8)
    console.log platform.os.version

  scrollHide()



