# Meteor.publish 'photoList', (filter, options)->
#   check filter, Object
#   check options, Object
#   Counts.publish(this, 'photoListCount', Photos.find(filter), { noReady: true })
#   photos = Photos.find(filter, options)
#   return photos

# # Meteor.publish 'singlePhoto', (filter)->
# #   singlePhoto = Photos.find(filter)
# #   return singlePhoto