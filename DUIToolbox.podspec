Pod::Spec.new do |s|
  s.name         = "DUIToolbox"
  s.version      = "0.2.0"
  s.summary      = "The DUIToolbox is a mini library of classes useful for iOS UIKit developers."
  s.homepage     = "https://github.com/czechboy0/DUIToolbox"
  s.license      = 'MIT'
  s.author       = { "Honza Dvorsky" => "http://honzadvorsky.com" }
  s.source       = { :git => "https://github.com/czechboy0/DUIToolbox.git", :tag => s.version.to_s }
  s.social_media_url = "http://twitter.com/czechboy0"

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.requires_arc = true

  s.source_files = 'Classes/**/*.{h,m}'

  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'UIKit', 'Foundation'

  s.subspec 'UIKitPlus' do |ui|
    ui.source_files = 'Classes/UIKitPlus/*.{h,m}'
    ui.frameworks = 'UIKit'
  end

  s.subspec 'FoundationPlus' do |ns|
    ns.source_files = 'Classes/FoundationPlus/*.{h,m}'
    ns.frameworks = 'Foundation'
  end

end
