//
//  PetDetails.swift
//  PetList
//
//  Created by Godwin on 26/12/22.
//

import Foundation

struct Pet: Decodable {
    let pets: [PetDetails]?
}

struct PetDetails: Decodable {
    let title: String?
    let contentUrl: String?
    let imageUrl: String?
    let dateAdded: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case contentUrl = "content_url"
        case imageUrl = "image_url"
        case dateAdded = "date_added"
    }
}
