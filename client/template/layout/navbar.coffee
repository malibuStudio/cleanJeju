Template.navbar.helpers
  pageTitle: ->
    Session.get 'pageTitle'

Template.navbar.events
  'click [data-action=settings]': (e)->
    e.preventDefault()

    settings = $('.settings-container')
    settingsBody = $('.settings-body')

    settings.css('display', 'block').addClass('show')

    settings.one constants.transitionEnd, (e)->
      console.log 'Done'
      settingsBody.css('display', 'block')
      settingsBody.addClass('show')

Template.navbar.onRendered ->