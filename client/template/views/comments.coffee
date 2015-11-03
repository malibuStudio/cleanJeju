Template.comments.onCreated ->
  @comments = new Mongo.Collection null


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
  'touchend #page-comments .back': (e)->
    e.preventDefault()
    $('.p-header').removeClass('p-header-up')
    pageFromRight('#page-list')
    Session.set('commentParentId')

  'touchend .btn-add-description': (e)->
    e.preventDefault()
    if Meteor.userId()
      commentContent = $.trim($('.comments-input textarea').val())

      if commentContent.length is 0
        return false

      obj =
        parentId: Session.get('commentParentId')
        description: commentContent

      Meteor.call 'addComment', obj, (err, res)->
        if err
          console.log ':( ', err.reason
        else
          console.log 'Yay!'
          $('.comments-input textarea').val('')
          # .trigger('autosize').autosize()
    else
      console.log 'Sign in required'
