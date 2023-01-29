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
        
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        }
        
        else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        }
        
        else { return nil }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
