import Flutter
import UIKit

public class CupertinoColorPickerPlugin: NSObject, FlutterPlugin {
  private var viewController: UIViewController?
  private var channel: FlutterMethodChannel?
  private var result: FlutterResult?
  
  private static let methodChannelName = "cupertino_color_picker"
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: registrar.messenger())
    let instance = CupertinoColorPickerPlugin()
    instance.viewController = UIApplication.shared.windows.first?.rootViewController
    instance.channel = channel
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    let buttonFactory = CupertinoColorPickerButtonFactory(messenger: registrar.messenger())
    registrar.register(buttonFactory, withId: "UIColorWell")
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case CupertinoColorPickerMethod.showCupertinoColorPicker:
      guard let argument = CupertinoColorPickerArgument(call.arguments) else {
        result(CupertinoColorPickerError.invalidArguments)
        return
      }
      
      showCupertinoColorPicker(with: argument)
      
    default:
      result(CupertinoColorPickerError.notImplemented)
      return
    }
    
    self.result = result
  }
  
  private func showCupertinoColorPicker(with argument: CupertinoColorPickerArgument) {
    let colorPickerController = UIColorPickerViewController()
    colorPickerController.delegate = self
    
    if let initialColor = argument.initialColor {
      colorPickerController.selectedColor = initialColor
    }
    
    colorPickerController.supportsAlpha = argument.supportsAlpha
    
    viewController?.present(colorPickerController, animated: true)
  }
}

// MARK: - UIColorPickerViewControllerDelegate

extension CupertinoColorPickerPlugin: UIColorPickerViewControllerDelegate {
  
  public func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
    channel?.invokeMethod(
      CupertinoColorPickerMethod.didSelectColor,
      arguments: color.toHexString(includeAlpha: viewController.supportsAlpha)
    )
  }
  
  public func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    let selectedColor = viewController.selectedColor
    let hexString = selectedColor.toHexString(includeAlpha: viewController.supportsAlpha)
    self.result?(hexString)
    self.result = nil
  }
}


// MARK: - Converting Colors

extension UIColor {
  
  // Helper methods to convert between UIColor and hex string
  static func fromHexString(_ hexString: String) -> UIColor? {
    var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    
    guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
      return nil
    }
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 1.0
    
    if hexSanitized.count == 8 {
      // ARGB format
      alpha = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
      red = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
      green = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
      blue = CGFloat(rgb & 0x000000FF) / 255.0
    } else if hexSanitized.count == 6 {
      // RGB format
      red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
      green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
      blue = CGFloat(rgb & 0x0000FF) / 255.0
    } else {
      return nil
    }
    
    // Create in sRGB color space for consistency
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }
  
  func toHexString(includeAlpha: Bool) -> String {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    // Convert to sRGB color space to ensure consistent colors across platforms
    let srgbColor = convertToSRGB(color: self)
    
    // Extract RGBA components in sRGB space
    srgbColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    // Clamp values to 0-1 range to handle any out-of-gamut colors
    red = max(0, min(red, 1.0))
    green = max(0, min(green, 1.0))
    blue = max(0, min(blue, 1.0))
    
    let r = Int(red * 255) & 0xFF
    let g = Int(green * 255) & 0xFF
    let b = Int(blue * 255) & 0xFF
    let a = Int(alpha * 255) & 0xFF
    
    if includeAlpha {
      return String(format: "#%02X%02X%02X%02X", a, r, g, b)
    } else {
      return String(format: "#%02X%02X%02X", r, g, b)
    }
  }
  
  private func convertToSRGB(color: UIColor) -> UIColor {
    // Basic method that works without any colorspace comparisons
    // Just extract the components and create a new UIColor
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    // This will perform the conversion for us
    if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
      // Create a new UIColor with these components in the default color space
      return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // Extract components in the current color space₩
    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    // Create a new color in sRGB space with these components
    let srgbColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    return srgbColor
  }
}
