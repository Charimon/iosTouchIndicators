Pod::Spec.new do |s|
  s.name = 'TouchIndicators'
  s.version = '0.0.1'
  s.platform = :ios
  s.ios.deployment_target = '6.0'
  s.prefix_header_file = 'TouchIndicators/TouchIndicators-Prefix.pch'
  s.source_files = 'TouchIndicators/*.{h,m,c}'
  s.requires_arc = true
end
