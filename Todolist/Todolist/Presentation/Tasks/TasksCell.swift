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
}
