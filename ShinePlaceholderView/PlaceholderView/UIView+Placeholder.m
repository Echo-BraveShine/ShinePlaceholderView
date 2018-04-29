
//  ShinePlaceholderView
//
//  Created by BraveShine on 2018/4/29.
//  Copyright © 2018年 BraveShine. All rights reserved.
//

#import "UIView+Placeholder.h"
#import <objc/runtime.h>

static char *PlaceholderViewKey = "PlaceholderViewKey";

@implementation UIView (Placeholder)

-(void)setPlaceholderView:(PlaceholderView *)placeholderView
{
    objc_setAssociatedObject(self, PlaceholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN);
}

-(PlaceholderView *)placeholderView
{
    PlaceholderView * view = objc_getAssociatedObject(self, PlaceholderViewKey);
    
    if (view == nil) {
        
        [self createPlaceholderView];
    }
    return view;
}

-(void)createPlaceholderView
{
    self.placeholderView = [[PlaceholderView alloc]initWithView:self];
    self.placeholderView.hidden = YES;
}


@end
