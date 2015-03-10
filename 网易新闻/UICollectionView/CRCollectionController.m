//
//  CRCollectionController.m
//  网易新闻
//
//  Created by yosemite on 15/1/27.
//  Copyright (c) 2015年 caicoder. All rights reserved.
//

#import "CRCollectionController.h"
#import "CRCollectionViewCell.h"
@interface CRCollectionController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong)NSArray *urlList;
@end

@implementation CRCollectionController



- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnScroll) name:@"KeyreturnScrollerView" object:nil];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(jumptodetail) name:@"Keyjumptodetail" object:nil];
    
}

-(void)returnScroll
{
    self.collectionView.scrollEnabled=YES;
}
-(void)jumptodetail
{ 
    self.collectionView.scrollEnabled=NO;
    NSLog(@"----");
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
-(NSArray *)urlList
{
    if (_urlList==nil) {
        _urlList=[[NSArray alloc]init];
        NSURL * url=[[NSBundle mainBundle]URLForResource:@"NewsURLs.plist" withExtension:nil];
        _urlList=[NSArray arrayWithContentsOfURL:url];
    }
        return _urlList;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置布局
    self.layout.itemSize=self.view.bounds.size;
    self.layout.minimumInteritemSpacing=0;
    self.layout.minimumLineSpacing=0;
    self.layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    // scrollView的属性
    self.collectionView.pagingEnabled=YES;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    self.collectionView.showsVerticalScrollIndicator=YES;
   
}


#pragma mark <UICollectionViewDataSource>




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.urlList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor colorWithRed:((CGFloat)arc4random_uniform(256)/255.0) green:((CGFloat)arc4random_uniform(256)/255.0) blue:((CGFloat)arc4random_uniform(256)/255.0) alpha:1.0];
    cell.urlList=self.urlList[indexPath.item];
   
    return cell;
}

#pragma mark <UICollectionViewDelegate>


@end
