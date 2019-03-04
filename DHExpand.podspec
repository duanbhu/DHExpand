#
#  Be sure to run `pod spec lint DHExpand.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
    s.name         = "DHExpand"
    s.version      = "1.0.1"
    s.ios.deployment_target = '8.0'
    s.summary      = "简介"
    s.homepage     = "https://github.com/duanHuing/DHExpand"
    s.license      = "MIT"
    # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
    s.author             = { "duan" => "duanbhu@163.com" }
    s.source       = { :git => "https://github.com/duanHuing/DHExpand.git", :tag => "#{s.version}" }
    s.requires_arc = true
    s.default_subspec = 'Common'

    s.subspec 'Common' do |common|
        common.source_files = 'Classes/Common/**/*'
    end

    s.subspec 'DisplayTime' do |displayTime|
        displayTime.source_files = 'Classes/DisplayTime/**/*'
    end

end
