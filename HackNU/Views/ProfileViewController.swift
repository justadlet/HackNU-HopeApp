//
//  ProfileViewController.swift
//  HackNU
//
//  Created by Adlet Zeineken on 20.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    private let avaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textColor = Color.darkBlue
        return label
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Color.grayBackground
        button.layer.cornerRadius = 16
        button.setTitle("57", for: .normal)
        button.setTitleColor(Color.darkBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.contentHorizontalAlignment = .left
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "followers   "
        label.textColor = Color.unselectedBlue
        
        button.addSubview(label)
        label.addConstraint(top: button.topAnchor, leading: button.titleLabel?.trailingAnchor, bottom: button.bottomAnchor, trailing: button.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingLeading: 5)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Color.grayBackground
        button.layer.cornerRadius = 16
        button.setTitle("57", for: .normal)
        button.setTitleColor(Color.darkBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.contentHorizontalAlignment = .left
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "following   "
        label.textColor = Color.unselectedBlue
        
        button.addSubview(label)
        label.addConstraint(top: button.topAnchor, leading: button.titleLabel?.trailingAnchor, bottom: button.bottomAnchor, trailing: button.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingLeading: 5)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return button
    }()
    
    private let separatorLine1: UIView = {
        let view = UIView()
        view.backgroundColor = Color.lightBorder
        return view
    }()
    
    private let separatorLine2: UIView = {
        let view = UIView()
        view.backgroundColor = Color.lightBorder
        return view
    }()
    
    private let phoneIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone")
        imageView.tintColor = Color.blue
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone number"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = Color.darkBlue
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = Color.unselectedBlue
        return label
    }()
    
    var currentUser: User? {
        didSet {
            if let numOfFollowers = currentUser?.followers.count {
                followersButton.setTitle("\(String(describing: numOfFollowers))", for: .normal)
            }
            if let numOfFollowing = currentUser?.following.count {
                followingButton.setTitle("\(String(describing: numOfFollowing))", for: .normal)
            }
            if let imageURL = URL(string: currentUser?.image ?? "") {
                avaImageView.setImage(from: imageURL)
                print("\(imageURL)")
            }
            nameLabel.text = currentUser?.name
            phoneLabel.text = currentUser?.phoneNumber
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userA = User(image: "https://thewave.kz/wp-content/uploads/elementor/thumbs/photo_2020-12-10_16-31-57-oznon7svv1kkxujfxvxijpkgda5fruw9iti8jw9xf4.jpg"
            , name: "NU Red Crescent", followers: [], following: [], phoneNumber: "+7 (707) 912 03 76")
        let userB = User(image: "https://nu.edu.kz/wp-content/uploads/2017/10/logo_nu.jpg"
                , name: "Nazarbayev University", followers: [], following: [], phoneNumber: "+7 (777) 777 77 77")
        currentUser = User(image: "https://akniga.org/uploads/media/topic/2019/03/22/09/preview/7ce9fc824d4682ebf054_400x.jpg", name: "Adlet Zeineken", followers: [], following: [userA], phoneNumber: "87771111111")
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() {
        view.addSubview(avaImageView)
        view.addSubview(nameLabel)
        view.addSubview(followersButton)
        view.addSubview(followingButton)
        view.addSubview(separatorLine1)
        
        view.addSubview(phoneIcon)
        view.addSubview(phoneNumberLabel)
        view.addSubview(phoneLabel)
        view.addSubview(separatorLine2)
    }
    
    func addConstraints() {
        let safeArea = view.layoutMarginsGuide
        avaImageView.addConstraint(top: safeArea.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 20, paddingLeading: 16, width: 72, height: 72)
        nameLabel.addConstraint(top: safeArea.topAnchor, leading: avaImageView.trailingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 24, paddingLeading: 4)
        followersButton.addConstraint(top: nameLabel.bottomAnchor, leading: avaImageView.trailingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 6, paddingLeading: 4, height: 32)
        followingButton.addConstraint(top: nameLabel.bottomAnchor, leading: followersButton.trailingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 6, paddingLeading: 12, height: 32)
        separatorLine1.addConstraint(top: followingButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 20  , height: 1)
        
        followersButton.addTarget(self, action: #selector(followersButtonPressed), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(followersButtonHighlight), for: .touchDown)
        followingButton.addTarget(self, action: #selector(followingButtonPressed), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(followingButtonHighlight), for: .touchDown)
        
        phoneIcon.addConstraint(top: separatorLine1.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 16, paddingLeading: 16, width: 25, height: 25)
        phoneNumberLabel.addConstraint(top: separatorLine1.bottomAnchor, leading: phoneIcon.trailingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 16, paddingLeading: 12, height: 25)
        phoneLabel.addConstraint(top: separatorLine1.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 16, paddingTrailing: -16, height: 25)
        separatorLine2.addConstraint(top: phoneIcon.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 16, height: 1)
    }
    
    @objc
    func followersButtonPressed() {
        UIView.animate(withDuration: 0.25) {
            self.followersButton.backgroundColor = Color.grayBackground
        }
        let nextViewController = UsersViewController()
        if let users = currentUser?.followers as? [User] {
            nextViewController.users = users
        }
        nextViewController.navigationItem.title = "Followers"
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc
    func followersButtonHighlight() {
        UIView.animate(withDuration: 0.25) {
            self.followersButton.backgroundColor = Color.darkBlue.withAlphaComponent(0.2)
        }
    }
    
    @objc
    func followingButtonPressed() {
        UIView.animate(withDuration: 0.25) {
            self.followingButton.backgroundColor = Color.grayBackground
        }
        let nextViewController = UsersViewController()
        if let users = currentUser?.following as? [User] {
            nextViewController.users = users
        }
        nextViewController.navigationItem.title = "Following"
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc
    func followingButtonHighlight() {
        UIView.animate(withDuration: 0.25) {
            self.followingButton.backgroundColor = Color.darkBlue.withAlphaComponent(0.2)
        }
    }
}
