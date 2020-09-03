//
//  Item.swift
//  TooDoo
//
//  Created by Jonathan Sweeney on 9/1/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    // Relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
