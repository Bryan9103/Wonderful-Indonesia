//
//  NewsFormat.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/10.
//

import Foundation

struct NewsQueryResult: Codable{
    let data: [NewsFormat]
}

struct NewsFormat: Codable, Identifiable{
    var id: String{title}
    let title: String
    let description: String
    let url: String
    let source: String
    let published_at: String
}
