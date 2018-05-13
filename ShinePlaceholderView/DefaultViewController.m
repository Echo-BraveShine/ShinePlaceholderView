//
//  DefaultViewController.m
//  ShinePlaceholderView
//
//  Created by BraveShine on 2018/5/13.
//  Copyright © 2018年 BraveShine. All rights reserved.
//

#import "DefaultViewController.h"
#import "UIView+Placeholder.h"
@interface DefaultViewController ()

@end

@implementation DefaultViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view.placeholderView show];
    

    self.view.placeholderView.imageClickCallBack = ^{
        NSLog(@"imageViewClick");
    };
    
    self.view.placeholderView.textClickCallBack = ^{
        NSLog(@"textViewClick");
    };

    
    NSArray *array1 = @[@"changeType",@"changeMode",@"changeOffset",@"changeImageAspect"];
    NSArray *array2 = @[@"Type",@"Mode",@"Offset",@"ImageAspect"];

    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger i = 0 ; i<array1.count ; i++) {
        NSString *sel = array1[i];
        SEL selector = NSSelectorFromString(sel);
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:array2[i] style:0 target:self action:selector];
        [items addObject:item];
    }
    self.navigationItem.rightBarButtonItems = items;
}

-(void)changeType
{
    self.view.placeholderView.type = self.view.placeholderView.type == PlaceholderImageTypeImage ? PlaceholderImageTypeGif : PlaceholderImageTypeImage;
}
-(void)changeMode
{
    if (self.view.placeholderView.mode == PlaceholderViewModeImage) {
        self.view.placeholderView.mode = PlaceholderViewModeDefault;
    }else{
        self.view.placeholderView.mode ++ ;
    }
}
-(void)changeOffset
{
    self.view.placeholderView.offset = self.view.placeholderView.offset == 200 ? 300 : 200;
}

-(void)changeImageAspect
{
    self.view.placeholderView.imageAspect = self.view.placeholderView.imageAspect == 0.75 ? 1.0 : 0.75;
}

@end
