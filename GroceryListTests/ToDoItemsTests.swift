//
//  ToDoItemsTests.swift
//  GroceryListTests
//
//  Created by Pritam Hinger on 21/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import XCTest
@testable import GroceryList

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
        XCTAssertEqual(item.location?.name, location.name, "should set location")
    }
}
