#
# Be sure to run `pod lib lint KDNotification.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KDNotification'
  s.version          = '0.1.4'
  s.summary          = 'Notifications and toasts made simple.'

  s.description      = <<-DESC
KDNotification is a lightweight framework to show and interact with notifications and toast in your application. The general style is inspired by iOS 10 notifications.

    DESC

  s.homepage         = 'https://github.com/kekedandois/KDNotification'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kéké Dandois' => 'keke.dandois@icloud.com' }
  s.source           = { :git => 'https://github.com/kekedandois/KDNotification.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kekedandois'

  s.ios.deployment_target = '8.0'

s.source_files = 'KDNotification/Classes/**/*.{h,m}'

  s.resource_bundles = {
'KDNotification' => ['KDNotification/Classes/**/*.{xib}']
  }

end
