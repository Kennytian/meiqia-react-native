
#import "RNMeiqia.h"
#import "UIColor+Hex.h"
#import <MeiQiaSDK/MQManager.h>
#import "MQChatViewManager.h"

@implementation RNMeiqia

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

//初始化SDK
RCT_EXPORT_METHOD(initSDK: (NSDictionary *)param resolve: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    NSString *AppKey = @"";
    if ((NSString *)param[@"appKey"] != nil) {
        AppKey = (NSString *)param[@"appKey"];
    }
    if(![AppKey isEqual: @""]){
        [MQManager initWithAppkey:AppKey completion:^(NSString *clientId, NSError *error) {
            if (!error) {
                NSDictionary *ret = @{@"code": @"0", @"message":@"success", @"clientId":clientId};
                resolve(ret);
            } else {
                NSDictionary *ret = @{@"code": @(error.code), @"message":error.description};
                resolve(ret);
            }
        }];
    }else{
        NSDictionary *ret = @{@"code": @"1", @"message":@"AppKey为空"};
        resolve(ret);
    }
}

//跳转到聊天界面
RCT_EXPORT_METHOD(show: (NSDictionary *)param resolve: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    MQChatViewStyle *aStyle = [chatViewManager chatViewStyle];
    // 设置返回键
    if((NSString *)param[@"titleColor"]){
        NSString *titleColor = (NSString *)param[@"titleColor"];
        [aStyle setNavTitleColor: [UIColor colorWithHexString: titleColor]];
    }
    if((NSString *)param[@"titleBarColor"]){
        NSString *titleBarColor = (NSString *)param[@"titleBarColor"];
        [aStyle setNavBarColor: [UIColor colorWithHexString: titleBarColor]];
    }

    if((NSString *)param[@"naviColor"]){
        NSString *naviColor = (NSString *)param[@"naviColor"];
        [aStyle setNavBarTintColor: [UIColor colorWithHexString: naviColor]];
    }

    [aStyle setNavBackButtonImage:[UIImage imageNamed:@"meiqia-icon"]];
    // 设置圆形头像
    [aStyle setEnableRoundAvatar:YES];
    // [aStyle setEnableOutgoingAvatar:NO]; //不显示用户头像
    // [aStyle setEnableIncomingAvatar:NO]; //不显示客服头像

    // 设置客户端信息
    if((NSDictionary *)param[@"clientInfo"]){
        NSDictionary *clientInfo = (NSDictionary *)param[@"clientInfo"];
        [chatViewManager setClientInfo: clientInfo];
    }

    //设置美洽clientId
    if((NSDictionary *)param[@"clientId"]&&(NSString *)param[@"clientId"][@"id"]&&![(NSString *)param[@"clientId"][@"id"] isEqual:@""]){
        NSDictionary *clientInfo = (NSDictionary *)param[@"clientId"][@"id"];
        [chatViewManager setClientInfo: clientInfo];
    }

    //customId
    if ((NSString *)param[@"customId"]&&(NSString *)param[@"customId"][@"id"]&&![(NSString *)param[@"customId"][@"id"] isEqual:@""]){
        NSString *customId = (NSString *)param[@"customId"][@"id"];
        [chatViewManager setLoginCustomizedId:customId];
    }else{
        #pragma mark 切记切记切记 下面这一行是错误的写法 , 这样会导致 ID = "notadda" 和 meiqia多个用户绑定,最终导致 对话内容错乱 A客户能看到 B C D的客户的对话内容
        [chatViewManager setLoginCustomizedId:@"notadda"];
    }

    //客服组scheduledInfo
    //分配到指定客服，或指定组里面的客服，指定客服优先级高，并可选择分配失败后的转接规则
    NSString *agentId = nil;
    NSString *agentGroupId = nil;
    int rule = 3;
    if((NSString *)param[@"scheduledInfo"]&&(NSString *)param[@"scheduledInfo"][@"agentId"]&&![(NSString *)param[@"scheduledInfo"][@"agentId"] isEqual:@""]){
        agentId = (NSString *)param[@"scheduledInfo"][@"agentId"];
    }
    if((NSString *)param[@"scheduledInfo"]&&(NSString *)param[@"scheduledInfo"][@"agentGroup"]&&![(NSString *)param[@"scheduledInfo"][@"agentGroup"] isEqual:@""]){
        agentGroupId = (NSString *)param[@"scheduledInfo"][@"agentGroup"];
    }
    if((NSString *)param[@"scheduledInfo"]&&(NSString *)param[@"scheduledInfo"][@"scheduleRule"]&&![(NSString *)param[@"scheduledInfo"][@"scheduleRule"] isEqual:@""]){
        ////1 不转接给任何人, 2 转接给组内的人,3 转接给企业其他随机一个人 //none：不转接给任何人，让用户留言 group: 转接给组内的人enterprise: 转接给企业其他随机一个人
        NSString *ruleStr = (NSString *)param[@"scheduledInfo"][@"scheduleRule"];
        if([ruleStr isEqual:@"none"]){
            rule = 1;
        }
        if([ruleStr isEqual:@"group"]){
            rule = 2;
        }
        if([ruleStr isEqual:@"enterprise"]){
            rule = 3;
        }
    }

    [MQManager setScheduledAgentWithAgentId:agentId agentGroupId:agentGroupId scheduleRule:rule];
    //客服组scheduledInfo
    [chatViewManager pushMQChatViewControllerInViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
}
@end
