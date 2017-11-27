//
//  Model.swift
//  Encicla
//
//  Created by Mateo Echeverri on 11/24/17.
//  Copyright © 2017 Mateo Echeverri. All rights reserved.
//

import Foundation

struct WebSite: Decodable {
    let date: Int
    let stations: [Zone]
}


struct Zone: Decodable {
    let id: String
    let name: String
    let desc: String
    let items: [Station]
}


struct Station: Decodable {
    let id: Int
    let name: String
    let description: String
    let address: String
    let lat: String
    let lon: String
    let type: String
    let picture: String
    let capacity: Int
    let bikes: Int
    var serial: Int?
    
}
