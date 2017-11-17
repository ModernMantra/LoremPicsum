Pod::Spec.new do |s|

  s.name         = 'LoremPicsum'

  s.version      = '1.0.0'

  s.summary      = 'Simpler way to deal with UIImageView in Swift.'

  s.homepage     = 'http://github.com/modernmantra'

  s.author       = { 'Kerim Njuhovic' => 'modern_mantra@hotmail.com' }

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.source       = { :git => 'https://github.com/ModernMantra/LoremPicsum.git', :tag => s.version.to_s }

  s.source_files  = ['LoremPicsum/Classes/**/*']

  s.ios.deployment_target = '8.0'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

end
