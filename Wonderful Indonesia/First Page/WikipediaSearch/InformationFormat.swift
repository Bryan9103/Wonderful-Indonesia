//
//  InformationFormat.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/10.
//

import Foundation

struct InformationFormat: Codable, Identifiable{
    var id = UUID()
    let image: URL?
    let title: String
    let text: String
}
