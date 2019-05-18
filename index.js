
import { NativeModules } from 'react-native';

const { RNMeiqia } = NativeModules;

export async function MeiqiaInit(params) {
    return await RNMeiqia.init(params);
}

export function MeiqiaShow(params = {}) {
    const data = {clientInfo:{}, ...params};
    RNMeiqia.show(data);
}
