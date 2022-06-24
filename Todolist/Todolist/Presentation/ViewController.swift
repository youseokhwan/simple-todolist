//
//  ViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/19.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    private lazy var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "success"
        label.textColor = .white
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
    }
}
