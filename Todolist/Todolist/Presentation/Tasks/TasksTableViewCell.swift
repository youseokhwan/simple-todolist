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
    
    override func layoutSubviews() {
        configure()
    }
    
    private func configure() {
        contentView.addSubview(contentContainerView)
        
        contentContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
}
