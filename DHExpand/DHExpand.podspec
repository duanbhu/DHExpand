#
#  Be sure to run `pod spec lint DHExpand.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
    s.name         = "DHExpand"
    s.version      = "1.0.2"
    s.ios.deployment_target = '8.0'
    s.summary      = "一些常用的代码，UIAlertController封装、时间戳格式化、app更新提示、按钮获取验证码的倒计时"
    s.homepage     = "https://github.com/duanHuing/DHExpand"
    s.license      = "MIT"
    # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
    s.author             = { "duan" => "duanbhu@163.com" }
    s.source       = { :git => "https://github.com/duanHuing/DHExpand.git", :tag => "#{s.version}" }
    s.requires_arc = true
    s.default_subspec = 'Common'

    s.subspec 'Common' do |ss|
        ss.source_files = 'Classes/Common/**/*'
    end

    s.subspec 'DisplayTime' do |ss|
        ss.source_files = 'Classes/DisplayTime/**/*'
    end

    s.subspec 'VerificationCode' do |ss|
        ss = 'Classes/VerificationCode/**/*'
    end

    s.subspec 'UpdateApp' do |ss|
        ss = 'Classes/UpdateApp/**/*'
    end

end
