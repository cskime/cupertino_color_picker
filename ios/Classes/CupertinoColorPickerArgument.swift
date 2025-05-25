import Foundation
import UIKit

struct CupertinoColorPickerArgument: Decodable {
  let initialColor: UIColor?
  let supportsAlpha: Bool
  
  init?(_ arguments: Any?) {
    guard let json = arguments as? [String: Any],
          let jsonData = try? JSONSerialization.data(withJSONObject: json),
          let argument = try? JSONDecoder().decode(CupertinoColorPickerArgument.self, from: jsonData)
    else {
      return nil
    }
    
    self = argument
  }
  
  enum CodingKeys: CodingKey {
    case initialColor
    case supportsAlpha
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    if let colorString = try container.decodeIfPresent(String.self, forKey: .initialColor) {
      self.initialColor = UIColor.fromHexString(colorString)
    } else {
      self.initialColor = nil
    }
    
    self.supportsAlpha = try container.decode(Bool.self, forKey: .supportsAlpha)
  }
}