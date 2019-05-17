/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {StyleSheet, Text, View} from 'react-native';
import Meiqia from 'meiqia-react-native';

type Props = {};
export default class App extends Component<Props> {

  componentDidMount() {
    Meiqia.init({appKey:'b20bf39620fdd43f11128182ff77a551'}).then((data)=>{
      alert(JSON.stringify(data));
    });
  }

  initSdk = () => {
    Meiqia.init({appKey:'b20bf39620fdd43f11128182ff77a551'}).then((data)=>{
      alert(JSON.stringify(data));
    });
  };

  letUsChat = () => {
    const data = {
      clientInfo: {
        name: 'Kenny锅',
        gender: '男',
        age: '20',
        tel: '13800138000',
        weixin: 'wechat007',
        weibo: 'weibo007',
        address: '湖北省武汉市xxx',
        email: 'kenny@china.com',
        avator: 'https://s3.cn-north-1.amazonaws.com.cn/pics.meiqia.bucket/1dee88eabfbd7bd4',
        source: '朋友推荐',
        comment: '全栈，就是了不起，备注也没问题'
      },
    };
    Meiqia.show(data);
  };

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions} onPress={this.initSdk}>点击我，显示信息</Text>
        <Text style={styles.instructions} onPress={this.letUsChat}>出来吧，悟空</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
