//
//  Location.swift
//  Treads
//
//  Created by Jacob Luetzow on 6/19/17.
//  Copyright © 2017 Jacob Luetzow. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
     dynamic public private(set) var latitude = 0.0
     dynamic public private(set) var longitude = 0.0
    
    convenience init(latitude: Double, longitude: Double) {
        print("In convenience init() in Loation.swift")
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}
