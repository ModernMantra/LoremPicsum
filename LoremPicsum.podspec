Pod::Spec.new do |s|

  s.name         = "LoremPicsum"

  s.version      = "1.0.0"

  s.summary      = "Simpler way to deal with UIImageView in Swift."

  s.homepage     = "http://github.com/modern_mantra”

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.source       = { :git => "https://github.com/ModernMantra/LoremPicsum", :tag => “1.0.0” }

  s.source_files  = "LoremPicsum", "LoremPicsum/**/*.{h,m,swift}"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

end
