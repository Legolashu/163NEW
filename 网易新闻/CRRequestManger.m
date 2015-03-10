//
//  CRRequestManger.m
//  网易新闻
//
//  Created by yosemite on 15/1/24.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import "CRRequestManger.h"

@implementation CRRequestManger
+(instancetype)manager
{
    CRRequestManger *mgr=[super manager];
    //取出set
    NSMutableSet *newset=[NSMutableSet set];
    newset.set=mgr.responseSerializer.acceptableContentTypes;
    [newset addObject:@"text/html"];
    mgr.responseSerializer.acceptableContentTypes=newset;
    return mgr;
}

@end
