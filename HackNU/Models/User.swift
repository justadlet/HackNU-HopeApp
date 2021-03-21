//
//  User.swift
//  HackNU
//
//  Created by Adlet Zeineken on 21.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation
import UIKit

struct User {
    var image: String
    var name: String
    var followers: [User]
    var following: [User]
    var phoneNumber: String
}
