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

    private lazy var doneButton: UIButton = {
        let button = UIButton()
        let normalImage = UIImage(named: Const.checkButtonNormalImage)
        let selectedImage = UIImage(named: Const.checkButtonSelectedImage)

        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.tintColor = .systemGreen

        return button
    }()
    private lazy var titleLabel = UILabel()

    var doneButtonRx: Reactive<UIButton> {
        return doneButton.rx
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func updateUI(by task: Task) {
        doneButton.isSelected = task.isDone
        titleLabel.strikethrough(isActive: task.isDone, withText: task.title)
    }
}

private extension TasksTableViewCell {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        selectionStyle = .none

        [doneButton, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }

    func configureConstraints() {
        doneButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.width.height.equalTo(30)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(doneButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
