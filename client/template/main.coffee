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