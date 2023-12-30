//
//  LocationInfo.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/3.
//

import Foundation

struct SearchResponse: Codable{
    let data: NestedJSON
}

struct NestedJSON: Codable{
    let results: [LocationInfo]
}

struct LocationInfo: Codable, Identifiable{
    var LocId: String{id}
    let id: String
    let displayName: String
    let lng: String
    let lat: String
    let coordinate: String
}
