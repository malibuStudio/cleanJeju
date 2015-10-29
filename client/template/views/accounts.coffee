Template.accounts.events
  'touchend .p-header-button.back': (e)->
    e.preventDefault

    pageSlideDown('#page-list')