//
//  CRNewsDetail.h
//  网易新闻
//
//  Created by yosemite on 15/1/25.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRNewsDetail : NSObject

@property (nonatomic,copy)NSString *title;
/*  新闻发布时间*/

@property (nonatomic,copy)NSString *ptime;
/*新闻发布内存*/
@property (nonatomic,copy)NSString *body;
@property (nonatomic ,strong)NSArray *img;

+(instancetype)detailWithDict:(NSDictionary *)dict;

@end
