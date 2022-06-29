//
//  TasksViewCell.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/06/27.
//

import UIKit

import SnapKit

final class TasksCell: UITableViewCell {
    static let identifier = "TasksCell"
    
    private lazy var contextLabel = UILabel()
    private lazy var endDateLabel = UILabel()
    private lazy var publisedDateLabel = UILabel()
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        let configure = UIImage.SymbolConfiguration(pointSize: 20)
        button.setImage(UIImage(systemName: "circle", withConfiguration: configure), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: configure), for: .selected)
        button.tintColor = .systemGreen
        return button
    }()
    
    override func layoutSubviews() {
        configure()
    }
    
    private func configure() {
        [contextLabel, endDateLabel, publisedDateLabel, checkButton].forEach { contentView.addSubview($0) }
        
        checkButton.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(20)
        }
        
        contextLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
            make.top.equalToSuperview().offset(15)
        }
        
        publisedDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
            make.top.equalTo(contextLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        endDateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(contextLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func bind(data: Task) {
        contextLabel.text = data.context
        endDateLabel.text = data.endDate?.dateToString
        publisedDateLabel.text = data.publishedDate.dateToString
    }
}
