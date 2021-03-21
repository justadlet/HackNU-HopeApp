//
//  HomeViewController.swift
//  HackNU
//
//  Created by Adlet Zeineken on 20.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    let tableView = UITableView()
    var events: [Event] = Constants.events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchEvents()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        setupTableView()
        addSubviews()
        addConstraints()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self 
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier) 
    }
    
    func fetchEvents() {
        let allEventsURL = "\(Constants.baseURL)/event"
        var userToken: String = ""
        if let savedUserToken = UserDefaults.standard.string(forKey: "token") {
            userToken = savedUserToken
        }
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(userToken)"
        ]
        let param: [String : String] = [
            "name" : "/All"
        ]
        AF.request(allEventsURL,
                   method: .post,
                   parameters: param,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseString { (response) in
                    print(response)
        }
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func addConstraints() {
        tableView.addConstraint(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil)
    }
}

extension HomeViewController: CreateEventViewControllerDelegate {
    func reloadTableView() {
        events = Constants.events
        tableView.reloadData()
    }
    
    
}
