Template.trashList.helpers
  Trashes: ->
    # t = Template.instance()
    # idx = t.pageIndex.get()
    # debugger
    Trashes.find {},
      sort:
        createdAt: -1
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