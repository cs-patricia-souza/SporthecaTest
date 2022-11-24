# Uncomment the next line to define a global platform for your project
platform :ios, '14.1'
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/ZaigCoding/iOS.git'
target 'SporthecaTest' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # ignore all warnings from all pods
  inhibit_all_warnings!
  # Pods for SporthecaTest
  pod 'Kingfisher','6.0.1'
  pod 'SwiftyJSON', '4.1.0'
  pod 'SwiftLint'

end
post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.1'
    end
  end
end
