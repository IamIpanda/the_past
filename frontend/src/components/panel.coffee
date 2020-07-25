import React, { Component } from 'react';
import 'antd/dist/antd.css';
import Calender from './calender'

class RightPanel extends Component
    constructor: (props) ->
        super props
        @state = 
            fields: []

    refreshCalender: (fields) ->
        @refs.calender.fetchColors()
        @refs.calender.onPanelChange @refs.calender.state.date, 'month' 
        @setState { fields } if fields

    render: ->
        <Calender ref="calender" fields={@state.fields} />


export default RightPanel