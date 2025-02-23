# Define minimum deployment target - using a more recent iOS version
platform :ios, '13.0'  # Updated from '9.0' for better compatibility

# Uncomment the following line if you want to use M1 simulator
# $iOSSimulatorArm64 = true

target 'Sample' do
  use_frameworks!
  
  # Networking
  pod 'Alamofire', '~> 5.6'
  
  # Add configuration to handle common build issues
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        # Ensure pods support the minimum deployment target
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        
        # Fix potential build issues
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        
        # Fix potential warnings for EXCLUDED_ARCHS
        config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
        
        # Enable relative path references
        config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = 'YES'
      end
    end
  end
end
