//
//  ViewController.m
//  ShinePlaceholderView
//
//  Created by BraveShine on 2018/4/29.
//  Copyright © 2018年 BraveShine. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+Placeholder.h"
#import "UIView+Placeholder.h"

#import "DefaultViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) NSArray *selectors;

@end

@implementation ViewController

-(NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"UIView",@"UITableView",@"UICollectionView"];
    }
    return _dataSource;
}
-(NSArray *)selectors
{
    if (!_selectors) {
        _selectors = @[@"defaultViewController",@"tableViewViewController",@"collectionViewViewController"];
    }
    return _selectors;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SEL selector = NSSelectorFromString(self.selectors[indexPath.row]);
    
    [self performSelector:selector withObject:nil];
}

-(void)defaultViewController
{
    DefaultViewController *vc = [[DefaultViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)tableViewViewController
{
    TableViewController *vc = [[TableViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)collectionViewViewController
{
    CollectionViewController *vc = [[CollectionViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:true];
}
@end
