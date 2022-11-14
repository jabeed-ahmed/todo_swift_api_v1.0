//
//  TodoModel.swift
//  WarCardGame
//
//  Created by Qatar Executive on 11/10/22.
//

import Foundation

struct TodoModel: Decodable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

