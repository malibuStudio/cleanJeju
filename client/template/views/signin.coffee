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
        console.log err.reason
        btn.classList.remove 'loading'
      else
        btn.classList.remove 'loading'
        Router.go('/')