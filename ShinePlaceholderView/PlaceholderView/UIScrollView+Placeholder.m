
//  ShinePlaceholderView
//
//  Created by BraveShine on 2018/4/29.
//  Copyright © 2018年 BraveShine. All rights reserved.
//

#import "UIScrollView+Placeholder.h"
#import "MJRefresh.h"
#import "UIView+Placeholder.h"

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



-(void)shine_executeReloadDataBlock
{
    [self shine_executeReloadDataBlock];
    
    NSInteger count = [self mj_totalDataCount];
    
    if (count == 0) {
        [self.placeholderView show];
    }else{
        [self.placeholderView dismiss];
    }
    
    if (self.mj_footer != nil) {
        
        if ([self.mj_footer isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
            
            MJRefreshAutoNormalFooter *footer  = (MJRefreshAutoNormalFooter *)self.mj_footer;
            
            [self layoutIfNeeded];
            
            if (self.contentSize.height < self.bounds.size.height) {
                
                footer.stateLabel.hidden = YES;
                
                footer.refreshingTitleHidden = YES;
                
            }else{
                footer.stateLabel.hidden = NO;
                
                footer.refreshingTitleHidden = NO;
            }
        }
    }
}

@end
