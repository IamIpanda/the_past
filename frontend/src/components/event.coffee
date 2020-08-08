import React, { Component } from 'react'
import { Popover } from 'antd'
import './event.css'

class Event extends Component
    constructor: (props) ->
        super props

    render: ->
        <div className='event' style={{ 'background-color': this.props.color }} onDoubleClick={this.props.onDoubleClick}>
            {
                if @props.event.note
                    <Popover placement='top' trigger='hover' content={@props.event.note}>
                        {@props.event.field}
                    </Popover>
                else
                    <div>{@props.event.field}</div>
            }
        </div>

Event.defaultProps = 
    color: '#CCCCCC'
    onDoubleClick: undefined

export default Event;