//
//  Toolbar.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 30.04.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

extension UIToolbar {
    func toolbarPicker(mySelect: Selector) -> UIToolbar {
        let toolbar = UIToolbar()

        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = .black
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.setItems([spaceButton, doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }
}
