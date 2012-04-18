define ['backbone'], (Backbone) ->
  App = {
    Models: {}
    Collections: {}
    Views: {}
    Routers: {}
    name: "Timeline CRM"
    version: "0.1.dev"
  }

  App.initialize = ->
    # do Router.initialize
    new App.Routers.Projects()
    Backbone.history.start()

  App
