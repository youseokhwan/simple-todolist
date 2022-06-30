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
    
    lazy var contentContainerView = ContentContainerView(frame: .zero)

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
        contentView.addSubview(contentContainerView)
    }

    private func configureConstraints() {
        contentContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
}
