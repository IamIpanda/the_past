import React, { Component } from 'react';
import 'antd/dist/antd.css';
import { Layout, Menu, } from 'antd';
import config from '../config.json'
import './menu.css'

class LeftMenu extends Component
    constructor: (props) ->
        super props
        @state = 
            fields: []

    componentDidMount: ->
        @fetchFields()

    fetchFields: ->
        url = config.server_path + "/api/list/"
        response = await fetch url
        fields = await response.json()
        @setState { fields: fields }

    render: ->
        <Menu theme='dark' mode='inline' style={{ background: '#141414' }} defaultOpenKeys={['events']}>
            <Menu.SubMenu title="事件" key='events'>
                { @state.fields.map (field) => <Menu.Item>
                    <div>
                        <span>{ field.name }</span>
                        <span className='color-rect' style={{background: field.color}}></span>
                    </div>
                </Menu.Item> }
                <Menu.Item key="add">添加...</Menu.Item>
            </Menu.SubMenu>
        </Menu>

export default LeftMenu