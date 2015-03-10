//
//  CRheadModel.m
//  网易新闻
//
//  Created by yosemite on 15/1/24.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import "CRheadModel.h"

@implementation CRheadModel
+(instancetype)CRheadModelWithDict:(NSDictionary *)dict
{
    id  obj=[[self alloc]init ];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

@end
