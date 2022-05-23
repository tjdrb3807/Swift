//
//  Content.swift
//  NetflixStyleSampleApp
//
//  Created by 전성규 on 2022/05/23.
//

import UIKit

struct Content: Decodable {
    let sectionType: SectionType
    let sectionName: String
    let contentItem: [Item]
    
    //String -> Enum
    enum SectionType: String, Decodable {
        case basic
        case main
        case large
        case rank
    }
}

struct Item: Decodable {
    let description: String
    let imageName: String
    
    //String -> UIImage
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
}

