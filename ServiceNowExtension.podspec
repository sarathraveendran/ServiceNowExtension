#
# Be sure to run `pod lib lint ServiceNowExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ServiceNowExtension'
  s.version          = '0.2.2'
  s.summary          = 'A ServiceNowExtension.'
  s.swift_version    = '4.2'
  
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A genric plugin which helps to post the incidents to the Service now wall.
  Once the admin verified it you will get the ticket updates through application.
                       DESC

  s.homepage         = 'https://github.com/SarathRaveendran/ServiceNowExtension'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sarath Raveendran' => 'sarathraveendran87@gmail.com' }
  s.source           = { :git => 'https://github.com/SarathRaveendran/ServiceNowExtension.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'ServiceNowExtension/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ServiceNowExtension' => ['ServiceNowExtension/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire'
  
end
