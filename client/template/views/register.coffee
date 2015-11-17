Template.register.events
  'submit form#register-form': (e)->
    e.preventDefault()

    btn = document.querySelector '.btn-register'
    btn.classList.add 'loading'

    obj =
      username: $.trim($('[name=register-username]').val())
      email:    $.trim($('[name=register-email]').val())
      password: $.trim($('[name=register-password]').val())
      roles: ['user']

    Meteor.call 'register', obj, (err, res)->
      if err
        console.log err.reason
        btn.classList.remove 'loading'
      else
        Meteor.loginWithPassword res.username, res.password, (err, result) ->
          if err
            console.log err.reason
            btn.classList.remove 'loading'
          else
            btn.classList.remove 'loading'
            Router.go('/')


Template.register.onRendered ->
  # form = $('#register-form')

  # TweenMax.fromTo form, 0.25,
  #   opacity: 0
  #   x: '-100%'
  # ,
  #   opacity: 1
  #   x: '-50%'