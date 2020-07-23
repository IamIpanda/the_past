import React, { Component } from 'react'
import './dateRect.css'

class DateRect extends Component
    constructor: (props) ->
        super props

    render: ->
        className = "date-number";
        className += " invalid" unless @props.valid
        <div className="date-rect">
            <span className={className}>
                { @props.date.date() }
            </span>
            { @props.children }
        </div>

export default DateRect