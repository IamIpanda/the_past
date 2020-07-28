import React from 'react';
import MainPage from './MainPage'

import moment from 'moment';
import 'moment/locale/zh-cn';
moment.locale('zh-cn')

function App() {
  return <MainPage />;
}

export default App;
