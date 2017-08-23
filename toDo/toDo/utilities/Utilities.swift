//
//  Utilities.swift
//  toDo
//
//  Created by Imayaselvan Ramakrishnan on 8/22/17.
//  Copyright © 2017 Imayaselvan. All rights reserved.
//

import UIKit

@discardableResult public func tap<T>( _ some: T, tap: (T) -> () ) -> T {
    tap(some)
    return some
}
