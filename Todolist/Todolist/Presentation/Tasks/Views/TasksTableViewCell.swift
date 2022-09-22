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
        let normalImage = UIImage(named: ButtonImage.doneNormal.rawValue)
        let selectedImage = UIImage(named: ButtonImage.doneSelected.rawValue)

        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.tintColor = .systemGreen

        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.textColor = UIColor(.commonText100)

        return label
    }()

    var doneButtonTapHandler: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let inset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        contentView.frame = contentView.frame.inset(by: inset)
    }

    func updateUI(by task: Task) {
        doneButton.isSelected = task.isDone
        titleLabel.strikethrough(isActive: task.isDone, withText: task.title)
    }
}

private extension TasksTableViewCell {
    func configure() {
        configureViews()
        configureBind()
        configureConstraints()
    }

    func configureViews() {
        selectionStyle = .none
        backgroundColor = UIColor(.commonBackground100)

        contentView.backgroundColor = UIColor(.commonBackground50)
        contentView.layer.cornerRadius = 10

        [doneButton, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }

    func configureBind() {
        doneButton.rx.tap
            .throttle(.milliseconds(100), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                self?.doneButtonTapHandler?()
            })
            .disposed(by: disposeBag)
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
