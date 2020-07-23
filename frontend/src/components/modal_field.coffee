import React, { Component } from 'react'
import { Modal, Form, Input, Button } from 'antd'
import 'antd/dist/antd.css';

class FieldModal extends Component
    constructor: (props) ->
        super props
        @state = 
            field: 
                name: "Unknown"
                originName: null
                color: "#FFFFFFF"
 
    setField: (field) ->
        @setState
            field: { field..., originName: field.name }

    getValue: ->
        [ @state.field.name, @state.field.color ]

    onNameChange: (e) ->
        @setState
            field: { @state.field..., name: e.target.value }

    onColorChange: (e) ->
        @setState
            field: { @state.field..., color: e.target.value }

    render: ->
        <Modal
            visible={@props.visible}
            title="添加事件"
            onOk={this.handleOk}
            onCancel={this.handleCancel}
            footer={[
                <Button key="cancel" onClick={@props.onCancel}>
                    取消
                </Button>,
                if @state.field.originName then <Button key="remove" type="danger" onClick={@props.onDelete}>
                    删除
                </Button> else null,
                <Button key="submit" type="primary" loading={@props.loading} onClick={@props.onOK}>
                    确定
                </Button>,
          ]}>
            <Form>
                <Form.Item label="名称">
                    <Input placeholder="不知名事件" ref='name' value={@state.field.name} onChange={@onNameChange.bind(this)} />
                </Form.Item>
                <Form.Item label="颜色">
                    <Input placeholder="#FFFFFF" ref='color' value={@state.field.color} onChange={@onColorChange.bind(this)} />
                </Form.Item>
            </Form>
        </Modal>

FieldModal.defaultProps = 
    onOK: ->
    onCancel: ->
    onDelete: ->
    visible: false
    loading: false

export default FieldModal