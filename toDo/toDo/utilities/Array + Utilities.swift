//
//  Array.swift
//  NewyorkSample
//
//  Created by Imayaselvan Ramakrishnan on 7/30/17.
//  Copyright © 2017 Imayaselvan. All rights reserved.
//

extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}

public extension LazyMapCollection  {
    
    func toArray() -> [Element]{
        return Array(self)
    }
}

extension Collection {
    public subscript (safe index: Self.Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
