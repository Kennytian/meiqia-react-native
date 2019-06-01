require 'json'
package = JSON.parse(File.read(File.join(__dir__, '../', 'package.json')))

Pod::Spec.new do |s|
  s.name         = "RNMeiqia"
  s.version      = package['version']
  s.summary      = "MeiQia SDK for React Native"
  s.description  = <<-DESC
                  RNMeiqia
                   DESC
  s.homepage     = "https://github.com/Kennytian/meiqia-react-native"
  s.license      = "Anti996"
  # s.license      = { :type => "Anti996", :file => "FILE_LICENSE" }
  s.author             = { "Kenny Tian" => "kenny_tian@outlook.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Kennytian/meiqia-react-native.git", :tag => "master" }
  s.source_files  = "ios/**/*.{h,m}"
  s.resources = ['*.bundle', '*.strings']
  s.requires_arc = true

  s.dependency "React"
  #s.dependency "others"

end

