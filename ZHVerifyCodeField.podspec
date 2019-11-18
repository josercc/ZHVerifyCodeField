#
# Be sure to run `pod lib lint ZHVerifyCodeField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZHVerifyCodeField'
  s.version          = '0.2.0'
  s.summary          = '短信验证输入框的控件'
  s.description      = <<-DESC
一个十分简单的短信输入框验证的控件
                       DESC
  s.homepage         = 'https://github.com/josercc/ZHVerifyCodeField'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'josercc' => '15038777234@163.com' }
  s.source           = { :git => 'https://github.com/josercc/ZHVerifyCodeField.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Classes/**/*'
end
