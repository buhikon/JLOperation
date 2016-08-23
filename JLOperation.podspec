#
# Be sure to run `pod lib lint JLOperation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JLOperation'
  s.version          = '0.1.0'
  s.summary          = 'NSOperation with async task and callbacks.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = This library is based on NSOperation. Some useful functionality is added, such as async operations and callback by block or delegate.

  s.homepage         = 'https://github.com/buhikon/JLOperation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Joey L.' => 'slarinz@gmail.com' }
  s.source           = { :git => 'https://github.com/buhikon/JLOperation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'JLOperation/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JLOperation' => ['JLOperation/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
