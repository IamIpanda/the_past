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

    render: ->
        <Layout style={{ minHeight: '100vh' }}>
            <Sider collapsible >
                <h2 className="logo">
                    <BookOutlined />
                    &nbsp;&nbsp;The Past
                </h2>
                <LeftMenu onEventChange={() => @refs.panel.refreshCalender()} />
            </Sider>
            <Layout>
                <RightPanel ref="panel" />
            </Layout>
        </Layout>

export default MainPage