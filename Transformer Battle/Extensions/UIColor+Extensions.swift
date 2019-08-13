import Foundation
import UIKit

extension UIColor {
    
    //MARK: Global Color declaration
    static let themeColor = UIColor.init(hexString: "#8E388E")//#FF9F1C")
    static let textColor = UIColor.black

    //MARK: convert hex to RGB
    convenience init(hexString: String) {
        
        let hexString: String       = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner                 = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
}

