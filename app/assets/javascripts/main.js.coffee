require ['order!jquery','order!backbone','order!crm','order!routers/projects'], ($, Backbone, App) ->
  window.App = App
  console.log "#{App.name} \nVersion: #{App.version}"
  do App.initialize
