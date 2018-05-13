
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

- (NSArray<UIImage *> *)animationImages
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

-(UIColor *)placeholderTextColor
{
    if (!_placeholderTextColor){
        _placeholderTextColor = [UIColor darkGrayColor];
    }
    return _placeholderTextColor;
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
-(PlaceholderImageType)type
{
    if (!_type) {
        _type = PlaceholderImageTypeImage;
    }
    return _type;
}

-(PlaceholderViewMode)mode
{
    if (!_mode) {
        _mode = PlaceholderViewModeDefault;
    }
    return _mode;
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
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.parent = view;
        [self setupViews];
    }
    return self;
}

-(UIImageView *)placeholderImageView
{
    if (!_placeholderImageView) {
        _placeholderImageView = [[UIImageView alloc]init];
        _placeholderButton.contentMode = 2;
        _placeholderImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _placeholderImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(placeholderImageClick:)];
        [_placeholderImageView addGestureRecognizer:tap];
    }
    return _placeholderImageView;
}

-(UIButton *)placeholderButton
{
    if (!_placeholderButton) {
        _placeholderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _placeholderButton.titleLabel.numberOfLines = 0;
        _placeholderButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _placeholderButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _placeholderButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_placeholderButton addTarget:self action:@selector(placeholderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeholderButton;
}


-(void)setupViews
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.placeholderImageView];
    [self addSubview:self.placeholderButton];
}

-(void)show
{
    if (!self.parent) {
        NSLog(@"PlaceholderView: parent == nil 请传入parent 或者通过 addSubview 方式添加到父视图上");
        return;
    }
    if (self.type == PlaceholderImageTypeGif) {
        [self startAnimation];
    }
    self.hidden = NO;
    [self.parent addSubview:self];
    [self.parent bringSubviewToFront:self];
    [self updateConstraints];
    [self layoutIfNeeded];
}

-(void)dismiss
{
    if (self.type == PlaceholderImageTypeGif) {
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

-(void)setPlaceholderTextColor:(UIColor *)placeholderTextColor
{
    _placeholderTextColor = placeholderTextColor;
    [self.placeholderButton setTitleColor:placeholderTextColor forState:normal];
}

-(void)setType:(PlaceholderImageType)type
{
    _type = type;
    
    if (self.superview == nil) {
        return;
    }
    
    if (type == PlaceholderImageTypeImage) {
        [self stopAnimation];
    }else if (type == PlaceholderImageTypeGif){
        [self startAnimation];
    }
    
}

-(void)setMode:(PlaceholderViewMode)mode
{
    _mode = mode;
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    if (mode == PlaceholderViewModeText) {
        [self addSubview:self.placeholderButton];
    }else if (mode == PlaceholderViewModeImage) {
        [self addSubview:self.placeholderImageView];
    }else{
        [self addSubview:self.placeholderImageView];
        [self addSubview:self.placeholderButton];
    }
    [self updateConstraints];
}


- (void)placeholderButtonClick:(UIButton *)sender
{
    if (self.textClickCallBack) {
        self.textClickCallBack();
    }
    
}
- (void)placeholderImageClick:(UITapGestureRecognizer *)sender
{
    if (self.imageClickCallBack) {
        self.imageClickCallBack();
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

-(void)setOffset:(CGFloat)offset
{
    if (_offset == offset) {
        return;
    }
    _offset = offset;
    if (self.offsetConstraint && self.superview) {
        self.offsetConstraint.constant = offset;
    }
}

-(void)setImageAspect:(CGFloat)imageAspect
{
    if (_imageAspect == imageAspect) {
        return;
    }
    _imageAspect = imageAspect;
    if (self.imageAspectRatioConstraint && self.parent) {
        [self.placeholderImageView removeConstraint:self.imageAspectRatioConstraint];
        NSLayoutConstraint *imageAspectConstraint = [NSLayoutConstraint constraintWithItem:self.placeholderImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.placeholderImageView attribute:NSLayoutAttributeWidth multiplier:imageAspect constant:0];
        [self.placeholderImageView addConstraint:imageAspectConstraint];
        self.imageAspectRatioConstraint = imageAspectConstraint;
        [self layoutIfNeeded];
    }
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
    
    if (!self.placeholderTextColor) {
        self.placeholderTextColor = config.placeholderTextColor;
    }
    
    if (!self.animationImages) {
        self.animationImages = config.animationImages;
    }
    
    if (!self.animationDuration) {
        self.animationDuration = config.animationDuration;
    }else{
        self.animationDuration = self.animationDuration;
    }
    
    if (!self.type) {
        self.type = config.type;
    }else{
        self.type = self.type;
    }
    
    if (!self.mode) {
        self.mode = config.mode;
    }
    
    if (!self.offset) {
        if (!config.offset) {
            self.offset = self.parent.bounds.size.height/4;
        }else{
            self.offset = config.offset;
        }
    }
    
    if (!self.imageAspect) {
        if (!config.imageAspect) {
            self.imageAspect = 0.75;
        }else{
            self.imageAspect = config.imageAspect;
        }
    }
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview == nil) {
        return;
    }
    self.parent = newSuperview;
    self.hidden = NO;
    [self defaultConfiguration];

}



-(void)updateConstraints
{
    
    if (self.superview == nil) {
        [super updateConstraints];
        return;
    }
    
    NSLayoutConstraint *contentCenterX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.parent attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *contentTop = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.parent attribute:NSLayoutAttributeTop multiplier:1 constant:self.offset];
    self.offsetConstraint = contentTop;
    NSLayoutConstraint *contentWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.parent attribute:NSLayoutAttributeWidth multiplier:0.75 constant:0];
    
    [self.parent addConstraint:contentCenterX];
    [self.parent addConstraint:contentTop];
    [self.parent addConstraint:contentWidth];
    
    if (self.mode == PlaceholderViewModeDefault || self.mode == PlaceholderViewModeImage) {
        UIImageView *placeholderImageView = self.placeholderImageView;
        
        NSLayoutConstraint *imageAspect = [NSLayoutConstraint constraintWithItem:placeholderImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:placeholderImageView attribute:NSLayoutAttributeWidth multiplier:0.75 constant:0];
        [placeholderImageView addConstraint:imageAspect];
        self.imageAspectRatioConstraint = imageAspect;
        
        NSLayoutConstraint *imageViewTop = [NSLayoutConstraint constraintWithItem:placeholderImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        [self addConstraint:imageViewTop];
        
        NSLayoutConstraint *imageViewLeft = [NSLayoutConstraint constraintWithItem:placeholderImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
        [self addConstraint:imageViewLeft];
        
        NSLayoutConstraint *imageViewRight = [NSLayoutConstraint constraintWithItem:placeholderImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
        [self addConstraint:imageViewRight];
        
        if (self.mode == PlaceholderViewModeImage) {
            NSLayoutConstraint *placeholderBottom = [NSLayoutConstraint constraintWithItem:placeholderImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
            
            [self addConstraint:placeholderBottom];
        }
    }
    
    if (self.mode == PlaceholderViewModeDefault || self.mode == PlaceholderViewModeText) {
        UIButton *placeholderButton = self.placeholderButton;
        NSLayoutConstraint *btnLeft = [NSLayoutConstraint constraintWithItem:placeholderButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
        [self addConstraint:btnLeft];
        
        NSLayoutConstraint *btnRight = [NSLayoutConstraint constraintWithItem:placeholderButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
        [self addConstraint:btnRight];
        
        NSLayoutConstraint *btnBottom = [NSLayoutConstraint constraintWithItem:placeholderButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
        [self addConstraint:btnBottom];
        
        if (self.mode == PlaceholderViewModeText) {
            NSLayoutConstraint *btnTop = [NSLayoutConstraint constraintWithItem:placeholderButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
            [self addConstraint:btnTop];
        }else{
            NSLayoutConstraint *btnTop = [NSLayoutConstraint constraintWithItem:placeholderButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.placeholderImageView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
            [self addConstraint:btnTop];
        }
    }
    [super updateConstraints];
}

@end
