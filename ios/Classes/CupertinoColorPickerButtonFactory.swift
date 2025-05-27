import Flutter
import UIKit

class CupertinoColorPickerButtonFactory: NSObject, FlutterPlatformViewFactory {
  private let channel: FlutterMethodChannel
  
  init(channel: FlutterMethodChannel) {
    self.channel = channel
    super.init()
  }
  
  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> any FlutterPlatformView {
    return CupertinoColorPickerNativeButton(frame: frame, args: args, channel: channel)
  }
}

class CupertinoColorPickerNativeButton: NSObject, FlutterPlatformView {
  private let colorWell: UIColorWell
  private let channel: FlutterMethodChannel

  init(frame: CGRect, args: Any?, channel: FlutterMethodChannel) {
    colorWell = UIColorWell(frame: frame)
    
    if let argument = CupertinoColorPickerArgument(args) {
      colorWell.selectedColor = argument.initialColor
      colorWell.supportsAlpha = argument.supportsAlpha
    }
    
    self.channel = channel
    
    super.init()
    
    colorWell.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
  }
  
  func view() -> UIView {
    return colorWell
  }
  
  @objc
  private func colorChanged(_ sender: UIColorWell) {
    guard let selectedColor = sender.selectedColor else {
      return
    }
    
    channel.invokeMethod(
      CupertinoColorPickerMethod.didSelectColor,
      arguments: selectedColor.toHexString(includeAlpha: sender.supportsAlpha)
    )
  }
}
