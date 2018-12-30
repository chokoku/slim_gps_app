# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'slim_gps_app' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  def testing_pods
    pod 'Quick'
    pod 'Nimble'
  end

  # Pods for slim_gps_app
  pod 'HydraAsync'
  pod 'Eureka'
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'Firebase/Auth'
  pod 'Firebase/Messaging'
  pod 'Firebase/Functions'
  pod 'Firebase/Performance'
  pod 'SlideMenuControllerSwift'
  pod 'GoogleMaps'
  pod 'GooglePlacePicker'
  pod 'GooglePlaces'
  pod 'FontAwesome.swift'
  pod 'SCLAlertView'
  pod 'pop', git: 'https://github.com/facebook/pop.git'
  pod 'PopupDialog'
  pod 'Fabric', '~> 1.9.0'
  pod 'Crashlytics', '~> 3.12.0'

  target 'slim_gps_appTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  target 'slim_gps_appUITests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

end
