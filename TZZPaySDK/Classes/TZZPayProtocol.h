//
//  TZZPayProtocol.h
//  TZZPaySDK
//
//  Created by tzz on 2019/11/10.
//  Copyright © 2019 tzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZZPayModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TZZPayProtocol <NSObject>

@property (nonatomic, copy) void(^completionBlock)(TZZPayResp *resp);

@property (nonatomic, copy) NSString *appId;//

@optional
//检查应用是否已被用户安装
- (BOOL)isAppInstalled;
//判断当前应用的版本是否支持OpenApi
- (BOOL)isAppSupportApi;


/// 支付接口
/// @param payModel 参数
/// @param completion 结果回调
- (void)pay:(TZZPayModel *)payModel completion:(void(^)(TZZPayResp *resp))completion;

/// 处理三方应用通过URL启动App时传递的数据
/// @param url 回调url
- (void)handleOpenURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
