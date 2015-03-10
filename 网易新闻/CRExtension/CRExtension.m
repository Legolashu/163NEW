//
//  CRExtension.m
//  框架设计
//
//  Created by yosemite on 15/1/26.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import "CRExtension.h"
#define  WindowHeight 20
#define  CRdelayTime 2
#define  CRstatsTime 2

@implementation CRExtension

// 只能设置全局变量
 UIWindow *_window;

//类方法 不能使用成员变量属性


+(void)showMessage:(NSString *)msg
{
    //创建一个窗口在uiWindow上面
   _window=[[UIWindow alloc]init];
//     UIWindowLevelNormal;
//     UIWindowLevelAlert;
//     UIWindowLevelStatusBar;
    _window.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, -WindowHeight);
    _window.backgroundColor=[UIColor blackColor];
    //UIwindow 的优先级
    _window.windowLevel=UIWindowLevelAlert;
    // Uiwindow 默认是隐藏的
    _window.hidden=NO;
    // 创建按钮
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=_window.bounds;
    // 设置图片
    [button setImage:[UIImage imageNamed:@"success"] forState:UIControlStateNormal];
    [button setTitle:msg forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:12];
    [_window addSubview:button];
    // 设置动画
    [UIView animateWithDuration:CRdelayTime animations:^{
        CGRect frame=_window.frame;
        frame.origin.y=0;
        _window.frame=frame;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:CRstatsTime delay:CRdelayTime options:kNilOptions animations:^{
            CGRect frame=_window.frame;
            frame.origin.y=-WindowHeight;
            _window.frame=frame;
            
        } completion:^(BOOL finished) {
            _window=nil;
        }];
    }];
    

}

+(void)showSuccessMessage:(NSString *)msg
{
    [self showMessage:msg];
}

+(void)showErrerMessage:(NSString *)msg
{
    [self showErrerMessage:msg];
    
}


+(void)showLoginMessage:(NSString *)msg
{
    //创建一个window
    _window =[[UIWindow alloc]init];
    _window.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, -WindowHeight);
    _window.hidden=NO;
    _window.backgroundColor=[UIColor blackColor];
    //设置Window 的级别为最高
    _window.windowLevel=UIWindowLevelAlert;
    
    //文字
    UILabel *label=[[UILabel alloc]init];
    label.frame=_window.bounds;
    label.text=msg;
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:12];
    [_window addSubview:label];
    
    //画圈
    UIActivityIndicatorView *IndicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [IndicatorView startAnimating];
    IndicatorView.frame=CGRectMake(0, 0, WindowHeight,WindowHeight);
    [_window addSubview:IndicatorView];
    
    //动画
    [UIView animateWithDuration:CRdelayTime animations:^{
        CGRect frame=_window.frame;
        frame.origin.y=0;
        _window.frame=frame;
    }];
    
}
@end
