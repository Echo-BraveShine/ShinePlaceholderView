//
//  TableViewController.m
//  ShinePlaceholderView
//
//  Created by BraveShine on 2018/5/13.
//  Copyright © 2018年 BraveShine. All rights reserved.
//

#import "TableViewController.h"
#import "UIScrollView+Placeholder.h"
//#import "Masonry.h"
@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)BOOL showCell;

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation TableViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.tableView.showPlaceholderView = YES;

    self.tableView.tableFooterView = [UIView new];
    self.tableView.placeholderView.animationDuration = 2.0;
    
    self.tableView.placeholderView.animationImages = @[[UIImage imageNamed:@"placeholder_loading_gif_01"],[UIImage imageNamed:@"placeholder_loading_gif_02"],[UIImage imageNamed:@"placeholder_loading_gif_03"],[UIImage imageNamed:@"placeholder_loading_gif_04"],];
    
    self.tableView.placeholderView.type = PlaceholderImageTypeGif;
    self.tableView.placeholderView.mode = PlaceholderViewModeImage;
    self.tableView.placeholderView.placeholderImageView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.tableView];
  

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(itemClick)];
}

-(void)itemClick
{
    self.tableView.placeholderView.imageAspect = self.tableView.placeholderView.imageAspect == 0.75 ? 1.0 : 0.75;

//    self.showCell = !self.showCell;
//
//    [self.tableView reloadData];
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
