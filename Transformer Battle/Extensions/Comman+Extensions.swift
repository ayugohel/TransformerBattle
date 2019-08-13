//
//  Comman+Extensions.swift
//  Transformer Battle
//
//  Created by Aayushi on 2019-08-10.
//  Copyright © 2019 Aayushi. All rights reserved.
//

import Foundation
import UIKit


class ThemeButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = self.frame.height/2
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor(color: .textColor, state: .normal).font(name: appFont.semiBold, size: 15.0).backGroundColor(color: UIColor.themeColor)
    }
    
}

class ThemeLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor(color: UIColor.themeColor).font(name: appFont.regular, size: size16)
    }
    
}

var keyClouser = 1

class ClosureSleeve {
    let closure: () -> ()
    
    init(attachTo: AnyObject, closure: @escaping () -> ()) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, &keyClouser, self,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc func invoke() {
        closure()
    }
}

extension UIControl {
    func addAction(for controlEvents: UIButton.Event = .primaryActionTriggered, action: @escaping () -> ()) {
        let sleeve = ClosureSleeve(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }
}
