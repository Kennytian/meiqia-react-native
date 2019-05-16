
Pod::Spec.new do |s|
  s.name         = "RNMeiqia"
  s.version      = "0.0.1"
  s.summary      = "RNMeiqia"
  s.description  = <<-DESC
                  RNMeiqia
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "Kenny Tian" => "kenny_tian@outlook.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Kennytian/meiqia-react-native.git", :tag => "master" }
  s.source_files  = "RNMeiqia/**/*.{h,m}"
  s.requires_arc = true

  s.dependency "React"
  #s.dependency "others"

end

