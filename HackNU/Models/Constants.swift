//
//  Constants.swift
//  HackNU
//
//  Created by Adlet Zeineken on 21.03.2021.
//  Copyright © 2021 justadlet. All rights reserved.
//

import Foundation

protocol ConstantsDelegate: AnyObject {
    func updateTableView()
}

class Constants {
    static let baseURL = "http://134.209.229.248"
    weak var delegate: ConstantsDelegate?
    
    static var events = [
        Event(type: .Donate,
             title: "Donate to autism charity",
             community: "NU Red Crescent",
             communityImageURL: "https://thewave.kz/wp-content/uploads/elementor/thumbs/photo_2020-12-10_16-31-57-oznon7svv1kkxujfxvxijpkgda5fruw9iti8jw9xf4.jpg",
             imageURL: "https://static.wixstatic.com/media/fc8ec5_46177bcad089410ba699257037ffe46c~mv2.png/v1/fill/w_1540,h_540,al_c/fc8ec5_46177bcad089410ba699257037ffe46c~mv2.png",
             description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
             createdAt: "1 day ago",
             peopleEngaged: 127,
             deadline: "Thursday, January 10th, 4:00 am",
             location: nil),
        
        Event(type: .Seminar,
             title: "Understanding autism",
             community: "NU Red Crescent",
             communityImageURL: "https://thewave.kz/wp-content/uploads/elementor/thumbs/photo_2020-12-10_16-31-57-oznon7svv1kkxujfxvxijpkgda5fruw9iti8jw9xf4.jpg",
             imageURL: "https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80",
             description: nil,
             createdAt: "1 day ago",
             peopleEngaged: 127,
             deadline: "Thursday, January 10th, 4:00 am",
             location: "Qabanbay Batyr Ave 53, Nazarbayev University"),
        
        Event(type: .Article,
             title: "Autistic Kids and Cameras: A Good Combination",
             community: "NU Red Crescent",
             communityImageURL: "https://thewave.kz/wp-content/uploads/elementor/thumbs/photo_2020-12-10_16-31-57-oznon7svv1kkxujfxvxijpkgda5fruw9iti8jw9xf4.jpg",
             imageURL: "https://autismawarenesscentre.com/wp-content/uploads/kid_with_camera.jpg",
             description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
             createdAt: "1 day ago",
             peopleEngaged: 127,
             deadline: nil,
             location: nil),
    ]
}
