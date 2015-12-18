Meteor.methods
  'deleteSingle': (targetId)->
    check targetId, String

    # targetImg = Images.findOne(targetId)
    # publicId = targetImg.publicId

    # if publicId isnt null
    #   Meteor.call "c.delete_by_public_id", publicId, (err, res)->
    #     if err
    #       console.log(error.reason)
    #     else
    #       console.log(result)
    #       deleteImage = Images.remove(targetId)


    # result = Images.remove(targetId)
    Stats.update
      statId: 'overall'
    ,
      $inc:
        'current.photo': -1
    result = Photos.update({_id: targetId}, {$set: {isDeleted: true}})

    return result

  'printCountInc': (targetId)->
    check targetId, String
    Stats.update
      statId: 'overall'
    ,
      $inc:
        'current.printed': 1
    inc = Photos.update({_id: targetId}, {$inc: {printCount: 1}})

    return inc