
//  ShinePlaceholderView
//
//  Created by BraveShine on 2018/4/29.
//  Copyright © 2018年 BraveShine. All rights reserved.
//

#import "PlaceholderView.h"
#import "MJRefresh.h"
@implementation PlaceholderViewConfiguration

+(instancetype)shareConfiguration
{
    static PlaceholderViewConfiguration *config = nil;
    if (config == nil) {
        config = [[self alloc]init];
    }
    return config;
}

-(NSArray<UIImage *> *)animationImages
{
    if (!_animationImages) {
        
        _animationImages = @[[UIImage imageNamed:@"placeholder_image_gif_1.png"],
                             [UIImage imageNamed:@"placeholder_image_gif_2.png"],
                             [UIImage imageNamed:@"placeholder_image_gif_3.png"],
                             [UIImage imageNamed:@"placeholder_image_gif_4.png"],
                             [UIImage imageNamed:@"placeholder_image_gif_5.png"],
                             [UIImage imageNamed:@"placeholder_image_gif_6.png"],
                             [UIImage imageNamed:@"placeholder_image_gif_7.png"],
                             [UIImage imageNamed:@"placeholder_image_gif_8.png"]];
    }
    return _animationImages;
}
-(UIColor *)placeholderColor
{
    if (!_placeholderColor){
        _placeholderColor = [UIColor darkGrayColor];
    }
    return _placeholderColor;
}
-(NSString *)placeholder
{
    if (!_placeholder) {
        _placeholder = @"正在加载中";
    }
    return _placeholder;
}

-(UIImage *)placeholderImage
{
    if (!_placeholderImage) {
        _placeholderImage = [UIImage imageNamed:@"placeholder_image_gif_1.png"];
    }
    return _placeholderImage;
}
-(PlaceholderViewType)type
{
    if (!_type) {
        _type = PlaceholderViewTypeImage;
    }
    return _type;
}

-(NSTimeInterval)animationDuration
{
    if (!_animationDuration) {
        _animationDuration = 1;
    }
    return _animationDuration;
}

@end

@implementation PlaceholderView

+(instancetype)create
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    PlaceholderView *placeholderView = [bundle loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    placeholderView.placeholderButton.titleLabel.numberOfLines = 0;
    placeholderView.placeholderButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:placeholderView action:@selector(placeholderImageClick:)];
    [placeholderView.placeholderImageView addGestureRecognizer:tap];
    return placeholderView;
}

+(instancetype)placeholderViewForView:(UIView *)view
{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (PlaceholderView *)subview;
        }
    }
    return nil;
}

+(void)hidenPlaceholderViewForView:(UIView *)view
{
    PlaceholderView *placeholderView = [self placeholderViewForView:view];
    if (placeholderView != nil) {
        [placeholderView dismiss];
    }
}

- (instancetype)init
{
    return [PlaceholderView create];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [PlaceholderView create];
    return self;
}
- (instancetype)initWithView:(UIView *)view
{
    self = [PlaceholderView create];
    self.parent = view;
    return self;
}

-(void)show
{
    if (!self.parent) {
        NSLog(@"PlaceholderView: parent == nil 请传入parent 或者通过 addSubview 方式添加到父视图上");
        return;
    }
    if (self.type == PlaceholderViewTypeAnimation) {
        [self startAnimation];
    }
    self.hidden = NO;
    [self.parent addSubview:self];
    [self.parent bringSubviewToFront:self];
}

-(void)dismiss
{
    if (self.type == PlaceholderViewTypeAnimation) {
        [self stopAnimation];
    }
    [self removeFromSuperview];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self.placeholderButton setTitle:placeholder forState:normal];
}

-(void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    self.placeholderImageView.image = placeholderImage;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self.placeholderButton setTitleColor:placeholderColor forState:normal];
}


-(void)setType:(PlaceholderViewType)type
{
    _type = type;
    
    if (type == PlaceholderViewTypeImage) {
        
        [self stopAnimation];
    }else if (type == PlaceholderViewTypeAnimation){
        
        [self startAnimation];
        
    }
    
}


- (IBAction)placeholderButtonClick:(UIButton *)sender
{
    if (self.textClickBlock) {
        
        self.textClickBlock();
    }
    
}
- (void)placeholderImageClick:(UITapGestureRecognizer *)sender
{
    if (self.imageClickBlock) {
        
        self.imageClickBlock();
    }
}

-(void)startAnimation
{
    
    self.placeholderImageView.animationImages = self.animationImages;
    self.placeholderImageView.animationDuration = self.animationDuration;
    self.placeholderImageView.animationRepeatCount = 0;
    [self.placeholderImageView startAnimating];
}

-(void)stopAnimation
{
    [self.placeholderImageView stopAnimating];
}

-(void)setOfset:(CGFloat)ofset
{
    //为了防止重复设置造成的ofset累加 所以每次设置之前都要减去上一次设置的
    if (!_ofset) {
        _ofset = 0;
    }
    
    CGFloat y = self.frame.origin.y - _ofset;
    _ofset = ofset;
    self.frame = CGRectMake(0, y + ofset, self.bounds.size.width, self.bounds.size.height - ofset);
}

-(void)defaultConfiguration
{
    PlaceholderViewConfiguration *config = [PlaceholderViewConfiguration shareConfiguration];
    if (!self.placeholder) {
        self.placeholder = config.placeholder;
    }
    if (!self.placeholderImage) {
        self.placeholderImage = config.placeholderImage;
    }
    
    if (!self.placeholderColor) {
        self.placeholderColor = config.placeholderColor;
    }
    
    if (!self.animationImages) {
        self.animationImages = config.animationImages;
    }
    
    if (!self.animationDuration) {
        self.animationDuration = config.animationDuration;
    }
    
    if (!self.type) {
        self.type = config.type;
    }
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
   
    if (newSuperview == nil) {
        return;
    }
    [self defaultConfiguration];

    self.parent = newSuperview;
    if (self.ofset) {
        
        self.frame = CGRectMake(0, self.ofset, newSuperview.bounds.size.width, newSuperview.bounds.size.height - self.ofset);
    }else{
        
        self.frame = newSuperview.bounds;
    }
}



@end
