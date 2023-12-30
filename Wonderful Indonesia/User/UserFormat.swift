//
//  UserFormat.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/9.
//

import Foundation

struct User: Identifiable, Codable{
    let id: String
    let username: String
    let email: String
    
    var initials:String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: username){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User{
    static var Mock_User = User(id: NSUUID().uuidString, username: "Bryan Andersen", email: "test@gmail.com")
}
