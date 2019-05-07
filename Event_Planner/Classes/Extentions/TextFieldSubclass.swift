//
//  TextFieldSubclass.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 30.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

@IBDesignable
class TextFieldSubclass : UITextField, UITextFieldDelegate {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.green {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
