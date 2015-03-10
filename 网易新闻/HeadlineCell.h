//
//  HeadlineCell.h
//  网易新闻
//
//  Created by yosemite on 15/1/24.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  CRheadModel;

@interface HeadlineCell : UITableViewCell
@property (nonatomic,strong)CRheadModel  *headModel;

// 根据模型返回可重用标示符号
+(NSString *)cellIdWithModel:(CRheadModel *)news;

// 根据模型返回行高
+(CGFloat)rowHeightWithModel:(CRheadModel *)news;
@end
