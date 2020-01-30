Pod::Spec.new do |spec|
  spec.name         = "IRAlertManager"
  spec.version      = "1.0.1"
  spec.summary      = "Alert manager for iOS."
  spec.description  = "Alert manager for iOS."
  spec.homepage     = "https://github.com/irons163/IRAlertManager.git"
  spec.license      = "MIT"
  spec.author       = "irons163"
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/irons163/IRAlertManager.git", :tag => spec.version.to_s }
  spec.source_files  = "IRAlertManager/Class/**/*.{h,m,xib}"
end