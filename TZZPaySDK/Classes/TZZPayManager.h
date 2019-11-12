//
//  TZZPayManager.h
//  TZZPaySDK
//
//  Created by tzz on 2019/11/10.
//  Copyright © 2019 tzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZZPayProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TZZPayType) {
    TZZPayTypeWX,
    TZZPayTypeAli,
    
};


@interface TZZPayManager : NSObject
@property (nonatomic, assign, readonly) TZZPayType payType;
+ (instancetype)shareInstance;
- (id<TZZPayProtocol>)tzz_payHelper:(TZZPayType)payType;
- (void)tzz_handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;
@end

NS_ASSUME_NONNULL_END
