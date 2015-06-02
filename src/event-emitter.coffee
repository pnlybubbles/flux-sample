class EventEmitter
  constructor: ->
    @_handlers = {}

  on: (type, handler) ->
    @_handlers[type] ||= []
    @_handlers[type].push handler
    console.log 'Emitter:on', this

  emit: (type, data) ->
    console.log 'Emitter:emit', this
    console.log 'emit', type, data
    for handler, i in @_handlers[type] ? []
      handler.call this, data

module.exports = EventEmitter
