
Pod::Spec.new do |s|
  s.name         = "APCoreDataKit"
  s.version      = "1.0.0"
  s.summary      = "A lightweight helper library that reduces the boilerplate involved with Core Data setup and work."
  s.description  = <<-DESC
  A lightweight helper library that reduces the boilerplate involved with Core Data setup and work.
                   DESC

  s.homepage     = "https://github.com/paleksandrs/APCoreDataKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       =   "Aleksandrs Proskurins"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/paleksandrs/APCoreDataKit.git", :tag => "1.0.0" }
  s.source_files =  "APCoreDataKit/*.swift"
end
