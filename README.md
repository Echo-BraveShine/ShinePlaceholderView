<img width="80" height="80" border-radius = "40" src="https://avatars0.githubusercontent.com/u/26161584?s=400&u=16aa790577ba20eedb394841b66d1fcfc300c3c1&v=4"/>

# ShinePlaceholderView
<img width="375" height="812" src="https://github.com/Echo-BraveShine/ShinePlaceholderView/blob/master/QQ20180513-181948-HD.gif"/>


### 安装ShinePlaceholderView
通过cocoapods安装
```ruby
pod 'ShinePlaceholderView'
```
### 默认配置可通过 [PlaceholderViewConfiguration shareConfiguration] 的属性进行修改
```objc
[PlaceholderViewConfiguration shareConfiguration].placeholder = @"PlaceholderView";
```

### 快捷使用
```objc
[self.view.placeholderView show];
```
### 设置图片类型
```objc
/**
UIImageView的显示样式

- PlaceholderImageTypeImage: 图片
- PlaceholderImageTypeGif: 动画
*/
typedef NS_ENUM(NSUInteger, PlaceholderImageType) {
    PlaceholderImageTypeImage,
    PlaceholderImageTypeGif,
};


self.view.placeholderView.type = PlaceholderImageTypeGif;//图片为GIF
```
### 设置PlaceholderView 的样式
```objc
/**
占位试图的显示样式

- PlaceholderViewModeDefault: 默认图片加文字
- PlaceholderViewModeText: 只有文字
- PlaceholderViewModeImage: 只有图片
*/
typedef NS_ENUM(NSUInteger, PlaceholderViewMode) {
    PlaceholderViewModeDefault,
    PlaceholderViewModeText,
    PlaceholderViewModeImage,
};

self.view.placeholderView.mode == PlaceholderViewModeImage;
```
### 设置距离顶部偏移量
```objc
self.view.placeholderView.offset = 200;
```
### 设置图片的宽高比
```objc
self.view.placeholderView.imageAspect = 0.75;
```
### 图片区域点击
```objc
self.view.placeholderView.imageClickCallBack = ^{
    NSLog(@"imageViewClick");
};
```
### 文字部分点击
```objc
self.view.placeholderView.textClickCallBack = ^{
    NSLog(@"textViewClick");
};
```
