//
//  UIImage+Extensions.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/20.
//

import UIKit

extension UIImage {
    var swipeImage: UIImage {
        return UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            self.draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
        }
    }

    func resizedImage(size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
