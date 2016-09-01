Pod::Spec.new do |s|

  s.name = "mime"
  s.version = "0.0.3"
  s.summary = "gesture recognizers for swift"
  s.description = <<-EOS
  mime is a simpler api for adding and reacting to `UIGestureRecognizer` in swift

  - add a gesture recognizer and react to it with `UIView.mime_on(_:UIGestureRecognizer...)`
  - remove a gesture recognizer with `UIView.mime_off(_:UIGestureRecognizer...)`
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
  s.dependency "AssociatedObjects"

end
