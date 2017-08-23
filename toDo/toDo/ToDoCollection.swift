//
//  toDoCollection.swift
//  toDo
//
//  Created by Imayaselvan Ramakrishnan on 8/22/17.
//  Copyright © 2017 Imayaselvan. All rights reserved.
//

import UIKit

class ToDoCollection: NSObject {
    var models = [toDoModel]()
    init(model :[toDoModel]) {
        self.models = model
    }
}

extension ToDoCollection {

    var count: Int {
        return models.count
    }
    
    func at(_ index: Int) -> toDoModel {
        return models[index]
    }
    
    func at(_ range: CountableRange<Int>) -> [toDoModel] {
        return Array(models[range])
    }
    
    func reset(_ models: [toDoModel]) {
        self.models.removeAll(keepingCapacity: false)
        self.models.append(contentsOf: models)
    }
    
    func append(_ models: [toDoModel]) {
        self.models.append(contentsOf: models)
    }
   
    func appendSingle(_ models: toDoModel) {
        self.models.append(models)
    }
    
    func delete(_ model : toDoModel) {
        if let index = self.models.index(of: model) {
            self.models.remove(at: index)
        }
    }
}

