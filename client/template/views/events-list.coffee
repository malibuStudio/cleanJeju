Template.eventsList.onCreated ->
  # 1. Set Page Name
  Session.set 'pageTitle', '이벤트 목록'

Template.eventsList.events


Template.eventsList.onRendered ->