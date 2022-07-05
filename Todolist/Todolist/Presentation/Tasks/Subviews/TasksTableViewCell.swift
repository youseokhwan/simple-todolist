//
//  TasksViewCell.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/06/27.
//

import UIKit

import SnapKit

final class TasksTableViewCell: UITableViewCell {
    static let identifier = "TasksTableViewCell"
    
    private lazy var contextLabel = UILabel()
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        let configure = UIImage.SymbolConfiguration(pointSize: 25)
        button.setImage(UIImage(systemName: "circle",
                                withConfiguration: configure), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill",
                                withConfiguration: configure), for: .selected)
        button.tintColor = .systemGreen
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureViews()
        configureConstraints()
    }

    private func configureViews() {
        contentView.backgroundColor = .systemGray
        contentView.layer.cornerRadius = 10
        
        [contextLabel, checkButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        checkButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }

        contextLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func update(task: Task) {
        contextLabel.text = task.context
    }
}
