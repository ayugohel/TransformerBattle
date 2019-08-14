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

//MARK: string constant
let kName = "Please enter name"
let kTEAM = "Please select team"
let kSTRENGTH = "Please select strength"
let kINTELLIGENCE = "Please select intelligence"
let kSPEED = "Please select speed"
let kENDURANCE = "Please select endurance"
let kRANK = "Please select rank"
let kCOURAGE = "Please select courage"
let kFIREPOWER = "Please select firepower"
let kSKILL = "Please select skill"
let kAdd = "Please add Transformer for Battle"

//MARK: storyboard instance
enum AppStoryboard : String {
    
    case TRANSFORMER
    
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
