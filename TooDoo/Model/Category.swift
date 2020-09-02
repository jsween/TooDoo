//
//  Category.swift
//  TooDoo
//
//  Created by Jonathan Sweeney on 9/1/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    // Relationships
    let items = List<Item>()
}
