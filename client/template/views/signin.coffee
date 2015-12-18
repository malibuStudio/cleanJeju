Template.signin.events
  'submit #signin-form': (e)->
    e.preventDefault()

    btn = document.querySelector '.btn-signin'
    btn.classList.add 'loading'

    obj =
      user: $.trim($('[name=signin-user]').val())
      password: $.trim($('[name=signin-password]').val())

    Meteor.loginWithPassword obj.user, obj.password, (err, res) ->
      if err
        throwError T9n.get('error.accounts.' + err.reason)
        btn.classList.remove 'loading'
      else
        btn.classList.remove 'loading'
        Router.go('/')




