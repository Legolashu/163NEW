//
//  CRimgModel.m
//  网易新闻
//
//  Created by yosemite on 15/1/25.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import "CRimgModel.h"

@implementation CRimgModel

+(instancetype)detailImgWithDictL:(NSDictionary *)dict
{
    CRimgModel *model=[[self alloc]init ];
    model.pixel=dict[@"pixel"];
    model.src=dict[@"src"];
    model.ref=dict[@"ref"];
    return model;
    
}


@end
