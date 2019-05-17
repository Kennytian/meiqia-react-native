
#import "RNMeiqia.h"

@implementation RNMeiqia

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

//初始化SDK
RCT_EXPORT_METHOD(init: (NSDictionary *)param resolve: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSString *AppKey = @"";
    if ((NSString *)param[@"appKey"] != nil) {
        AppKey = (NSString *)param[@"appKey"];
    }
    if(![AppKey isEqual: @""]){
        NSDictionary *ret = @{@"code": @"0", @"message":@"success", @"clientId":AppKey};
        resolve(ret);
    }else{
        NSDictionary *ret = @{@"code": @"1", @"message":@"appKey is missing"};
        resolve(ret);
    }
}

//跳转到聊天界面
RCT_EXPORT_METHOD(show: (NSDictionary *)param resolve: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    
}
@end
