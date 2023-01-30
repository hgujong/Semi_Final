//
//  Todo.swift
//  Semi
//
//  Created by 서종현 on 2023/01/12.
//

import Foundation

struct Todo: Identifiable {
    var id: String
    
    var title: String
    var notes: String
}

struct users: Identifiable {
    
    var id: String
    var email: String
    var username: String
}
