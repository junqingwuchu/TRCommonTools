
Pod::Spec.new do |s|

  s.name         = "TRCommonTools"
  s.version      = "0.0.1"
  s.ios.deployment_target = "8.0"
  s.summary      = "开发各种实用工具.^_^"
  s.homepage     = "https://github.com/junqingwuchu/TRCommonTools"
  s.license      = "MIT"
  s.requires_arc = true
  s.author             = { "Tracky" => "302855862@qq.com" }
  s.social_media_url   = "https://github.com/junqingwuchu"

  s.source       = { :git => 'https://github.com/junqingwuchu/TRCommonTools.git', :tag => "v#{s.version}"}
  s.source_files = 'TRFPS/*.{h,m}'

end
