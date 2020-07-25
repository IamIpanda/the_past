import React, { Component } from 'react';
import { Layout, Menu } from 'antd';
import 'antd/dist/antd.css';
import {
    TagOutlined,
    TagsOutlined,
    PlusOutlined
} from '@ant-design/icons'
import FieldModal from './modal_field'
import config from '../config.json'
import './menu.css'

class LeftMenu extends Component
    constructor: (props) ->
        super props
        @state = 
            fields: []
            selectedFields: []
            showFieldModal: false

    componentDidMount: ->
        @fetchFields()

    fetchFields: ->
        url = config.server_path + "/list/"
        response = await fetch url
        fields = await response.json()
        @setState { fields: fields }

    clickAddFields: ->
        @refs.add_field_modal.setField
            name: ''
            color: '#FFFFFF'
        @setState { showFieldModal: true }

    clickEditFields: (field, e) ->
        @setState
            showFieldModal: true
        @refs.add_field_modal.setField field

    cancelAddFields: ->
        @setState
            showFieldModal: false

    confirmAddFields: ->
        originName = @refs.add_field_modal.state.field.originName
        method = if originName then 'POST' else 'PUT'
        url = config.server_path + "/list" + if originName then "/#{originName}" else ''
        response = await fetch url,
            method: method
            headers:
                'content-type': 'application/json'
            body: JSON.stringify @refs.add_field_modal.getValue()
        @setState { showFieldModal: false }, @fetchFields.bind(this)
        @props.onEventChange()
        @forceUpdate()

    deleteFields: ->
        url = config.server_path + "/list/" + @refs.add_field_modal.state.field.originName 
        await fetch url,
            method: 'DELETE' 
        @setState { showFieldModal: false }, @fetchFields.bind(this)
        @forceUpdate()

    triggerChange: (e) ->
        @props.onEventChange e.selectedKeys

    render: ->
        <Menu ref="menu"
              theme='dark'
              mode='inline' 
              style={{ background: '#141414' }} 
              defaultOpenKeys={['events']} 
              multiple
              onSelect={@triggerChange.bind(this)}
              onDeselect={@triggerChange.bind(this)}>
            <Menu.SubMenu title="事件" key='events' icon={<TagsOutlined />}>
                { @state.fields.map (field) => <Menu.Item key={field.name}>
                    <div>
                        <TagOutlined /> 
                        <span onDoubleClick={@clickEditFields.bind(this, field)}>{ field.name }</span>
                        <span className='color-rect' style={{background: field.color}}></span>
                    </div>
                </Menu.Item> }
                <Menu.Item key="add" onClick={@clickAddFields.bind(this)}><PlusOutlined />添加...</Menu.Item>
                <FieldModal ref='add_field_modal' visible={@state.showFieldModal} onOK={@confirmAddFields.bind(this)} onCancel={@cancelAddFields.bind(this)} onDelete={@deleteFields.bind(this)} />
            </Menu.SubMenu>
        </Menu>

LeftMenu.defaultProps = ->
    onEventChange: ->

export default LeftMenu