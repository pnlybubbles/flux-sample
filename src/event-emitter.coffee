class EventEmitter
  constructor: ->
    @_handlers = {}

  on: (type, handler) ->
    @_handlers[type] ||= []
    @_handlers[type].push handler

  emit: (type, data) ->
    for handler, i in @_handlers[type] ? []
      handler.call this, data

module.exports = EventEmitter
