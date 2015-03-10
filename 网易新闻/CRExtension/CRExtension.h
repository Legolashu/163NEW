//
//  CRExtension.h
//  框架设计
//
//  Created by yosemite on 15/1/26.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRExtension : NSObject

///  展示 成功的信息

+(void)showSuccessMessage:(NSString *)msg;


+(void)showErrerMessage:(NSString *)msg;

+(void)showLoginMessage:(NSString *)msg;
@end
