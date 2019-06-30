declare module 'meiqia-react-native' {
  interface InitParam {
    appKey: string,
  }

  interface InitResult {
    code?: string;
    clientId?: string;
    message?: string;
  }

  export function MeiqiaInit(params: InitParam): Promise<InitResult>;

  export function MeiqiaShow(params: any): void;

  export function MeiqiaStartService(): void;

  export function MeiqiaStopService(): void;

  export function MeiqiaRegisterDeviceToken(deviceToken: string): void;
}

