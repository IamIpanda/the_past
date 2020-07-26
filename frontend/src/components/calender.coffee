import React, { Component } from 'react'
import { Calendar } from 'antd'
import Event from './event'
import EventModal from './modal_event'
config = require '../config'

import moment from 'moment';
import 'moment/locale/zh-cn';
moment.locale('zh-cn')
 
class Calender extends Component
    constructor: (props) ->
        super props
        @state = 
            events: {}
            colors: {}
            showModal: false
            date: moment()

    componentDidMount: ->
        @fetchColors()
        @onPanelChange moment(), 'month'

    fetchColors: ->
        url = config.server_path + "/list/"
        response = await fetch url
        fields = await response.json()
        colors = {}
        colors[field.name] = field.color for field from fields
        @setState
            colors: colors

    fetchEventData: (start_date, end_date) ->
        searchParams = new URLSearchParams()
        searchParams.append 'start_date', start_date
        searchParams.append 'end_date',   end_date
        url = config.server_path + "/event?" + searchParams.toString();
        response = await fetch url.toString()
        json = await response.json()
        events = {}
        for data from json
            date = moment(data.date).format 'YYYY-MM-DD'
            events[date] = [] unless events[date]
            events[date].push data
        @setState 
            events: events
    
    onPanelChange: (date, mode) ->        
        start_date = moment(date).date(1).day(0)
        end_date   = moment(date).add(1, 'months').date(1).subtract(1, 'days').day(6)
        @fetchEventData start_date, end_date

    onEventClick: (event, e) ->
        @refs.modal.setEvent event 
        @setState
            showModal: true
        e.preventDefault()
        e.stopPropagation()

    onAddEvent: ->
        @refs.modal.setEvent
            id: 0
            field: Object.keys(@state.colors)[0]
            date: @state.date
            time: moment()
            note: '' 
        @setState
            showModal: true

    confirmAddEvent: ->
        event = @refs.modal.state.event
        await fetch config.server_path + "/event/" + (if event.id == 0 then '' else event.id),
            method: 'POST'
            body: JSON.stringify event
            headers:
                'Content-Type': 'application/json'
        @setState
            showModal: false 
        @onPanelChange @state.date, 'month'

    cancelEvent: ->
        @setState
            showModal: false

    deleteEvent: ->
        event = @refs.modal.state.event
        return if event.id == 0
        await fetch config.server_path + "/event/#{event.id}",
            method: 'DELETE'
        @setState
            showModal: false 
        @onPanelChange @state.date, 'month'

    dateCellRender: (date) ->
        date = date.format 'YYYY-MM-DD'
        return null unless @state.events[date]
        <div> {
            @state.events[date]
                .filter (data) => if @props.fields and @props.fields.length > 0 then return @props.fields.indexOf(data.field) >= 0 else return true
                .map (data) => <Event event={data.field} color={@state.colors[data.field]} onDoubleClick={this.onEventClick.bind(this, data)} />
        } </div>

    render: ->
        <div style={{ padding: '40px' }} onDoubleClick={@onAddEvent.bind(this)}>
            <Calendar value={@state.date} dateCellRender={@dateCellRender.bind(this)} onPanelChange={@onPanelChange.bind(this)} onChange={(date) => @setState {date: date}} />
            <EventModal ref="modal" visible={@state.showModal} fields={Object.keys(@state.colors)} onOK={@confirmAddEvent.bind(this)} onCancel={@cancelEvent.bind(this)} onDelete={@deleteEvent.bind(this)}/> 
        </div>

Calender.defaultProps = 
    events: null
export default Calender