//
//  PostCell.swift
//  HackNU
//
//  Created by Adlet Zeineken on 20.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class PostCell: UITableViewCell {
    static let reuseIdentifier = String("\(PostCell.self)")
    var mainImageViewHeightConstraint = NSLayoutConstraint()
    var locationIconPaddingConstraint = NSLayoutConstraint()
    var locationLabelPaddingConstraint = NSLayoutConstraint()
    
    var peopleIconPaddingConstraint = NSLayoutConstraint()
    var peopleLabelPaddingConstraint = NSLayoutConstraint()
    
    var calendarIconPaddingConstraint = NSLayoutConstraint()
    var calendarLabelPaddingConstraint = NSLayoutConstraint()
    
    var descriptionPaddingConstraint = NSLayoutConstraint()
    var mainImagePaddingConstraint = NSLayoutConstraint()
    
    private let shadowLayer: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 25
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    private let createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = Color.gray
        return label
    }()
    
    private let createdPostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Color.black
        return label
    }()
    
    private let createdTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "created"
        label.textColor = Color.gray
        return label
    }()
    
    private let postTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Color.blue
        return label
    }()
    
    private let communityAvaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = Color.black
        label.numberOfLines = 0
        return label
    }()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5 )
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let calendarIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = Color.blue
        return imageView
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = Color.gray
        return label
    }()
    
    private let peopleIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.2.fill")
        imageView.tintColor = Color.blue
        return imageView
    }()
    
    private let peopleEngagedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Color.gray
        return label
    }()
    
    private let locationIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.fill")
        imageView.tintColor = Color.blue
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Color.gray
        return label
    }()
    
    private let cellBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.blue
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(systemName: "person.badge.plus.fill")
        button.layer.cornerRadius = 15
        
        button.tintColor = Color.darkBlue
        button.setImage(buttonImage, for: .normal)
        button.backgroundColor = Color.lightGreen
        
        button.setTitle(" Follow", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(Color.darkBlue, for: .normal)
        button.setTitleColor(Color.darkBlue, for: .highlighted)
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(systemName: "dollarsign.circle.fill")
        button.layer.cornerRadius = 15
        
        button.tintColor = Color.darkBlue
        button.setImage(buttonImage, for: .normal)
        button.backgroundColor = Color.lightGreen
        
        button.setTitle(" Donate", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(Color.darkBlue, for: .normal)
        button.setTitleColor(Color.darkBlue.withAlphaComponent(0.5), for: .highlighted)
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        return button
    }()
    
    var post: Event? {
        didSet {
            if let communityImageURL = URL(string: post?.communityImageURL ?? "") {
                communityAvaImageView.setImage(from: communityImageURL)
            }
            createdPostLabel.text = post?.community
            switch post?.type {
            case .Article:
                postTypeLabel.text = "Article"
            case .Donate:
                postTypeLabel.text = "Donate"
            case .Seminar:
                postTypeLabel.text = "Seminar"
            default:
                postTypeLabel.text = ""
            }
            createdAtLabel.text = post?.createdAt
            
            titleLabel.text = post?.title
            if let mainImage = post?.imageURL,
                let mainImageURL = URL(string: mainImage) {
                mainImageView.setImage(from: mainImageURL)
            } else {
                mainImageView.isHidden = true
                mainImageViewHeightConstraint.constant = 0
                mainImagePaddingConstraint.constant = 0
            }
            
            if let description = post?.description {
                descriptionLabel.text = description
            } else {
                descriptionLabel.isHidden = true
                descriptionPaddingConstraint.constant = 0
            }
            
            if let deadlineText = post?.deadline {
                deadlineLabel.text = deadlineText
            } else {
                deadlineLabel.isHidden = true
                calendarIconImageView.isHidden = true
                calendarLabelPaddingConstraint.constant = 0
                calendarIconPaddingConstraint.constant = 0
            }
            
            if let peopleEngaged = post?.peopleEngaged {
                if (post?.type == .Donate) {
                    peopleEngagedLabel.text = "\(peopleEngaged) donated"
                } else
                    if (post?.type == .Seminar) {
                        peopleEngagedLabel.text = "\(peopleEngaged) participating"
                    } else {
                        peopleEngagedLabel.isHidden = true
                        peopleIconImageView.isHidden = true
                        peopleLabelPaddingConstraint.constant = 0
                        peopleIconPaddingConstraint.constant = 0
                }
            } else {
                peopleEngagedLabel.isHidden = true
                peopleIconImageView.isHidden = true
                peopleLabelPaddingConstraint.constant = 0
                peopleIconPaddingConstraint.constant = 0
            }
            
            if let location = post?.location {
                locationLabel.text = location
            } else {
                locationLabel.isHidden = true
                locationIconImageView.isHidden = true
                locationLabelPaddingConstraint.constant = 0
                locationIconPaddingConstraint.constant = 0
            }
            
            if (post?.type == .Seminar) {
                rightButton.setImage(UIImage(systemName: "hand.raised.fill"), for: .normal)
                rightButton.setTitle(" Take part", for: .normal)
            } else if (post?.type == .Article) {
                rightButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                rightButton.setTitle(" 22", for: .normal)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 25
        
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() {
        self.contentView.addSubview(communityAvaImageView)
        self.contentView.addSubview(postTypeLabel)
        self.contentView.addSubview(createdAtLabel)
        self.contentView.addSubview(createdPostLabel)
        self.contentView.addSubview(createdTextLabel)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(mainImageView)
        
        self.contentView.addSubview(descriptionLabel)
        
        self.contentView.addSubview(calendarIconImageView)
        self.contentView.addSubview(deadlineLabel)
        self.contentView.addSubview(peopleIconImageView)
        self.contentView.addSubview(peopleEngagedLabel)
        self.contentView.addSubview(locationIconImageView)
        self.contentView.addSubview(locationLabel)
        
        self.contentView.addSubview(cellBottomView)
//        cellBottomView.addSubview(followIcon)
//        cellBottomView.addSubview(followLabel)
        cellBottomView.addSubview(followButton)
        cellBottomView.addSubview(rightButton)
    }
    
    func addConstraints() {
        communityAvaImageView.addConstraint(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 16, paddingLeading: 16, width: 50, height: 50)
        createdPostLabel.addConstraint(top: self.contentView.topAnchor, leading: communityAvaImageView.trailingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 26, paddingLeading: 8, height: 16)
        postTypeLabel.addConstraint(top: createdPostLabel.bottomAnchor, leading: communityAvaImageView.trailingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingLeading: 8, height: 16)
        createdAtLabel.addConstraint(top: self.contentView.topAnchor, leading: nil, bottom: nil, trailing: self.contentView.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 26, paddingTrailing: -16, height: 14)
        createdTextLabel.addConstraint(top: self.contentView.topAnchor, leading: createdPostLabel.trailingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 26, paddingLeading: 4, height: 16)
        
        titleLabel.addConstraint(top: communityAvaImageView.bottomAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: self.contentView.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 8, paddingLeading: 16, paddingTrailing: -16)
        mainImageView.addConstraint(top: titleLabel.bottomAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: self.contentView.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, height: 170)
        if let heightConstraint = mainImageView.constraints.last {
            mainImageViewHeightConstraint = heightConstraint
        }
        
        descriptionLabel.addConstraint(top: mainImageView.bottomAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: self.contentView.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, paddingLeading: 16, paddingTrailing: -16)
        
        calendarIconImageView.addConstraint(top: descriptionLabel.bottomAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 8, paddingLeading: 18, width: 16, height: 16)
        deadlineLabel.addConstraint(top: descriptionLabel.bottomAnchor, leading: calendarIconImageView.trailingAnchor, bottom: nil, trailing: self.contentView.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 8, paddingLeading: 10, paddingTrailing: -16, height: 16)
        if let heightConstraint = calendarIconImageView.constraints.last {
            calendarIconPaddingConstraint = heightConstraint
        }
        if let heightConstraint = deadlineLabel.constraints.last {
            calendarLabelPaddingConstraint = heightConstraint
        }
        
        peopleIconImageView.addConstraint(top: calendarIconImageView.bottomAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 8, paddingLeading: 16, width: 22, height: 16)
        peopleEngagedLabel.addConstraint(top: calendarIconImageView.bottomAnchor, leading: peopleIconImageView.trailingAnchor, bottom: nil, trailing: self.contentView.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 8, paddingLeading: 8, paddingTrailing: -16, height: 16)
        if let heightConstraint = peopleIconImageView.constraints.last {
            peopleIconPaddingConstraint = heightConstraint
        }
        if let heightConstraint = peopleEngagedLabel.constraints.last {
            peopleLabelPaddingConstraint = heightConstraint
        }
        
        locationIconImageView.addConstraint(top: peopleIconImageView.bottomAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 8, paddingLeading: 16, width: 20, height: 16)
        locationLabel.addConstraint(top: peopleIconImageView.bottomAnchor, leading: peopleIconImageView.trailingAnchor, bottom: nil, trailing: self.contentView.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 8, paddingLeading: 8, paddingTrailing: -16, height: 16)
        if let heightConstraint = locationIconImageView.constraints.last {
            locationIconPaddingConstraint = heightConstraint
        }
        if let heightConstraint = locationLabel.constraints.last {
            locationLabelPaddingConstraint = heightConstraint
        }
        
        cellBottomView.addConstraint(top: locationIconImageView.bottomAnchor, leading: self.contentView.leadingAnchor, bottom: self.contentView.bottomAnchor, trailing: self.contentView.trailingAnchor, centerXAnchor: nil, centerYAnchor: nil, paddingTop: 12, height: 55)

//        followIcon.addConstraint(top: nil, leading: cellBottomView.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: cellBottomView.centerYAnchor, paddingLeading: 16, height: 20)
//        followLabel.addConstraint(top: nil, leading: followIcon.trailingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: cellBottomView.centerYAnchor, paddingLeading: 6)
        followButton.addConstraint(top: nil, leading: cellBottomView.leadingAnchor, bottom: nil, trailing: nil, centerXAnchor: nil, centerYAnchor: cellBottomView.centerYAnchor, paddingLeading: 16, height: 30)
        followButton.addTarget(self, action: #selector(followButtonPressed), for: .touchUpInside)
        followButton.addTarget(self, action: #selector(followButtonHighlight), for: .touchDown)
        
        rightButton.addConstraint(top: nil, leading: nil, bottom: nil, trailing: cellBottomView.trailingAnchor, centerXAnchor: nil, centerYAnchor: cellBottomView.centerYAnchor, paddingTrailing: -16, height: 30)
        rightButton.addTarget(self, action: #selector(rightButtonPressed), for: .touchUpInside)
    }
    
    @objc
    func followButtonPressed() {
        UIView.animate(withDuration: 0.5) {
            if (self.followButton.backgroundColor == Color.lightGreen) {
                self.followButton.backgroundColor = Color.lightGreen
                self.followButton.setTitle(" Follow", for: .normal)
            } else {
                self.followButton.backgroundColor = Color.lightRed
                self.followButton.setTitle(" Unfollow", for: .normal)
            }
        }
    }
    
    @objc
    func followButtonHighlight() {
        UIView.animate(withDuration: 0.25) {
            if (self.followButton.backgroundColor == Color.lightGreen) {
                self.followButton.backgroundColor = Color.lightRed
            } else {
                self.followButton.backgroundColor = Color.lightGreen
            }
        }
    }
    
    @objc
    func rightButtonPressed() {
        if (post?.type == .Article) {
            UIView.animate(withDuration: 0.25) {
                if (self.rightButton.tintColor == Color.lightRed) {
                    self.rightButton.tintColor = Color.darkBlue
                } else {
                    self.rightButton.tintColor = Color.lightRed
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
