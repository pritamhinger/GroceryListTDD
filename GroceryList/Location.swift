//
//  Location.swift
//  GroceryList
//
//  Created by Pritam Hinger on 21/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}
