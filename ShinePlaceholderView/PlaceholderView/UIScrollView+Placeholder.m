
//  ShinePlaceholderView
//
//  Created by BraveShine on 2018/4/29.
//  Copyright © 2018年 BraveShine. All rights reserved.
//

#import "UIScrollView+Placeholder.h"
#import "MJRefresh.h"
static char *showPlaceholderViewKey = "showPlaceholderViewKey";

@implementation UIScrollView (Placeholder)


+(void)load
{
    [self exchangeMethod];
}

+(void)exchangeMethod
{
    SEL sel = NSSelectorFromString(@"executeReloadDataBlock");
    
    if (!sel) {
        return;
    }
    
    Method firstMethod  =  class_getInstanceMethod([self class], sel);
    
    Method secondMethod = class_getInstanceMethod([self class], @selector(shine_executeReloadDataBlock));
    
    method_exchangeImplementations(firstMethod, secondMethod);
}


- (void)setShowPlaceholderView:(BOOL)showPlaceholderView
{
    objc_setAssociatedObject(self, showPlaceholderViewKey, @(showPlaceholderView), OBJC_ASSOCIATION_ASSIGN);
    
    if (showPlaceholderView == NO) {
        [self.placeholderView dismiss];
    }
}

-(BOOL)showPlaceholderView
{
    return ((NSNumber *)objc_getAssociatedObject(self, showPlaceholderViewKey)).boolValue;
}

-(void)shine_executeReloadDataBlock
{
    [self shine_executeReloadDataBlock];
    
    NSInteger count = [self mj_totalDataCount];
    
    if (count == 0 && self.showPlaceholderView == YES) {
        [self.placeholderView show];
    }else{
        [self.placeholderView dismiss];
    }
    
}

@end
