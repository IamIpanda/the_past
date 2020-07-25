import React, { Component } from 'react';
import 'antd/dist/antd.css';
import {
    BookOutlined
} from '@ant-design/icons'
import { Layout, Menu } from 'antd';
import LeftMenu from './components/menu'
import RightPanel from './components/panel'
import "./MainPage.css"

{ Header, Content, Footer, Sider } = Layout;

class MainPage extends Component
    constructor: (props) ->
        super props
        @state = 
            collapsed: false

    render: ->
        <Layout style={{ minHeight: '100vh' }}>
            <Sider ref="sider" collapsible onCollapse={(collapsed) => @setState({ collapsed })} >
                <h2 className="logo">
                    <BookOutlined />
                    { if @state.collapsed then null else <span>&nbsp;&nbsp;The Past</span> }
                </h2>
                <LeftMenu onEventChange={(key) => @refs.panel.refreshCalender(key)} />
            </Sider>
            <Layout>
                <RightPanel ref="panel" />
            </Layout>
        </Layout>

export default MainPage