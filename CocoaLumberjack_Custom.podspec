Pod::Spec.new do |spec|
    spec.name         = "CocoaLumberjack"
    spec.version      = "1.0.0" # Adjust the version number
    spec.summary      = "A fast & simple, yet powerful & flexible logging framework for Mac and iOS."
    spec.homepage     = "https://github.com/edwardkes/CocoaLumberjack"
    spec.license      = { :type => "BSD-3-Clause", :file => "LICENSE.md" }
    spec.author       = { "Your Name" => "your@email.com" }
    spec.source       = { :git => "https://github.com/edwardkes/CocoaLumberjack.git" }
    spec.source_files  = "Sources/**/*.{h,m}"
    # Add other necessary configurations
  end