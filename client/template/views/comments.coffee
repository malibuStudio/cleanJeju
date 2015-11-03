Template.comments.helpers
  comments: ->
    t = Template.instance()
    trashId = Session.get('commentParentId')
    if trashId?
      t.comments.remove {}
      trash = Trashes.findOne(trashId)
      if trash and trash.comments
        t.comments.insert comment for comment in trash.comments
      t.comments.find {},
        sort:
          createdAt: -1

Template.comments.events
  'touchend .back': (e)->
    e.preventDefault()

    pageFromRight('#page-list')