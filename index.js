
import { NativeModules } from 'react-native';

const { RNMeiqia } = NativeModules;

export async function init(params) {
    return await RNMeiqia.init(params);
}

export function show(params = {}) {
    const data = {clientInfo:{}, ...params};
    RNMeiqia.show(data);
}
