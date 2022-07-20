//
//  DelegateProxy.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/20.
//

import UIKit

import RxCocoa

class UITableViewDelegateProxy: DelegateProxy<UITableView, UITableViewDelegate>,
DelegateProxyType, UITableViewDelegate {
    static func registerKnownImplementations() {
        register { tableView -> UITableViewDelegateProxy in
            UITableViewDelegateProxy(parentObject: tableView, delegateProxy: self)
        }
    }

    static func currentDelegate(for object: UITableView) -> UITableViewDelegate? {
        return object.delegate
    }

    static func setCurrentDelegate(_ delegate: UITableViewDelegate?, to object: UITableView) {
        object.delegate = delegate
    }
}
