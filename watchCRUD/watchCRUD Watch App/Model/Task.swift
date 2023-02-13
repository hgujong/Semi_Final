//
//  Task.swift
//  watchCRUD Watch App
//
//  Created by 이채연 on 2023/02/02.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    let text: String
}
