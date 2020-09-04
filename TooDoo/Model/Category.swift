//
//  Category.swift
//  TooDoo
//
//  Created by Jonathan Sweeney on 9/1/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import Foundation
import RealmSwift
import ChameleonFramework

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = UIColor.randomFlat().hexValue()
    // Relationships
    let items = List<Item>()
}
