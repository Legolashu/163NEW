//
//  HeadLineTableViewController.m
//  网易新闻
//
//  Created by yosemite on 15/1/24.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import "HeadLineTableViewController.h"
#import "HeadlineCell.h"
#import "CRheadModel.h"
#import "CRRequestManger.h"
#import "DetailNewcontroller.h"

@interface HeadLineTableViewController ()
@property (nonatomic,strong)NSArray * newsList;

@end

@implementation HeadLineTableViewController

-(void)setUrlList:(NSDictionary *)urlList
{

    self.navigationItem.title=urlList[@"title"];
  //  @"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html"
    //@"nc/article/headline/T1348647853363/0-20.html"
    [[[CRRequestManger manager]GET:[NSString stringWithFormat:@"http://c.m.163.com%@",urlList[@"urlString"]]  parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        //NSLog(@"%@",responseObject);
        //  将字典中的第一项内容（数组）拿出来，直接使用字符串不够灵活
        // NSLog(@"%@",responseObject[@"T1348647853363"]);
        // NSEnumerator 是一个计数器， 苹果的forin 底层就是使用NSEnumerator 开发的
        
        NSString *key =[responseObject.keyEnumerator nextObject];
        //获取数组
        //   NSLog(@"%@",responseObject[key]);
        // [responseObject writeToFile:@"/Users/yosemite/Desktop/122.plist"atomically:YES];
        
        /**
         字典转模型
         */
        //     [self logInfoWithDict:responseObject [key][0]];
        NSArray *dataList=responseObject[key];
        NSMutableArray * arrayM=[NSMutableArray arrayWithCapacity:dataList.count];
        [dataList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [arrayM addObject:[CRheadModel CRheadModelWithDict:obj]];
            
        }];
        self.newsList=arrayM;
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }] resume];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
 
}
//  跳转时的准备工作
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
     NSUInteger  row=self.tableView.indexPathForSelectedRow.row;
    CRheadModel *model=self.newsList[row];
    
    DetailNewcontroller * controller=segue.destinationViewController;
    controller.headmodel=model;
    
}



-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsList.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRheadModel *model=self.newsList[indexPath.row];
    NSString *ID=[HeadlineCell cellIdWithModel:model];
    HeadlineCell *cell=[tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.headModel =model;

  
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRheadModel * model=self.newsList[indexPath.row];
    CGFloat Height=[HeadlineCell rowHeightWithModel:model];
    return Height;
}


@end
