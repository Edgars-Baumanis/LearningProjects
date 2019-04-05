//
//  Background.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 25.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit

extension UIView {
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor(red:0.92, green:0.93, blue:1.00, alpha:1.0).cgColor,
            UIColor(red:0.57, green:0.65, blue:1.00, alpha:1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: frame.midX, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: frame.midX, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }

    func setCellBackground() {
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: self.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }

    func floatingButton() -> UIButton{
        let btn = UIButton(frame: CGRect(x: self.frame.maxX - 90 , y: self.frame.maxY - 90, width: 70, height: 70))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 4, right: 0)
        btn.setTitle("+", for: .normal)
        btn.backgroundColor = .clear
        btn.setTitleColor(.black, for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 34
        return btn
    }
}
