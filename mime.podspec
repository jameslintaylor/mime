Pod::Spec.new do |s|

  s.name = "AssociatedObjects"
  s.version = "0.0.2"
  s.summary = "swift wrappers for objc's runtime associated objects"
  s.description = <<-EOS
  AssociatedObjects provides wrappers around `objc_getAssociatedObject`,
  `objc_setAssociatedObject` and `objc_removeAssociedObjects` by way of protocol extensions.

  To enable the wrappers for an object, just inherit from the AssociatedObjects protocol
  and go crazy!
  EOS

  s.homepage = "https://github.com/jameslintaylor/AssociatedObjects"
  s.license = { :type => "MIT", :file => "LICENSE.md" }

  s.author = "James Taylor"
  s.social_media_url   = "http://twitter.com/jameslintaylor"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source = { :git => "https://github.com/jameslintaylor/AssociatedObjects.git", :tag => s.version }
  s.source_files = "AssociatedObjects/*.swift"
  s.framework = "Foundation"

end
