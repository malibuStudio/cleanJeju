Meteor.startup ->
  # set Locale
  moment.locale _.last navigator.languages

  mo.configure
    formatTokens:
      'shortDate': 'MM'+'/'+'DD'+'/'+'YY', # 3 Jan 15
      'longDate': 'Do [of] MMMM[,] YYYY', # 3rd of January, 2015