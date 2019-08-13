//
//  Constant.swift
//  Transformer Battle
//
//  Created by admin on 10/08/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import Foundation
import UIKit

//MARK: ConstantKey
struct UserDefaultKeys {
    static let authorization      = "authorization"
}

//MARK: font size
let size12 : CGFloat = 14.0
let size16 : CGFloat = 16.0

//MARK: storyboard instance
enum AppStoryboard : String {
    
    case HOME
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

//MARK: flag for add and edit
enum EditType {
    case Add
    case Edit
}

//MARK: Font name declaration
struct appFont {
    static let regular      = "Nunito-Regular"
    static let bold         = "Nunito-Bold"
    static let medium       = "Nunito-Medium"
    static let semiBold     = "Nunito-SemiBold"
    static let light        = "Nunito-Light"
}
