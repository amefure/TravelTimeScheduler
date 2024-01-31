# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TravelTimeScheduler' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TravelTimeScheduler
  pod 'Google-Mobile-Ads-SDK'
  pod 'FirebaseAnalytics'
  pod 'FirebaseAuth'
  pod 'FirebaseDatabase'
  pod 'GoogleSignIn'
  pod 'RealmSwift' 
  pod 'FirebaseStorage'

  target 'TravelTimeSchedulerTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Google-Mobile-Ads-SDK'
    pod 'FirebaseAnalytics'
    pod 'FirebaseAuth'
    pod 'FirebaseDatabase'
    pod 'GoogleSignIn'
    pod 'RealmSwift' 
    pod 'FirebaseStorage'
  end

  target 'TravelTimeSchedulerUITests' do
    # Pods for testing
    pod 'Google-Mobile-Ads-SDK'
    pod 'FirebaseAnalytics'
    pod 'FirebaseAuth'
    pod 'FirebaseDatabase'
    pod 'GoogleSignIn'
    pod 'RealmSwift' 
    pod 'FirebaseStorage'
  end

end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
  end
end
