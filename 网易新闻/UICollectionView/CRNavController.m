//
//  CRNavController.m
//  网易新闻
//
//  Created by yosemite on 15/1/27.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import "CRNavController.h"


@interface CRNavController ()

@end

@implementation CRNavController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
+(void)load
{
    //设置导航栏的背景
    // 获取整个应用程序的导航条外观；标识
    // 只要一个控件遵守了UIAppearance这个协议 就能获取这个控件外观
    // 获取当前导航控制器 这个类中所有导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航条的标题颜色和字体
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:dict];
    
    // 设置导航条的主题
    [navBar setTintColor:[UIColor whiteColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
