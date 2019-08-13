import UIKit

extension String {
    
}

//MARK: Array joined function
extension Array where Element: NSAttributedString {
    func joined(separator: NSAttributedString) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    func joined(separator: String) -> NSAttributedString {
        return joined(separator: NSAttributedString(string: separator))
    }
}

//MARK: Array sum function
extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element {
        return reduce(.zero, +)
    }
}
