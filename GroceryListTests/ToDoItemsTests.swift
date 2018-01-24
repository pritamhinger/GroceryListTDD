//
//  ToDoItemsTests.swift
//  GroceryListTests
//
//  Created by Pritam Hinger on 21/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import XCTest
@testable import GroceryList
import CoreLocation

class ToDoItemsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_initialize_withTitle(){
        let item = ToDoItem(title: "TestList")
        XCTAssertEqual(item.title, "TestList")
        XCTAssertEqual(item.itemDescription, nil)
    }
    
    func test_initilize_withTitleAndDescription(){
        let item = ToDoItem(title: "TestList", itemDescription: "this is test list description")
        XCTAssertEqual(item.title, "TestList")
        XCTAssertEqual(item.itemDescription, "this is test list description")
    }
    
    func test_initialize_WithTitleAndTimestamp() {
        let item = ToDoItem(title: "TestList", timestamp: 0.0)
        XCTAssertEqual(item.title, "TestList")
        XCTAssertEqual(item.timestamp, 0.0, "Timestamp should be nil")
    }
    
    func test_initialize_WithTitleAndLocation(){
        let location = Location(name: "DummyLocation")
        let item = ToDoItem(title: "TestList", location: location)
        XCTAssertEqual(item.location, location, "should set location")
    }
    
    func test_EqualItems_AreEqual() {
        let firstItem = ToDoItem(title: "ListItem")
        let secondItem = ToDoItem(title: "ListItem")
        
        XCTAssertEqual(firstItem, secondItem)
    }
    
    func test_Items_WhenLocationIsNotSame_AreUnequal() {
        let firstItem = ToDoItem(title: "ListItem", location: Location(name: "Location1"))
        let secondItem = ToDoItem(title: "ListItem", location: Location(name: "Location2"))
        XCTAssertNotEqual(firstItem, secondItem, "Item with different location are not equal")
    }
    
    func test_Items_WhenOneLocationIsNil_AreUnequal() {
        let firstItem = ToDoItem(title: "ListItem", location: Location(name: "Location1", coordinate: nil))
        let secondItem = ToDoItem(title: "ListItem", location: Location(name: "Location1", coordinate: CLLocationCoordinate2D(latitude: 1, longitude: 2)))
        
        XCTAssertNotEqual(firstItem, secondItem, "Items with different location are not equal")
    }
    
    func test_Items_WhenTimestampDiffer_AreNotEqual(){
        let firstItem = ToDoItem(title: "ListItem", timestamp: 1.0)
        let secondItem = ToDoItem(title: "ListItem", timestamp: 2.0)
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func test_Items_WhenDescriptionDiffer_AreNotEqual(){
        let firstItem = ToDoItem(title: "ListItem", itemDescription: "First List Description")
        let secondItem = ToDoItem(title: "ListItem", itemDescription: "Second List Description")
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func test_Items_WhenTitleDiffer_AreNotEqual(){
        let firstItem = ToDoItem(title: "FirstList")
        let secondItem = ToDoItem(title: "SecondList")
        XCTAssertNotEqual(firstItem, secondItem)
    }
}







