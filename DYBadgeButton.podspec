#
# Be sure to run `pod lib lint DYBadgeButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DYBadgeButton'
  s.version          = '0.3.6'
  s.summary          = 'UI Button with an animated badge, written in Swift 4'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    DYBadgeButton features a UIButton with a pop up badge. If the string value of the badge changes from nil (or "nullish") to a valid string value  at runtime the badge will appear with a pop up effect. If it switches back to a "nullish" value, it will shrink and disappear.
    The class also includes a class function to create a button with an image and a title, which is positioned underneath the image.
                       DESC

  s.homepage         = 'https://github.com/DominikButz/DYBadgeButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dominikbutz' => 'dominikbutz@gmail.com' }
  s.source           = { :git => 'https://github.com/DominikButz/DYBadgeButton.git', :tag => s.version.to_s }


  s.ios.deployment_target = '9.3'

  s.source_files = 'DYBadgeButton/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DYBadgeButton' => ['DYBadgeButton/Assets/*.png']
  # }

  s.public_header_files = 'DYBadgeButton/Classes/**/*.h'

end
