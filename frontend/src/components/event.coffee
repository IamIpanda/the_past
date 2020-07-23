import React, { Component } from 'react'
import './event.css'

class Event extends Component
    constructor: (props) ->
        super props

    render: ->
        <div className='event' style={{ 'background-color': this.props.color }} onDoubleClick={this.props.onDoubleClick}>
            {@props.event}
        </div>

Event.defaultProps = 
    color: '#CCCCCC'
    onDoubleClick: undefined

export default Event;