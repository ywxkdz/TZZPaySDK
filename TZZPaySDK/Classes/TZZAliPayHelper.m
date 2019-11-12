//
//  TZZAliPayHelper.m
//  TZZPaySDK
//
//  Created by tzz on 2019/11/10.
//  Copyright © 2019 tzz. All rights reserved.
//

#import "TZZAliPayHelper.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation TZZAliPayHelper
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

- (void)pay:(TZZPayModel *)payModel completion:(nonnull void (^)(TZZPayResp * _Nonnull))completion
{
    _completionBlock = completion;
    
    [[AlipaySDK defaultService] payOrder:payModel.orderString fromScheme:self.appId callback:^(NSDictionary *resultDic) {
        if ([resultDic[@"resultStatus"] integerValue] == 6001) {
            if (self.completionBlock) {
                self.completionBlock([self payRespWithRespCode:TZZPayRespCodeUserCancel respResult:resultDic]);
            }
            return ;
        }
        
        if (self.completionBlock) {
            self.completionBlock([self payRespWithRespCode:TZZPayRespCodeSuccess respResult:resultDic]);
        }
    }];
}
- (void)handleOpenURL:(NSURL *)url
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] integerValue] == 6001) {
                if (self.completionBlock) {
                    self.completionBlock([self payRespWithRespCode:TZZPayRespCodeUserCancel respResult:resultDic]);
                }
                return ;
            }
            
            if (self.completionBlock) {
                self.completionBlock([self payRespWithRespCode:TZZPayRespCodeSuccess respResult:resultDic]);
            }
        }];
    }else {
        if (self.completionBlock) {
            self.completionBlock([self payRespWithRespCode:TZZPayRespCodeError respResult:nil]);
        }
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
