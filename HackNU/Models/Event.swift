//
//  Event.swift
//  HackNU
//
//  Created by Adlet Zeineken on 20.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit

enum Type {
    case Donate
    case Seminar
    case Article
    case none
}

struct Event {
    var type: Type
    var title: String
    var community: String
    var communityImageURL: String
    var imageURL: String? = ""
    var description: String?
    var createdAt: String
    var peopleEngaged: Int?
    var deadline: String?
    var location: String?
    
    init(type: Type, title: String, community: String, communityImageURL: String, imageURL: String?, description: String?, createdAt: String, peopleEngaged: Int?, deadline: String?, location: String?) {
        self.type = type
        self.title = title
        self.community = community
        self.communityImageURL = communityImageURL
        if let unwrappedImageURL = imageURL {
            self.imageURL = unwrappedImageURL
        }
        if let unwrappedDescription = description {
            self.description = unwrappedDescription
        }
        self.createdAt = createdAt
        if let unwrappedPeopleEngaged = peopleEngaged {
            self.peopleEngaged = unwrappedPeopleEngaged
        }
        if let unwrappedDeadline = deadline {
            self.deadline = unwrappedDeadline
        }
        if let unwrappedLocation = location {
            self.location = unwrappedLocation
        }
    }
    
    init() {
        self.type = .none
        self.title = ""
        self.community = ""
        self.communityImageURL = ""
        self.createdAt = ""
    }
}
