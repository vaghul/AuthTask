# Uncomment this line to define a global platform for your project
# platform :ios, ‘9.1’

use_frameworks!
target 'AuthTask' do
  # Uncomment this line if you're using Swift or would like to use dynamic frameworks
pod 'Kingfisher'
pod 'Alamofire'

# Pods for AuthTask

end
post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['ENABLE_BITCODE'] = 'NO'
		end
	end
end
