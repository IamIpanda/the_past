import React, { Component } from 'react';
import 'antd/dist/antd.css';
import Calender from './calender'

class RightPanel extends Component
    constructor: (props) ->
        super props

    refreshCalender: ->
        @refs.calender.fetchColors()
        @refs.calender.onPanelChange @refs.calender.state.date, 'month' 

    render: ->
        <Calender ref="calender" />


export default RightPanel