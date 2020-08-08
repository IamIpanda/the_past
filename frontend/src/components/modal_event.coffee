import React, { Component } from 'react'
import { Modal, Form, Input, DatePicker, Select, Button } from 'antd'
import moment from 'moment'

class EventModal extends Component
    constructor: (props) ->
        super props
        @state =
            event:
                id: 0
                field: 'Unknown'
                date: moment()
                time: moment()
                note: '' 

    setEvent: (event) ->
        @setState
            event: event 

    onNoteChange: (e) ->
        @setState
            event: { @state.event..., note: e.target.value }

    onDateChange:(date) ->
        @state.event.date = date 

    onSelectChange: (value) ->
        @setState
            event: { @state.event..., field: value }
        
    render: ->
        <Modal
            visible={@props.visible}
            title="事件"
            destroyOnClose
            onOk={@props.onOK}
            onCancel={@props.onCancel}
            footer={[
                <Button key="cancel" onClick={@props.onCancel}>
                    取消
                </Button>,
                if @state.event.id > 0 then <Button key="remove" type="danger" onClick={@props.onDelete}>
                    删除
                </Button> else null,
                <Button key="submit" type="primary" loading={@props.loading} onClick={@props.onOK}>
                    确定
                </Button>
          ]}>
            <Form>
                <Form.Item label="事件">
                    <Select ref='field' value={@state.event.field} onSelect={@onSelectChange.bind(this)}>
                        { @props.fields.map (field) -> <Select.Option value={field}>{field}</Select.Option> }
                    </Select>
                </Form.Item>
                <Form.Item label="日期">
                    <DatePicker ref='date' defaultValue={moment(@state.event.date)} onChange={@onDateChange.bind(this)}/>
                </Form.Item>
                <Form.Item label="备注">
                    <Input.TextArea ref='notes' placeholder="备注" value={@state.event.note} onChange={@onNoteChange.bind(this)} />
                </Form.Item>
                {
                    if @state.event.id > 0
                        <div>此事件记录于 {moment(@state.event.time).format('YYYY-MM-DD HH:mm:ss')} </div>
                    else
                        null
                }
            </Form>
        </Modal>

EventModal.defaultProps = 
    fields: []
    onOK: ->
    onCancel: ->
    onDelete: ->
    visible: false
    loading: false

export default EventModal