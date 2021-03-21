//
//  UsersViewController.swift
//  HackNU
//
//  Created by Adlet Zeineken on 21.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit

class UsersViewController: UIViewController {
    static let reuseIdentifier = "\(UsersViewController.self)"
    var users: [User] = []
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = Color.lightGreen
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func addConstraints() {
        let safeArea = view.layoutMarginsGuide
        tableView.addConstraint(top: safeArea.topAnchor, leading: view.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil)
        
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
    }
}

