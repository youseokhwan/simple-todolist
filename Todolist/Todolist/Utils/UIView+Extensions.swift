//
//  UIView+Extensions.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/09/20.
//

import UIKit

extension UIView {
    func addGradientLayer(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.cornerRadius = 10

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
