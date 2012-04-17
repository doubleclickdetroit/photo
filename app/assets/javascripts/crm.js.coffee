define ['backbone'], (Backbone) ->
  CRM = {
    Models: {}
    Collections: {}
    Views: {}
    Routers: {}
    name: "DoubleClick Detroit CRM"
    version: "0.1.dev"
  }

  CRM.initialize = ->
    # do Router.initialize
    new CRM.Routers.Projects()
    Backbone.history.start()

  CRM
