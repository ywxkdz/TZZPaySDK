//
//  TZZWXPayHelper.m
//  TZZPaySDK
//
//  Created by tzz on 2019/11/10.
//  Copyright © 2019 tzz. All rights reserved.
//

#import "TZZWXPayHelper.h"

@implementation TZZWXPayHelper

@synthesize completionBlock = _completionBlock;
@synthesize appId   = _appId;

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnUserCancelPay) name:@"" object:nil];
    }
    return self;
}

- (BOOL)isAppInstalled
{
    return [WXApi isWXAppInstalled];
}
- (BOOL)isAppSupportApi
{
    return [WXApi isWXAppSupportApi];
}
- (void)pay:(TZZPayModel *)payModel completion:(nonnull void (^)(TZZPayResp * _Nonnull))completion
{
    _completionBlock = completion;
    
    PayReq *request = [PayReq new];
    request.partnerId = payModel.partnerId;
    request.partnerId = payModel.prepayId;
    request.partnerId = payModel.package;
    request.partnerId = payModel.nonceStr;
    request.partnerId = payModel.timeStamp;
    request.partnerId = payModel.sign;
    
    [WXApi sendReq:request completion:^(BOOL success) {
        if (success) {
            NSLog(@"WXApi sendReq success");
        }
    }];
}
- (void)handleOpenURL:(NSURL *)url
{
    NSString* _rstStr = [url absoluteString];
    
    if ([_rstStr  containsString:@"//pay/?returnKey="]) {
        //是支付回调
        
        if ([_rstStr  containsString:@"&ret=0"]) {
            //成功
            if (self.completionBlock) {
                self.completionBlock([self payRespWithRespCode:TZZPayRespCodeSuccess respResult:nil]);
            }
        }else
        {
            //失败
            if (self.completionBlock) {
                self.completionBlock([self payRespWithRespCode:TZZPayRespCodeError respResult:nil]);
            }
        }
        
    }
}
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        
    }
}
#pragma mark -----------------通知
- (void)OnUserCancelPay
{
    if (self.completionBlock) {
        self.completionBlock([self payRespWithRespCode:TZZPayRespCodeUserCancel respResult:nil]);
    }
}
#pragma mark -----------------Private
- (TZZPayResp *)payRespWithRespCode:(TZZPayRespCode)respCode respResult:(NSDictionary *)resultDic
{
    NSString *message = nil;
    switch (respCode) {
        case TZZPayRespCodeSuccess:
        {
            message = @"支付成功";
        }
            break;
        case TZZPayRespCodeError:
        {
            message = @"支付失败";
        }
            break;
        case TZZPayRespCodeUserCancel:
        {
            message = @"用户取消支付";
        }
            break;
        default:
            break;
    }
    TZZPayResp *resp = [TZZPayResp new];
    resp.message = message;
    resp.respCode = respCode;
    resp.resp = resultDic;
    return resp;
}
@end
