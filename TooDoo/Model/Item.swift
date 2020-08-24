//
//  Item.swift
//  TooDoo
//
//  Created by Jonathan Sweeney on 8/22/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
    
    init() {
        title = ""
        done = false
    }
    
    init(title: String) {
        self.title = title
    }
}
