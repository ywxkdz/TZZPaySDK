//
//  TZZPayManager.m
//  TZZPaySDK
//
//  Created by tzz on 2019/11/10.
//  Copyright © 2019 tzz. All rights reserved.
//

#import "TZZPayManager.h"
#import "TZZWXPayHelper.h"
#import "TZZAliPayHelper.h"

@interface TZZPayManager ()
{
    TZZWXPayHelper *_wxPayHelper;
    TZZAliPayHelper *_aliPayHelper;
}
@property (nonatomic, assign, readwrite) TZZPayType payType;
@end

@implementation TZZPayManager

+ (instancetype)shareInstance
{
    static TZZPayManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [TZZPayManager new];
    });
    return instance;
}
- (id<TZZPayProtocol>)tzz_payHelper:(TZZPayType)payType
{
    _payType = payType;
    if (payType == TZZPayTypeWX) {
        if (_wxPayHelper == nil) {
            _wxPayHelper = [TZZWXPayHelper new];
        }
        return _wxPayHelper;
    }
    if (payType == TZZPayTypeAli) {
        if (_aliPayHelper == nil) {
            _aliPayHelper = [TZZAliPayHelper new];
        }
        return _aliPayHelper;
    }
    return nil;
}
- (void)tzz_handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
{
    if ([sourceApplication isEqualToString:_wxPayHelper.appId]) {
        [_wxPayHelper handleOpenURL:url];
    }
    if ([sourceApplication isEqualToString:_aliPayHelper.appId]) {
        [_aliPayHelper handleOpenURL:url];
    }
}
@end
