//
//  TZZWXPayHelper.h
//  TZZPaySDK
//
//  Created by tzz on 2019/11/10.
//  Copyright © 2019 tzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZZPayProtocol.h"
#import <WechatOpenSDK/WXApi.h>
NS_ASSUME_NONNULL_BEGIN

@interface TZZWXPayHelper : NSObject <TZZPayProtocol, WXApiDelegate>

@end

NS_ASSUME_NONNULL_END
