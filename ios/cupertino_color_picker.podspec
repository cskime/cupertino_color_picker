#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint cupertino_color_picker.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'cupertino_color_picker'
  s.version          = '0.2.0'
  s.summary          = 'Flutter plugin for iOS UIColorPickerViewController and UIColorWell.'
  s.description      = <<-DESC
Flutter plugin that provides access to the native iOS UIColorPickerViewController and UIColorWell components.
                       DESC
  s.homepage         = 'https://github.com/cskime/cupertino_color_picker'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Chamsol Kim' => 'github.com/cskime' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '14.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'cupertino_color_picker_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
