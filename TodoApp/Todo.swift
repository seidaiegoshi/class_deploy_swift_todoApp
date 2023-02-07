//
//  Todo.swift
//  TodoApp
//
//  Created by 江越正大 on 2023/02/07.
//

import Foundation

struct Todo:Codable,Identifiable{
    let id: UUID
    let value :String
}
