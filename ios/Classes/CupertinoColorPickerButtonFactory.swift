import Flutter
import UIKit

class CupertinoColorPickerButtonFactory: NSObject, FlutterPlatformViewFactory {
  private let messenger: FlutterBinaryMessenger
  
  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }
  
  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> any FlutterPlatformView {
    return CupertinoColorPickerNativeButton(frame: frame)
  }
}

class CupertinoColorPickerNativeButton: NSObject, FlutterPlatformView {
  private var _view: UIView
  
  init(frame: CGRect) {
    self._view = UIColorWell(frame: frame)
    super.init()
  }
  
  func view() -> UIView {
    return _view
  }
}
