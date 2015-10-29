Template.accounts.events
  'touchend .p-header-button.back': (e)->
    e.preventDefault()

    pageSlideDown('#page-list')

    return false

  'touchend #signin p a': (e)->
    e.preventDefault()

    $('#signin').hide()
    $('#register').show()
    $('.p-header-button.back').removeClass('back').addClass('back-signin')

    return false

  'touchend #register p a, touchend .p-header-button.back-signin': (e)->
    e.preventDefault()

    $('#register').hide()
    $('#signin').show()
    $('.p-header-button.back-signin').addClass('back').removeClass('back-signin')

    return false

  'submit form#form-signin': (e)->
    e.preventDefault()

    $('button.btn-signin').addClass('loading')

    obj =
      user: $.trim($('[name=signin-user]').val())
      password: $.trim($('[name=signin-password]').val())

    Meteor.loginWithPassword obj.user, obj.password, (err, res) ->
      if err
        # throwError err.reason
        $('button.btn-signin').removeClass('loading')
      else
        $('button.btn-signin').removeClass('loading')
        pageSlideDown('#page-list')

  'submit form#form-register': (e, t)->
    e.preventDefault()
    $('button.btn-register').addClass('loading')
    obj =
      username: $.trim($('[name=register-username]').val())
      email: $.trim($('[name=register-email]').val())
      password: $.trim($('[name=register-password]').val())

    Accounts.createUser obj, (err, result) ->
      if err
        $('button.btn-register').removeClass('loading')
        console.log err.reason
      else
        $('button.btn-register').removeClass('loading')
        modal = document.getElementById('modal-account')
        pageSlideDown('#page-list')
