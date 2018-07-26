
Pod::Spec.new do |s|
  s.name         = "SwiGradientTransition"
  
  s.version      = "1.0.0"

  s.summary      = "Colors transition"

  s.description  = <<-DESC
  It is a SwiGradientTransition used on iOS, which implement by Swift.
  DESC

  s.homepage     = "https://github.com/elroy-swi/SwiGradientTransition"

  s.license      = "MIT"

  s.author       = { "elroy-swi" => "swi.elroy@gmail.com" }

  s.platform     = :ios, "9.0"

  s.swift_version = '4.1'

  s.requires_arc = true

  s.source       = { :git => "https://github.com/elroy-swi/SwiGradientTransition.git", :branch => "master", :tag => s.version }

  s.source_files = "SwiGradientTransition/**/*.swift"

  s.frameworks = "UIKit"

  s.dependency "EasyPeasy", "~> 1.7.0"

end
