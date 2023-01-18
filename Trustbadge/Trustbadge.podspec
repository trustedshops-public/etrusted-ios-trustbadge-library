Pod::Spec.new do |spec|
  spec.name         = "Trustbadge"
  spec.version      = "0.1.1"
  spec.summary      = "Trustbadge library for the iOS platform"
  spec.description  = <<-DESC
  Trustbadge iOS library provides UI widgets for displaying trustmark logo and shop reviews in iOS applications. It provides an easy integration for these widgets with very little amount of code, please see the readme section for more details.
                   DESC

  spec.homepage     = "https://cocoapods.org/"
  spec.license      = "MIT"
  #spec.author             = { "Trusted Shops" => "prem.pratap@xparrow.com" }
  spec.author             = { "Trusted Shops GmbH" => "https://www.trustedshops.com/" }

  spec.platform     = :ios
  spec.platform     = :ios, "13.0"
  spec.swift_versions = "5.0"

  #spec.source       = { :git => "https://github.com/trustedshops-public/etrusted-ios-trustbadge-library.git", :tag => spec.version.to_s }
  spec.source       = { :http => 'https://example.com/download/ios_sdk/1.0.1/MyFramework.zip' }
  spec.source_files  = "Trustbadge/**/*.{swift}"
  # spec.public_header_files = "Classes/**/*.h"
  spec.resources = "Trustbadge/Assets/*.*"
end
