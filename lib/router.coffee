Router.configure
  layoutTemplate: 'layout'

Router.route '/',
  name: 'dashboard'

# Router.route '/events',
  # name: 'eventsList'
  # yieldRegions:
    # 'eventsListModal': to: 'modal'

Router.route '/photo-list',
  name: 'photoList'
  yieldRegions:
    'photoListModal': to: 'modal'





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

  # fadeIn: ()->
  #   TweenMax.fromTo '.content-body', 0.35,
  #     opacity: 0
  #   ,
  #     opacity: 1
  #   @next()


Router.onBeforeAction onBeforeActions.loginRequired,
  except: ['register', 'signin']
# Router.onBeforeAction onBeforeActions.fadeIn

