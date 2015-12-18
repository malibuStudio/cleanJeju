Template.layout.helpers
  bgColor: ->
    if Router.current().route.getName() in ['eventsList']
      return 'gray'

Template.layout.onRendered ->
