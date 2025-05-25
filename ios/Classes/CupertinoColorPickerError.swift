import Flutter

enum CupertinoColorPickerError {
  static let invalidArguments = FlutterError(code: "INVALID_ARGUMENTS",
                                             message: "Invalid arguments",
                                             details: nil)
  static let notImplemented = FlutterMethodNotImplemented
}
