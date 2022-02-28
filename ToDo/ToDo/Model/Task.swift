//
//  Task.swift
//  ToDo
//
//  Created by Valeria Fuster on 25/10/21.
//

import Foundation

struct Task: Comparable, Codable {
    static func < (lhs: Task, rhs: Task) -> Bool {
        switch (lhs.isConcluded, rhs.isConcluded){
        case (true, false):
            return true
        case (false, true):
            return false
        case (true, true):
            return false
        case (false, false):
            return true
        }
    }
    
    let name: String
    let isConcluded: Bool
}
