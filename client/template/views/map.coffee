$(window).resize( ->
  h = $(window).height()
  offsetTop = 0
  $mc = $("#map")
  $mc.css 'height', h- offsetTop
).resize()

@MapObject=
  longitude: 126.54
  latitude: 33.398633

Template.map.helpers
  'trashes': (e, tmpl)->
    t = Template.instance()
    maxDensity = 0
    # go reactive
    trashes = Trashes.find().map (v)-> v.geometry.coordinates
    unless trashes.length
      return []
    
    for feature in jejuMap.features
      density = 0
      for trash in trashes
        GeoJSON.pointInPolygon(
          'type': 'Point'
          'coordinates': trash
        ,
          'type': 'Polygon'
          'coordinates': feature.geometry.coordinates
        ) and density++

      feature.properties.density = density
      maxDensity = maxDensity < density and density or maxDensity

    not MapObject.map and MapObject.map = L.map('map',
      minZoom: 9
      maxZoom: 9
      dragging: false
      boxZoom: false
      touchZoom: false
      scrollWheelZoom: false
      zoomControl: false
      attributionControl: false
    ).setView [
      MapObject.latitude, MapObject.longitude
    ], 9

    getColor = (d)->
      d = d / maxDensity * 8
      d > 7 and '#800026' or
      d > 6 and '#BD0026' or
      d > 5 and '#E31A1C' or
      d > 4 and '#FC4E2A' or
      d > 3 and '#FD8D3C' or
      d > 2 and '#FEB24C' or
      d > 1 and '#FED976' or
      '#FFEDA0'

    getStyle = (feature)->
      fillColor: getColor feature.properties.density
      weight: 2
      opacity: 0.7
      color: 'purple'
      dashArray: '3'
      fillOpacity: 0.7
    MapObject.layer and MapObject.layer.clearLayers()
#    Meteor.setTimeout ->
    MapObject.layer=L.geoJson(jejuMap, style: getStyle).addTo(MapObject.map)
#   , 2000

    jejuMap.features.sort (a,b)->
      a.properties.density > b.properties.density and -1 or
      a.properties.density is b.properties.density and 0 or
      a.properties.density < b.properties.density and 1


Template.map.onRendered ->
