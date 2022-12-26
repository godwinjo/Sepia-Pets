//
//  Config.swift
//  PetList
//
//  Created by Godwin on 27/12/22.
//

import Foundation

struct Config: Decodable {
    let settings: Settings?
}

struct Settings: Decodable {
    let workHours: String?
}
