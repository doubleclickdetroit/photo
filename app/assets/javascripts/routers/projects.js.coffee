define (require) ->
  Backbone = require 'backbone'
  CRM      = require 'crm'

  class CRM.Routers.Projects extends Backbone.Router
    routes:
      'projects':'index'
      'projects/:id':'show'
    index: ->
      alert 'at index'
    show: (id) ->
      alert "show action for id:#{id}"
