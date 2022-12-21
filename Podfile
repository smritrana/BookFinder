# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'BookFinder' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SwiftLint'
  pod 'AlamofireImage', '~> 4.1'

  target 'BookFinderTests' do
    inherit! :search_paths
    pod 'AlamofireImage', '~> 4.1'
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
