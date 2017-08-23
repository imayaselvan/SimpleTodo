//
//  toDoModel.swift
//  toDo
//
//  Created by Imayaselvan Ramakrishnan on 8/22/17.
//  Copyright © 2017 Imayaselvan. All rights reserved.
//

import UIKit

enum TodoStatus: Int {
    case pending = 0
    case completed = 1
}

class toDoModel: NSObject {
    var title: String
    var status: TodoStatus
    init (title: String, status: TodoStatus) {
        self.title = title
        self.status = status
    }
}
