//
//  HeadlineCell.m
//  网易新闻
//
//  Created by yosemite on 15/1/24.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import "HeadlineCell.h"
#import "CRheadModel.h"
#import "UIImageView+WebCache.h"
@interface HeadlineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *repleyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *subimage1;
@property (weak, nonatomic) IBOutlet UIImageView *subimage2;


@end

@implementation HeadlineCell
+(NSString *)cellIdWithModel:(CRheadModel *)news
{
    if(news.imgextra){
        return @"cell1";
    }else if (news.imgType)
    {
        return @"cell2";
    }else {
        return @"cell";
    }
}
+(CGFloat)rowHeightWithModel:(CRheadModel *)news
{
    if (news.imgType) {
        return 130;
    } else if (news.imgextra) {
        return 120;
    } else {
        return 100;
    }
}

-(void)setHeadModel:(CRheadModel *)headModel
{
    _headModel=headModel;
    self.titleLabel.text=headModel.title;
    self.detailLabel.text=headModel.digest;
    self.repleyLabel.text=[NSString stringWithFormat:@"回帖数：%@",headModel.replyCount];
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:headModel.imgsrc]];
    //多图
    if (headModel.imgextra.count==2) {
        [self.subimage1 sd_setImageWithURL:[NSURL URLWithString:headModel.imgextra[0][@"imgsrc"]]];
         [self.subimage2 sd_setImageWithURL:[NSURL URLWithString:headModel.imgextra[1][@"imgsrc"]]];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
