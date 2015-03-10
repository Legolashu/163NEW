//
//  CRimgModel.h
//  网易新闻
//
//  Created by yosemite on 15/1/25.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRimgModel : NSObject
//图片的路径
@property(nonatomic,copy)NSString *src;
// 图片的尺寸
@property (nonatomic,copy)NSString *pixel;
// 图片所处的位置
@property (nonatomic,copy)NSString *ref;

+(instancetype )detailImgWithDictL:(NSDictionary *)dict;
@end
