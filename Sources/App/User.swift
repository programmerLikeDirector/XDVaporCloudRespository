//
//  User.swift
//  App
//
//  Created by sure on 2019/6/25.
//

import Foundation
import FluentSQLite
import Vapor

final class User: Codable {
    var id: Int?
    var name: String
    var username: String
    
    init(name: String,userName: String) {
        self.name = name
        self.username = userName
    }
}

extension User: SQLiteModel {}
extension User: Content {}
extension User: Migration {}
extension User: Parameter {}

