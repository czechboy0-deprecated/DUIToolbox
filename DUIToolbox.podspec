#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "DUIToolbox"
  s.version      = "0.1.0"
  s.summary      = "The DUIToolbox is a mini library of classes useful for iOS UIKit developers."
  s.description  = <<-DESC
                    The DUIToolbox is a mini library of classes useful for iOS UIKit developers.
                   DESC
  s.homepage     = "https://github.com/czechboy0/DUIToolbox"
  s.license      = 'MIT'
  s.author       = { "Honza Dvorsky" => "jan.dvorsky@yahoo.com" }
  s.source       = { :git => "https://github.com/czechboy0/DUIToolbox.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
end
