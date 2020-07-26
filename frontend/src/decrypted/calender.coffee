import React, { Component } from 'react'
import moment from 'moment'
import DateRect from './dateRect'
import Event from './event'
import config from '../config'
import './calender.css'

class Calender extends Component
    constructor: (props) ->
        super props

    calculate_date_range: ->
        month = @props.month
        start_date = moment(month).date(1).day(0)
        end_date   = moment(month).add(1, 'months').date(1).subtract(1, 'days').day(6)
        dates = []
        date = start_date
        while date.isBefore end_date
            dates.push date
            date = moment(date).add(1, 'days')
        dates.push date
        dates

    fetch_event_data: (range) ->
        url = new URL config.server_path + "/event"
        url.searchParams.append 'start_date', range[0]
        url.searchParams.append 'end_date', range[range.length - 1]
        response = await fetch url.toString()
        json = await response.json()


    render: ->
        range = this.calculate_date_range()
        <div className='calender'>
            { range.map (date) => <DateRect date={date} valid={date.month() == @props.month.month()} /> }
        </div>

Calender.defaultProps = 
    month: moment()

export default Calender