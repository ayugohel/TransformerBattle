import UIKit

// MARK: - Properties

extension UITextField {
    
    public typealias TextFieldConfig = (UITextField) -> Swift.Void
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.keyboardAppearance = .dark
        self.textColor(color: .textColor).font(name: appFont.regular)
    }
    
}

