//
//  Location.swift
//  GroceryList
//
//  Created by Pritam Hinger on 21/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Equatable {
    static func ==(lhs: Location, rhs: Location) -> Bool {
        if lhs.coordinate?.latitude != rhs.coordinate?.latitude || lhs.coordinate?.longitude != rhs.coordinate?.longitude || lhs.name != rhs.name{
            return false
        }
        
        return true
    }
    
    
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}
