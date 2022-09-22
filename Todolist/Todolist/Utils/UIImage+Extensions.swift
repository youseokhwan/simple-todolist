//
//  UIImage+Extensions.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/20.
//

import UIKit

extension UIImage {
    var swipeImage: UIImage {
        return resizedImage(size: CGSize(width: 30, height: 30))
    }

    convenience init?(_ buttonImage: ButtonImage) {
        self.init(named: buttonImage.rawValue)
    }

    func resizedImage(size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
