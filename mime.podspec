Pod::Spec.new do |s|

  s.name = "mime"
  s.version = "0.0.4"
  s.summary = "from target-action to closure! (and beyond 🚀)"
  s.description = <<-EOS
  mime provides an alternate way of interacting with the objective-c style target-action
  pattern using swift closures
  EOS

  s.homepage = "https://github.com/jameslintaylor/mime"
  s.license = { :type => "MIT", :file => "LICENSE.md" }

  s.author = "James Taylor"
  s.social_media_url   = "http://twitter.com/jameslintaylor"

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"

  s.source = { :git => "https://github.com/jameslintaylor/mime.git", :tag => s.version }
  s.source_files = "mime/*.swift"
  s.framework = "UIKit"
  s.dependency "AssociatedObjects", :git => 'https://github.com/jameslintaylor/AssociatedObjects.git'

end
