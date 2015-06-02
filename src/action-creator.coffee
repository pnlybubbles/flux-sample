class ActionCreator
  constructor: (dispatcher) ->
    @dispatcher = dispatcher

  countUp: (data) ->
    @dispatcher.emit 'countUp', data

module.exports = ActionCreator
