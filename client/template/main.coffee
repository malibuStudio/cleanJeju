launchIntoFullscreen = (element)->
  if element.requestFullscreen
    element.requestFullscreen()
  else if element.mozRequestFullScreen
    element.mozRequestFullScreen()
  else if element.webkitRequestFullscreen
    element.webkitRequestFullscreen()
  else if element.msRequestFullscreen
    element.msRequestFullscreen()

Template.layout.events

  'click a.event-item:not(.create-event)': (e)->


  'click [data-action=sidebar]': (e)->
    e.preventDefault()

    openSidebar = ()->
      sidebar = document.querySelector('.sidebar')

      TweenMax.to sidebar, 0.25,
        x: 0
        ease: Power4.easeIn
        onStart: ->
          overlay = '<div class="sidebar-overlay"></div>'
          sidebar.insertAdjacentHTML('afterend', overlay)

          added = document.querySelector('.sidebar-overlay')
          added.style.position = 'fixed'
          added.style.top = '0'
          added.style.left = '0'
          added.style.width = '100vw'
          added.style.height = '100vh'
          added.style.zIndex = '40'
          added.style.opacity = '0'
          added.style.background = 'transparent'

    openSidebar()

    return false
  'click .sidebar-overlay, click .sidebar-top a': (e)->
    sidebar = document.querySelector('.sidebar')

    TweenMax.to sidebar, 0.2,
      x: '-100%'
      clearProps: 'all'
      onStart: ->
        added = document.querySelector('.sidebar-overlay')
        added.parentNode.removeChild(added)

    return false

Template.body.onRendered ->
  googleAnalytics()
