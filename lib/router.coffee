Router.configure
  layoutTemplate: 'layout'

Router.route '/',
  name: 'dashboard'

Router.route '/events',
  name: 'eventsList'

Router.route '/events/photos',
  name: 'photoList'






Router.route '/signin',
  name: 'signin'
  layoutTemplate: 'accountsLayout'

Router.route '/register',
  name: 'register'
  layoutTemplate: 'accountsLayout'

# Router.onAfterAction ()->

onBeforeActions =
  loginRequired: ()->
    if not Meteor.userId()
      @layout 'accountsLayout'
      @render 'signin'
      console.log 'Sign-in Required'
    else
      @next()
Router.onBeforeAction onBeforeActions.loginRequired,
  except: ['register', 'signin']
