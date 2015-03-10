//
//  CRCollectionViewCell.m
//  网易新闻
//
//  Created by yosemite on 15/1/27.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import "CRCollectionViewCell.h"
#import "HeadLineTableViewController.h"
#import "CRNavController.h"

@interface CRCollectionViewCell ()
@property (nonatomic,strong)HeadLineTableViewController * NewsController;
@property (nonatomic,strong)CRNavController *nav;
@end

@implementation CRCollectionViewCell

-(void)awakeFromNib
{
    // 目标 将新闻表格视图  添加到cell中
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //刚才的方式  视图控制器都是局部变量
    //对表格的所有处理的都是控制器
    // 强引用属性可以保证视图控制器不会被销毁
    self.nav=sb.instantiateInitialViewController;
    
   self.NewsController= [self.nav.childViewControllers firstObject];
    
    self.bounds = self.NewsController.view.bounds;
    [self addSubview:self.nav.view];
}


-(void)setUrlList:(NSDictionary *)urlList
{
    _urlList =urlList;
    self.NewsController.urlList=urlList;
}
@end
