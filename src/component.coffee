React = require 'react'
ActionCreator = require './action-creator'
Store = require './store'
Emitter = require './event-emitter'

dispatcher = new Emitter()
action = new ActionCreator(dispatcher)
store = new Store(dispatcher)

class Component extends React.Component
  constructor: (props) ->
    super props
    @state =
      count: store.getCount()
    console.log 'state', @state
    console.log 'component', this
    console.log 'store', store
    store.on 'change', =>
      console.log 'change', this
      this._onChange()

  _onChange: ->
    console.log store.getCount()
    this.setState
      count: store.getCount()

  tick: ->
    console.log 'state:tick', @state
    console.log 'component:tick', this
    action.countUp @state.count + 1

  render: ->
    <div>
      <h1>{ @state.count }</h1>
      <button onClick={ this.tick.bind(this) }>Count Up</button>
    </div>

module.exports = Component
