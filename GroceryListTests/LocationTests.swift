//
//  LocationTests.swift
//  GroceryListTests
//
//  Created by Pritam Hinger on 21/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import XCTest
@testable import GroceryList
import CoreLocation

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_init_setLocationName(){
        let inputLocation = "DummyLocation"
        let location = Location(name: inputLocation)
        XCTAssertEqual(location.name, inputLocation)
    }
    
    func test_init_SetLocationCoordinates() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "DummyLocation", coordinate: coordinate)
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude,
                       "Latitude should be equal")
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude,
                       "Longitude should be equal")
        XCTAssertEqual(location.name, "DummyLocation", "Location name should be equal")
    }
}
