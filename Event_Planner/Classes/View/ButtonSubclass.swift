//
//  ButtonSubclass.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 21.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

extension UIButton {
    func setFloatingButtonGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor(red:0.19, green:0.91, blue:0.75, alpha:1.0).cgColor,
            UIColor(red:1.00, green:0.51, blue:0.21, alpha:1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
