###
  # CLIENT
  obj =
    username: String
    email: String
    password: String
    roles: Array

  Meteor.call 'register' obj (err, res)->
    if err

    else


  obj =
    username: String
    email: String
    password: String
###

Meteor.methods
  'register': (obj) ->
    check obj.username, String
    check obj.email, String
    check obj.password, String
    check obj.roles, Array

    if obj.username.length > 16
      throw new Meteor.Error 404, '아이디는 16자 이하여야 합니다'

    if obj.username.length < 6
      throw new Meteor.Error 404, '아이디는 6자 이상이어야 합니다'

    if obj.password.length > 16
      throw new Meteor.Error 404, '비밀번호는 16자 이하여야 합니다'

    if obj.password.length < 6
      throw new Meteor.Error 404, '비밀번호는 6자 이상이어야 합니다'

    user = Accounts.createUser(obj)

    if obj.roles.length > 0
      Roles.addUsersToRoles(user, obj.roles)

    return obj;

