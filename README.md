
# meiqia-react-native

## Getting started

`$ npm install meiqia-react-native --save`

or

`$ yarn add meiqia-react-native`

### Mostly automatic installation

`$ react-native link meiqia-react-native`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `meiqia-react-native` and add `RNMeiqia.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNMeiqia.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNMeiqiaPackage;` to the imports at the top of the file
  - Add `new RNMeiqiaPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':meiqia-react-native'
  	project(':meiqia-react-native').projectDir = new File(rootProject.projectDir, '../node_modules/meiqia-react-native/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':meiqia-react-native')
  	```

## Usage

#### import
```javascript
import { init, show } from 'meiqia-react-native';
```

#### init appKey
```javascript
init({ appKey:'xxx' }).then((config)=>{
    console.log('config info:', config);
    // {"code:": 0, "clientId": "xxxxx", "message": 'success'}
});
```

#### launch chat window
```javascript
show(); 
```
or, if you known

```javascript
show({
  titleColor: '',
  titleBarColor: '', 
  naviColor: '', 
  clientInfo: {}, 
  customId:{id:''}, 
  clientId:{id:''}, 
  scheduledInfo:{agentId:'', agentGroup:'', scheduleRule: 'none|group|enterprise', },
});
```

> Now, we can see the default chat window

![](./screenshot/screenshot1.png)

