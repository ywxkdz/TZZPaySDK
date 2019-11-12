//
//  TZZPayModel.h
//  TZZPaySDK
//
//  Created by tzz on 2019/11/11.
//  Copyright © 2019 tzz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TZZPayRespCode) {
    TZZPayRespCodeSuccess = 0,//成功
    TZZPayRespCodeError = -1,//错误
    TZZPayRespCodeUserCancel = -2,//用户取消
};


//调起客户端支付所需参数由服务端生成返回
@interface TZZPayModel : NSObject
//微信支付参数
@property (nonatomic, copy) NSString *partnerId;
@property (nonatomic, copy) NSString *prepayId;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *nonceStr;
@property (nonatomic, copy) NSString *timeStamp;
@property (nonatomic, copy) NSString *sign;

//支付宝支付参数
@property (nonatomic, copy) NSString *orderString;

@end

@interface TZZPayResp : NSObject
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) TZZPayRespCode respCode;
@property (nonatomic, strong) NSDictionary *resp;
@end

NS_ASSUME_NONNULL_END
