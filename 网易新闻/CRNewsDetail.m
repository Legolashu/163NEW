//
//  CRNewsDetail.m
//  网易新闻
//
//  Created by yosemite on 15/1/25.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import "CRNewsDetail.h"
#import "CRimgModel.h"

@implementation CRNewsDetail

+(instancetype)detailWithDict:(NSDictionary *)dict
{
    CRNewsDetail *NewsDetail=[[self alloc]init ];
    NewsDetail.title=dict[@"title"];
    NewsDetail.body=dict[@"body"];
    NewsDetail.ptime=dict[@"ptime"];
//图形模型数组
    NSArray * imgDictArray=dict[@"img"];
    NSMutableArray *imageModeleArray=[NSMutableArray array];
    for (NSDictionary *imgdict in imgDictArray) {
        CRimgModel *imag=[CRimgModel detailImgWithDictL:imgdict];
        [imageModeleArray addObject:imag];
    }
    NewsDetail.img=imageModeleArray;
    return  NewsDetail;
}

@end
