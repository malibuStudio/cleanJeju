@Photos = new Mongo.Collection('photos')

@PhotosIndex = new EasySearch.Index
  collection: Photos
  fields: ['ticket']
  engine: new EasySearch.Minimongo()
  # limit: 3

