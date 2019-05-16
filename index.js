
import { NativeModules } from 'react-native';

const { RNMeiqia } = NativeModules;

export async function initSDK(params) {
    return await RNMeiqia.initSDK(params);
}

export function show(params) {
    RNMeiqia.show(params);
}
