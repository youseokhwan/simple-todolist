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
    private let disposeBag = DisposeBag()

    private lazy var checkButton: UIButton = {
        let button = UIButton()
        let configure = UIImage.SymbolConfiguration(pointSize: 25)

        button.setImage(UIImage(systemName: Const.checkButtonNormalImage,
                                withConfiguration: configure), for: .normal)
        button.setImage(UIImage(systemName: Const.checkButtonSelectedImage,
                                withConfiguration: configure), for: .selected)
        button.tintColor = .systemGreen

        return button
    }()
    private lazy var contextLabel = UILabel()

    var checkButtonTappedHandler: ((Bool) -> Void)?

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
        configureBind()
        configureConstraints()
    }

    func configureViews() {
        [checkButton, contextLabel].forEach {
            contentView.addSubview($0)
        }
    }

    func configureBind() {
        checkButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.checkButton.isSelected = !self.checkButton.isSelected
                self.contextLabel.strikethrough(isActive: self.checkButton.isSelected)
                self.checkButtonTappedHandler?(self.checkButton.isSelected)
            })
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.width.height.equalTo(30)
        }

        contextLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
        }
    }
}
