//
//  TableViewController.m
//  ShinePlaceholderView
//
//  Created by BraveShine on 2018/5/13.
//  Copyright © 2018年 BraveShine. All rights reserved.
//

#import "TableViewController.h"
#import "UIScrollView+Placeholder.h"
@interface TableViewController ()

@property (nonatomic,assign)BOOL showCell;


@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.showPlaceholderView = YES;
    
    self.tableView.tableFooterView = [UIView new];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 600)];
    
    header.backgroundColor = [UIColor redColor];
    
    self.tableView.tableHeaderView = header;
    
    self.tableView.placeholderView.offset = self.tableView.tableHeaderView.bounds.size.height + 20;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(itemClick)];
}

-(void)itemClick
{
    self.showCell = !self.showCell;
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.showCell ? 10 : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    return cell;
}

@end
