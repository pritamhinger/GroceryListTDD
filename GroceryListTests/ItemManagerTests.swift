//
//  ItemManagerTests.swift
//  GroceryListTests
//
//  Created by Pritam Hinger on 22/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import XCTest
@testable import GroceryList

class ItemManagerTests: XCTestCase {
    
    var sut:ItemManager!
    
    override func setUp() {
        super.setUp()
        sut = ItemManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_GroceryListItemCount_IsZero() {
        XCTAssertEqual(sut.listsCount, 0, "Initially count should be zero")
    }
    
    func test_GroceryList_DoneCount_ISZero(){
        XCTAssertEqual(sut.doneCount, 0, "Intially done count should be zero")
    }
    
    func test_addItem_IncreaseCountByOne() {
        sut.add(ToDoItem(title: "List1"))
        XCTAssertEqual(sut.listsCount, 1, "There should be one item in the list")
    }
    
    func test_ItemAt_ReturnsTheItemAdded() {
        let item = ToDoItem(title: "List1")
        sut.add(item)
        let returnedItem = sut.item(at: 0)
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_CheckItemAt_ChangesCheckCount() {
        sut.add(ToDoItem(title: ""))
        sut.checkItem(at: 0)
        XCTAssertEqual(sut.listsCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    func test_CheckItemAt_RemoveItemFromList() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        sut.add(firstItem)
        sut.add(secondItem)
        
        sut.checkItem(at: 0)
        XCTAssertEqual(sut.item(at: 0).title, secondItem.title, "Check Item should remove the first item")
    }
    
    func test_DoneItemAt_ReturnCheckedItem(){
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        sut.add(firstItem)
        sut.add(secondItem)
        
        sut.checkItem(at: 0)
        let item = sut.doneItem(at: 0)
        XCTAssertEqual(item.title, firstItem.title)
    }
}
