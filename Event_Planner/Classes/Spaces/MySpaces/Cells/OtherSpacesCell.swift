//
//  TableViewCells.swift
//  Event_Planner
//
//  Created by Edgars Baumanis on 26.02.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import UIKit



class OtherSpacesCell: UITableViewCell {
    private var gradient: CAGradientLayer?
    @IBOutlet weak var otherSpacesContentView: UIView!
    @IBOutlet weak var otherSpacesContent: UILabel!

    override func awakeFromNib() {
        let grad = self.createGradient()
        otherSpacesContentView.layer.insertSublayer(grad, at: 0)
        self.gradient = grad
    }
    
    func displayContent(spaceName: String) {
        otherSpacesContent.text = spaceName
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradient?.frame = bounds
    }

    func createGradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red:0.67, green:0.93, blue:0.84, alpha:1.0).cgColor, UIColor(red:0.98, green:0.93, blue:0.59, alpha:1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        return gradientLayer
    }
}
