//
//  UserTableViewCell.swift
//  HackNU
//
//  Created by Adlet Zeineken on 21.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {
    static let reuseIdentifier = "\(UsersViewController.self)"
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Color.darkBlue
        return label
    }()
    
    var user: User? {
        didSet {
            nameLabel.text = user?.name
            if let userImage = user?.image,
            let imageURL = URL(string: userImage) {
                userImageView.setImage(from: imageURL)
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    func addSubviews() {
        self.contentView.addSubview(userImageView)
        self.contentView.addSubview(nameLabel)
    }
    
    func addConstraints() {
        userImageView.addConstraint(top: nil, leading: self.contentView.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: self.contentView.centerYAnchor, paddingLeading: 16, width: 50, height: 50)
        nameLabel.addConstraint(top: nil, leading: userImageView.trailingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: self.contentView.centerYAnchor, paddingLeading: 12, height: 21)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
