//
//  Nsobject+Extension.swift
//  FormatStyle
//
//  Created by bhavin on 14/07/19.
//  Copyright © 2019 Bhavin. All rights reserved.
//

import UIKit

protocol FormatStyle { }

extension NSObject : FormatStyle { }

//MARK:- TextColor
extension FormatStyle where Self: NSObject {
    
    @discardableResult func textColor(color: UIColor, state: UIControl.State? = nil) -> Self {
        
        switch self {
   
        case is UILabel:
            let lbl = self as! UILabel
            lbl.textColor = color
            break
            
        case is UIButton:
            let btn = self as! UIButton
            var defaultState = UIControl.State()
            if let nwState = state {
                defaultState = nwState
            }
            btn.setTitleColor(color, for: defaultState)
            break
            
        case is UIBarButtonItem:
            let barButton = self as! UIBarButtonItem
            
            var defaultState = UIControl.State()
            if let nwState = state {
                defaultState = nwState
            }
            var defaultAttributes : [NSAttributedString.Key : Any] = [:]
            if let attributes = barButton.titleTextAttributes(for: defaultState) {
                defaultAttributes = attributes
            }
            defaultAttributes[NSAttributedString.Key.foregroundColor] = color
            barButton.setTitleTextAttributes(defaultAttributes, for: defaultState)
            break
            
        case is UITextField:
            let txtField = self as! UITextField
            txtField.textColor = color
            break
            
        case is UITextView:
            let txtv = self as! UITextView
            txtv.textColor = color
            break
            
        default:
            break
        }
        
        return self
    }
    
}


//MARK:- BackGroundColor
extension FormatStyle where Self: NSObject {
    
    @discardableResult func backGroundColor(color: UIColor) -> Self {
        
        switch self {
        
        case is UILabel:
            let lbl = self as! UILabel
            lbl.backgroundColor = color
            break
            
        case is UIButton:
            let btn = self as! UIButton
            btn.backgroundColor = color
            break
            
        case is UIBarButtonItem:
            let barButton = self as! UIBarButtonItem
            let defaultState = UIControl.State()
            
            var defaultAttributes : [NSAttributedString.Key : Any] = [:]
            
            if let attributes = barButton.titleTextAttributes(for: defaultState) {
                defaultAttributes = attributes
            }
            defaultAttributes[NSAttributedString.Key.backgroundColor] = color
            barButton.setTitleTextAttributes(defaultAttributes, for: defaultState)
            break
            
        case is UITextField:
            let txtField = self as! UITextField
            txtField.backgroundColor = color
            break
            
        case is UITextView:
            let txtv = self as! UITextView
            txtv.backgroundColor = color
            break
            
        default:
            break
        }
        
        return self
    }
    
}


//MARK:- Font & size
extension FormatStyle where Self: NSObject {
    
    @discardableResult func font(name: String, size: CGFloat? = nil) -> Self {
        
        let defaultFontSize : CGFloat = size16
        
        switch self {
        
        case is UILabel:
            let lbl = self as! UILabel
            lbl.font = UIFont(name: name, size: size ?? lbl.font.pointSize)
            break
            
        case is UIButton:
            let btn = self as! UIButton
            let nwSize = size ?? btn.titleLabel?.font.pointSize ?? defaultFontSize
            btn.titleLabel?.font = UIFont(name: name, size: nwSize)
            break
            
        case is UIBarButtonItem:
            let barButton = self as! UIBarButtonItem
            let defaultState = UIControl.State()
            
            var defaultAttributes : [NSAttributedString.Key : Any] = [:]
            
            if let attributes = barButton.titleTextAttributes(for: defaultState) {
                defaultAttributes = attributes
            }
            
            defaultAttributes[NSAttributedString.Key.font] = UIFont(name: name, size: size ?? defaultFontSize)
            
            barButton.setTitleTextAttributes(defaultAttributes, for: defaultState)
            break
            
        case is UITextField:
            let txtField = self as! UITextField
            txtField.font = UIFont(name: name, size: size ?? txtField.font?.pointSize ?? defaultFontSize)
            break
            
        case is UITextView:
            let txtv = self as! UITextView
            txtv.font = UIFont(name: name, size: size ?? txtv.font?.pointSize ?? defaultFontSize)
            break
            
        default:
            break
        }
        
        return self
    }
    
}

