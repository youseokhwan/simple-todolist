//
//  RoundedButton.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/21.
//

import UIKit

final class RoundedButton: UIButton {
    convenience init(title: String?, image: UIImage?) {
        self.init()
        configure(title: title, image: image)
    }
}

private extension RoundedButton {
    func configure(title: String?, image: UIImage?) {
        configureViews(title: title, image: image)
    }

    func configureViews(title: String?, image: UIImage?) {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()

            configuration.title = title
            configuration.image = image?.swipeImage
            configuration.baseBackgroundColor = .systemBackground
            configuration.baseForegroundColor = .black
            configuration.imagePadding = 12

            self.configuration = configuration
        } else {
            setTitle(title, for: .normal)
            setImage(image?.swipeImage, for: .normal)
            setTitleColor(UIColor.black, for: .normal)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        }

        layer.borderWidth = 1
        layer.cornerRadius = 10
        contentHorizontalAlignment = .left
    }
}
