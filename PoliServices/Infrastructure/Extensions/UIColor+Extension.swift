import UIKit

/// Custom Colors
extension UIColor {
    
    static var mainBackground: UIColor {
        UIColor(red: 224 / 255, green: 225 / 255, blue: 235 / 255, alpha: 1)
    }
    
    static var mainIndigo: UIColor {
        UIColor(red: 139 / 255, green: 139 / 255, blue: 219 / 255, alpha: 1)
    }
    
    static var mainLabel: UIColor {
        UIColor(red: 3 / 255, green: 3 / 255, blue: 3 / 255, alpha: 1)
    }
}

/// Convert HEX string to UIColor
extension UIColor {
    
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
