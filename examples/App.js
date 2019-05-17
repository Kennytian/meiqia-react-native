/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {StyleSheet, Text, View} from 'react-native';
import { init, show } from 'meiqia-react-native';

type Props = {};
export default class App extends Component<Props> {
  initSdk = () => {
    init({appKey:'b20bf39620fdd43f11128182ff77a557'}).then((data)=>{
      alert(JSON.stringify(data));
    });
  };

  letUsChat = () => {
    show();
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
