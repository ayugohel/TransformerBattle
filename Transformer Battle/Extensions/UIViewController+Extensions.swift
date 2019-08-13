import UIKit

extension UIViewController {
    
    
}

//MARK: UINavigationController property define
extension UINavigationController {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.navigationBar.barTintColor = UIColor.themeColor
        self.navigationBar.tintColor = UIColor.textColor
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColor, NSAttributedString.Key.font: UIFont(name: appFont.semiBold, size: size16)!]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.textColor, NSAttributedString.Key.font: UIFont(name: appFont.light, size: size16)!], for: .normal)
        
    }
    
}
