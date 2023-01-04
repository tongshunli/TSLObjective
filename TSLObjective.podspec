#
# Be sure to run `pod lib lint TSLObjective.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TSLObjective'
  s.version          = '0.1.3'
  s.summary          = 'Common methods of Objective-C and macro definition encapsulation.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Common methods and UI controls are encapsulated to facilitate external calls'
  s.homepage         = 'https://github.com/tongshunli/TSLObjective'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tongshunli' => '13466621196@163.com' }
  s.source           = { :git => 'https://github.com/tongshunli/TSLObjective.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'TSLObjective/Classes/**/*'
  
  s.resource_bundles = {
    'TSLObjective' => ['TSLObjective/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Masonry'
end
