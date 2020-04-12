import React, { Component } from 'react'
import './event.css'

class Event extends Component
    constructor: (props) ->
        super props

    render: ->
        <div className='event' style={{ 'background-color': this.props.color }}>
            {@props.event}
        </div>

Event.defaultProps = 
    color: '#CCCCCC'

export default Event;