//
//  Utilities.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 23/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable  class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var intermediateColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame =  self.bounds
        gradient.colors = [startColor.cgColor,intermediateColor.cgColor, endColor.cgColor]
        gradient.locations = [ 0.0, 0.5 , 1.0]
        layer.insertSublayer(gradient, at: 0)
    }
}
