//
//  DetailNewcontroller.m
//  网易新闻
//
//  Created by yosemite on 15/1/24.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import "DetailNewcontroller.h"
#import "CRheadModel.h"
#import "CRRequestManger.h"
#import "CRNewsDetail.h"
#import "CRimgModel.h"

@interface DetailNewcontroller ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property (nonatomic,strong)CRNewsDetail *detail;

@end

@implementation DetailNewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title =@"新闻详情";
   //设置webview 的代理是本身
 //   self.WebView.delegate=self;@"KeyreturnScrollerView"
    
     [[NSNotificationCenter defaultCenter ]postNotificationName:@"Keyjumptodetail" object:nil];
    
   
    
        // 发送一个GET请求 获得 新闻的详情数据
        // http://c.m.163.com/nc/article/{docid}/full.html
        NSString * url=[NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.headmodel.docid];
        [[CRRequestManger manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.detail=[CRNewsDetail detailWithDict:responseObject[self.headmodel.docid]];
        [self showNewDetail];
            }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@" failure %@",error);
            } ];
    self.WebView.delegate=self;
}
-(void)viewWillDisappear:(BOOL)animated
{
     [[NSNotificationCenter defaultCenter ]postNotificationName:@"KeyreturnScrollerView" object:nil];
}

/**
    显示新闻详情数据
 
 */
-(void)showNewDetail
{
    NSMutableString * html=[NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle]URLForResource:@"html.css" withExtension:nil] ];
     //具体内容
     [html appendString:@"<body>"];
     
     //将图片插入body对应的标记中 比如<!--IMG#0-->
     [html appendString:[self setbody]];
     
     [html appendString:@"</body>"];
     
     //尾部内容
     [html appendString:@"</html>"];
     //显示网页
    [self.WebView loadHTMLString:html baseURL:nil];
}

-(NSString *)setbody
{
    NSMutableString * body=[NSMutableString string];
    
    //拼接标题
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detail.title];

    [body appendFormat:@"<div class=\"time\">%@</div>",self.detail.ptime];
    //拼接图片
    [body appendString:self.detail.body];
    
    for (CRimgModel *img in self.detail.img) {
        //图片中的HTML字符串
        NSMutableString *imaghtml=[NSMutableString string];
        [imaghtml appendString:@"<div class=\"img-parent\">"];
        //img.pixel=500*332
        NSArray *pixel=[img.pixel componentsSeparatedByString:@"*"];
        int width=[[pixel firstObject]intValue];
        int height=[[pixel lastObject]intValue];
        int maxWidth=[UIScreen mainScreen].bounds.size.width*0.8;
        if (width>maxWidth) {
            height=height*maxWidth/width;
            width=maxWidth;
        }
        /**
         *  通用URL的设计
         *  协议固定：hm：
           一般有2个参数
         1> 方法名：method
         2> 方法参数 param
         */
        NSString *onload=@"this.onclick = function() {"
                            " window.location.href = 'hm:saveImageToAlbum:&'+this.src;"
                            "};";
        [imaghtml appendFormat:@"<img onload =\"%@\" width=\"%d\" height=\"%d\" src=\"%@\">",onload,width,height,img.src];
        [imaghtml appendString:@"</div>"];
        [body replaceOccurrencesOfString:img.ref withString:imaghtml options:NSCaseInsensitiveSearch range:NSMakeRange(0,body.length)];
        
    }
    return body;
}


#pragma  mark -<UIWebViewDelegate>
/**
 *  每当webView 发送一个请求之前 都会调用这个方法
 * @param request 即将发送的请求
 * @return Yes 允许发送这个请求 NO 禁止发送这个请求
 */

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *url=request.URL.absoluteString;
    
    NSRange rang=[url rangeOfString:@"hm:"];
   // NSLog(@"%tu",rang.location);
    if (rang.location!=NSNotFound) {
        NSUInteger loc=rang.location+rang.length;
        NSString * path=[url substringFromIndex:loc];
        //获取方法和参数
        NSArray *methodeNameAndParam=[path componentsSeparatedByString:@"&"];
        //方法名
        NSString *methodName=[methodeNameAndParam firstObject];
        //调用方法
        SEL selector=NSSelectorFromString(methodName);
        if ([self respondsToSelector:selector]) {// 判断方法的目的  方法名不正确而报错
            
            NSMutableArray  * params=nil;
            if (methodeNameAndParam.count>1) {//方法有参数
                params=[NSMutableArray arrayWithArray:methodeNameAndParam];
                //从数组中去掉方法名
                [params removeObjectAtIndex:0];
                NSLog(@"%@",params[0]);
            }
            [self performSelector:selector withObject:params];
        }
        return NO;
    }
    return YES;
}
- (void)shutdown
{
    NSLog(@"shutdown-----");
}

//  将图片保存在相册中
-(void)saveImageToAlbum:(NSArray
                         *)src
{
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"友情提示" message:@"您是否将相片保存到相册？" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        // UIWebView 的缓存中取得图片
        NSURLCache  * Cache=[NSURLCache sharedURLCache];
        NSLog(@"%@---",src);
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:src[0]]];
        NSData *imgData=[Cache cachedResponseForRequest:request].data;
        
        //保存图片
        UIImage *image=[UIImage imageWithData:imgData];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }]];
    
     [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
                              
}
@end
