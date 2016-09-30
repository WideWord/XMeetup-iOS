# Uncomment this line to define a global platform for your project
platform :ios, '8.3'

target 'XMeetup' do
  use_frameworks!

  pod 'RxSwift', '~> 3.0.0-beta.1'
  pod 'RxCocoa', '~> 3.0.0-beta.1'

  pod 'ObjectMapper', '~> 2.0'
  pod 'Fakery', '~> 2.0'
  pod 'EasyPeasy', '~> 1.4'
  pod 'FormatterKit'
  pod 'SwiftMoment', :git => 'https://github.com/akosma/SwiftMoment.git', :branch => 'master'
  pod 'Eureka', '~> 2.0.0-beta.1'

  target 'XMeetupTests' do
    inherit! :search_paths
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
