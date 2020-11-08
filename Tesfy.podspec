#
# Be sure to run `pod lib lint Tesfy.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Tesfy'
  s.version          = '1.0.1'
  s.summary          = 'A lightweight A/B Testing and Feature Flag Swift library focused on performance ⚡️'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Tesfy provides a simple but complete solution to develop A/B Tests and Feature Flags on both server and client side without relying in any storage layer. The main features of this library are:

  - Lightweight and focused on performance
  - Experiments
  - Feature Flags
  - Audience definition using jsonLogic
  - Traffic Allocation
  - Sticky Bucketing
  
                       DESC

  s.homepage         = 'https://github.com/tesfy/tesfy-swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gringox' => 'pedro.valdivieso@gmail.com' }
  s.source           = { :git => 'https://github.com/tesfy/tesfy-swift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  s.swift_version = '5.3'

  s.source_files = 'Tesfy/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Tesfy' => ['Tesfy/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MurmurHash-Swift', '1.0.13'
  s.dependency 'jsonlogic', '1.0.0'
end
