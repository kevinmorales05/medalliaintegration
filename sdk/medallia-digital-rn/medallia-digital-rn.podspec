require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = package["name"]
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]
 
  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/medallia/Digital-iOS-SDK.git", :tag => "#{s.version}" }
  s.source_files = "ios/**/*.{h,m,mm,swift}"
 
  s.cocoapods_version   = '>= 1.10.1'
  s.vendored_frameworks = 'ios/libs/MedalliaDigitalSDK/MedalliaDigitalSDK.xcframework'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.dependency "React-Core"
end