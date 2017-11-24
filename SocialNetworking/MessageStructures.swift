//
//  MessageStructures.swift
//  SocialNetwork
//
//  Created by Wyatt Allen on 11/14/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String
    let password: String
}

struct Token: Codable {
    let token: String
}

struct usersList: Codable {
    var users: [String]
    
    init(users: [String]) {
        self.users = users
    }
}


struct Message: Codable {
    let user: String?
    let text: String?
    let date: Date?
    let imgURL: URL?
    let id: String?
    let replyTo: String?
    let likedBy: [String]?
}


