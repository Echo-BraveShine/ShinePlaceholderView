
//  ShinePlaceholderView
//
//  Created by BraveShine on 2018/4/29.
//  Copyright © 2018年 BraveShine. All rights reserved.
//

#import "UIView+Placeholder.h"
#import <objc/runtime.h>

static char *PlaceholderViewKey = "PlaceholderViewKey";

static char *hiddenPlaceholderViewKey = "hiddenPlaceholderViewKey";

@implementation UIView (Placeholder)

-(void)setHiddenPlaceholderView:(BOOL)hiddenPlaceholderView
{
    objc_setAssociatedObject(self, hiddenPlaceholderViewKey, @(hiddenPlaceholderView), OBJC_ASSOCIATION_ASSIGN);
    
    if (hiddenPlaceholderView == YES) {
        [self.placeholderView dismiss];
    }
}

-(BOOL)hiddenPlaceholderView
{
    return ((NSNumber *)objc_getAssociatedObject(self, hiddenPlaceholderViewKey)).boolValue;
}

-(void)setPlaceholderView:(PlaceholderView *)placeholderView
{
    objc_setAssociatedObject(self, PlaceholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN);
}

-(PlaceholderView *)placeholderView
{
    PlaceholderView * view = objc_getAssociatedObject(self, PlaceholderViewKey);
    
    if (view == nil && self.hiddenPlaceholderView == NO) {
        view = [[PlaceholderView alloc]initWithView:self];
        view.hidden = YES;
        self.placeholderView = view;
    }
    return view;
}




@end
