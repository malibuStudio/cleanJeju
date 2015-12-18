Template.dashboard.onCreated ->
  # 1. Set Page Name
  Session.set 'pageTitle', '대시보드'


Template.dashboard.onRendered ->
  chartOS = new Chartist.Pie '.chart-os',
    series: [10, 20, 50, 20, 5, 50, 15],
    labels: [1, 2, 3, 4, 5, 6, 7]
  ,
    donut: true


