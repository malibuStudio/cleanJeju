Meteor.startup ->
  # set Locale
  moment.locale('kr');

  # initialize geolocation coords
  Geolocation.currentLocation()