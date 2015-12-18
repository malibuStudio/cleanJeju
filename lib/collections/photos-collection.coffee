# @Photos = new Mongo.Collection 'photos'

# # @Schemas = {}

# # @Schemas.Photos = new SimpleSchema
# #   'createdAt':
# #     type: Date
# #     denyUpdate: true
# #     autoValue: ->
# #       if @isInsert
# #         new Date
# #   'printCount':
# #     type: Number
# #     optional: true
# #   'data':
# #     type: Object
# #   'data.ua':
# #     type: Object
# #   'data.image':
# #     type: Object
# #   'data.image.filesize':
# #     type: Number
# #   'data.image.orginalWidth':
# #     type: Number
# #   'data.image.originalHeight':
# #     type: Number

# # Photos.attachSchema Schemas.Photos