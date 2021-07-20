# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

inhibit_all_warnings!

target 'DPTestProject_UIKit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'DPLibrary'
  
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["ONLY_ACTIVE_ARCH"] = "YES"
      if Gem::Version.new('9.0') > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end
end
