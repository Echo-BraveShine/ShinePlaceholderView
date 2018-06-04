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

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.showPlaceholderView = YES;

    self.tableView.tableFooterView = [UIView new];

}

@end
