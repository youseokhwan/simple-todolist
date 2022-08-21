//
//  TasksViewCell.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/06/27.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class TasksTableViewCell: UITableViewCell {
    static let identifier = "TasksTableViewCell"

    private let disposeBag = DisposeBag()

    private lazy var checkButton: UIButton = {
        let button = UIButton()
        let normalImage = UIImage(named: Const.checkButtonNormalImage)
        let selectedImage = UIImage(named: Const.checkButtonSelectedImage)

        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.tintColor = .systemGreen
        button.isUserInteractionEnabled = false

        return button
    }()
    private lazy var contextLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func updateUI(by task: Task) {
        checkButton.isSelected = task.isChecked
        contextLabel.attributedText = NSAttributedString(string: task.context)
        contextLabel.strikethrough(isActive: task.isChecked)
    }
}

private extension TasksTableViewCell {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        selectionStyle = .none
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 10

        [checkButton, contextLabel].forEach {
            contentView.addSubview($0)
        }
    }

    func configureConstraints() {
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.width.height.equalTo(30)
        }

        contextLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(checkButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
