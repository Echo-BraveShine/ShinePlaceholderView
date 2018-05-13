//
//  CollectionViewController.m
//  ShinePlaceholderView
//
//  Created by BraveShine on 2018/5/13.
//  Copyright © 2018年 BraveShine. All rights reserved.
//

#import "CollectionViewController.h"
#import "MJRefresh.h"
@interface CollectionViewController ()

@property (nonatomic,assign) NSInteger count;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";


-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 150);
    
    layout.minimumLineSpacing = 10;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"清空" style:0 target:self action:@selector(clearData)];
}

-(void)loadData
{
    self.count = 10;
    
    [self.collectionView reloadData];
    
    [self.collectionView.mj_header endRefreshing];
}

-(void)clearData
{
    self.count = 0;
    
    [self.collectionView reloadData];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}


@end
