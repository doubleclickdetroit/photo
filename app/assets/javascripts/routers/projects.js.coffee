define (require) ->
  Backbone = require 'backbone'
  App      = require 'crm'

  class App.Routers.Projects extends Backbone.Router
    routes:
      'projects':'index'
      'projects/:id':'show'
    index: ->
      alert 'at index'
    show: (id) ->
      alert "show action for id:#{id}"
