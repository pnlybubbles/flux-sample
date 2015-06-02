Emitter = require './event-emitter'

class Store extends Emitter
  constructor: (dispatcher) ->
    super()
    @count = 0
    dispatcher.on 'countUp', this.onCountUp.bind(this)

  getCount: -> @count
  onCountUp: (count) ->
    @count = count
    this.emit 'change'

module.exports = Store
