import React, { Component } from 'react';
import 'antd/dist/antd.css';
import { Layout, Menu } from 'antd';
import LeftMenu from './components/menu'
import RightPanel from './components/panel'

{ Header, Content, Footer, Sider } = Layout;

class MainPage extends Component
    constructor: (props) ->
        super props

    render: ->
        <Layout style={{ minHeight: '100vh' }}>
            <Sider collapsible >
                <div style={{ height: '32px', margin: '16px' }}></div>
                <LeftMenu onEventChange={() => @refs.panel.refreshCalender()} />
            </Sider>
            <Layout>
                <RightPanel ref="panel" />
            </Layout>
        </Layout>

export default MainPage