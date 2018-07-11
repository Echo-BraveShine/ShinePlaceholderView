#
#  Be sure to run `pod spec lint ShinePlaceholderView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ShinePlaceholderView"
  s.version      = "1.1.2"
  s.summary      = "轻量级占位试图"
  s.description  = <<-DESC
        轻量级占位试图  列表页自动显示
                   DESC
  s.homepage     = "https://github.com/Echo-BraveShine/ShinePlaceholderView"
  s.license      = "MIT"
  s.author             = { "Echo-BraveShine" => "1239383708@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Echo-BraveShine/ShinePlaceholderView.git", :tag => "#{s.version}" }
  s.source_files  = "ShinePlaceholderView/PlaceholderView/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.resources = "ShinePlaceholderView/PlaceholderView/*.{png,xib,plist}"
  s.framework  = "UIKit"
  s.dependency "MJRefresh"

end
