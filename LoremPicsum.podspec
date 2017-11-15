Pod::Spec.new do |s|

  s.name         = "LoremPicsum"

  s.version      = "1.0.0"

  s.summary      = "Simpler way to deal with UIImageView in Swift."

  s.description  = <<-DESC
	Simple framework that simplifies the usage of UIImageView. Apply CIFilter right from the IOnterface Builder, or apply the blur affect and see the result without building the project.
                   DESC

  s.homepage     = "http://github.com/modern_mantra”

  s.license      = "MIT"

  s.source       = { :git => "https://github.com/ModernMantra/LoremPicsum", :tag => “1.0.0” }

  s.source_files  = "LoremPicsum", "LoremPicsum/**/*.{h,m,swift}"

  s.exclude_files = "Classes/Exclude"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

end
