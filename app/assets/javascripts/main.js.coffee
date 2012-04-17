require ['order!jquery','order!backbone','order!crm','order!routers/projects'], ($, Backbone, CRM) ->
  window.CRM = CRM
  console.log "#{CRM.name} \nVersion: #{CRM.version}"
  do CRM.initialize
