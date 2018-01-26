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
    
    func test_EqualLocatoin_AreEqual() {
        let location1 = Location(name: "Location1")
        let location2 = Location(name: "Location1")
        
        XCTAssertEqual(location1, location2, "Equal Location should be equal")
    }
    
    func test_Locations_DifferentLatitude_AreUnequal()  {
        assertLocationNotEqualWith(firstName: "Location1", firstLongLat: (1,1), secondName: "Location1", secondLongLat: (2,1))
    }
    
    func test_Locations_DifferentLongitude_AreUneuqal() {
        assertLocationNotEqualWith(firstName: "Location1", firstLongLat: (1,1), secondName: "Location1", secondLongLat: (1,2))
    }
    
    func test_Locations_WhenOneLocationHaveCoordinate_AreUnequal() {
        assertLocationNotEqualWith(firstName: "Location1", firstLongLat: (0,1), secondName: "Location1", secondLongLat: nil)
    }
    
    func assertLocationNotEqualWith(firstName: String, firstLongLat: (Double, Double)?, secondName: String, secondLongLat: (Double, Double)?, line:UInt = #line) {
        var firstCoordinate: CLLocationCoordinate2D? = nil
        var secondCoordinate: CLLocationCoordinate2D? = nil
        
        if let firstLongLat = firstLongLat{
            firstCoordinate = CLLocationCoordinate2D(latitude: firstLongLat.0, longitude: firstLongLat.1)
        }
        
        if let secondLongLat = secondLongLat{
            secondCoordinate = CLLocationCoordinate2D(latitude: secondLongLat.0, longitude: secondLongLat.1)
        }
        
        let firstLocation = Location(name: firstName, coordinate: firstCoordinate)
        let secondLocation = Location(name: secondName, coordinate: secondCoordinate)
        
        XCTAssertNotEqual(firstLocation, secondLocation, line:line)
    }
}
