#MedalliaDigitalSDK
Pod::Spec.new do |s|
  s.name             = 'MedalliaDigitalSDK'
  s.version          = '4.0.0'
  s.summary          = 'MedalliaDigitalSDK'
 
  s.description      = <<-DESC
  Collect real-time customer feedback across digital channels, including web, mobile and in-app
                       DESC

  s.homepage         = 'http://www.medallia.com/solutions/digital'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MedalliaDigital' => 'DigitalMobileSupport@medallia.com' }
  s.source           = { :path => './MedalliaDigitalSDK.xcframework' }

  s.ios.deployment_target = '8.0'
  s.ios.vendored_frameworks = 'MedalliaDigitalSDK.xcframework'
end
