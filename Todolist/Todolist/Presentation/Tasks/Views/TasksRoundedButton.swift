//
//  TasksRoundedButton.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/29.
//

import UIKit

class TasksRoundedButton: UIButton {
    var imageSize = CGSize() {
        didSet {
            setImage(
                UIGraphicsImageRenderer(size: imageSize).image { _ in
                    currentImage?.draw(in: CGRect(origin: .zero, size: imageSize))
                },
                for: .normal
            )
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension TasksRoundedButton {
    func configure() {
        configureViews()
    }

    func configureViews() {
        layer.cornerRadius = 10
        contentHorizontalAlignment = .leading

        if #available(iOS 15.0, *) {
            var configuration = Configuration.plain()
            let transformer = UIConfigurationTextAttributesTransformer { [weak self] attribute in
                var attribute = attribute

                attribute.font = self?.titleLabel?.font
                attribute.foregroundColor = self?.currentTitleColor

                return attribute
            }

            configuration.imagePadding = 12
            configuration.titleTextAttributesTransformer = transformer

            self.configuration = configuration
        } else {
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        }
    }
}
