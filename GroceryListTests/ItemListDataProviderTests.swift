//
//  ItemListDataProviderTests.swift
//  GroceryListTests
//
//  Created by Pritam Hinger on 26/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import XCTest
@testable import GroceryList

class ItemListDataProviderTests: XCTestCase {
    
    static let cellIdentifier = "ItemCellIdentifier"
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewControllerId") as! ItemListViewController
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_NumberOfSections_IsTwo() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
        
    }
    
    func test_NumberOfRowsInFirstSection_EqualToListCount() {
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        sut.itemManager?.add(ToDoItem(title: "TestList"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        sut.itemManager?.add(ToDoItem(title: "TestList2"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_NumberOfRowsInSecondSection_IsEqualToCheckedCount() {
        sut.itemManager?.add(ToDoItem(title: "List1"))
        sut.itemManager?.add(ToDoItem(title: "List2"))
        sut.itemManager?.checkItem(at: 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.itemManager?.checkItem(at: 0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func test_CellForRow_ReturnsItemCell() {
        sut.itemManager?.add((ToDoItem(title: "TestList")))
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ItemCell)
    }
    
    func test_CellForRow_DequeueCellFromTableView() {
        let mockTableView = MockableTableView.mockTableView(withDataSource: sut)
        
        sut.itemManager?.add(ToDoItem(title: "SampleList"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellDequeued)
    }
    
    func test_CellForRow_CallsConfigCell() {
        let mockTableView = MockableTableView.mockTableView(withDataSource: sut)
        
        let item = ToDoItem(title: "TestList")
        sut.itemManager?.add(item)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockCell
        XCTAssertEqual(cell.cachedItem, item)
    }
    
    func test_CellForRowInSecondSection_CallsConfigCellWithDoneItem() {
        let mockTableView = MockableTableView.mockTableView(withDataSource: sut)
        
        sut.itemManager?.add(ToDoItem(title: "TestList1"))
        
        let secondItem = ToDoItem(title: "TestList2")
        sut.itemManager?.add(secondItem)
        sut.itemManager?.checkItem(at: 1)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockCell
        XCTAssertEqual(cell.cachedItem, secondItem)
    }
    
    func test_DeleteButton_InFirstSection_ShowTitleCheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(deleteButtonTitle, "Check")
    }
    
    func test_DeleteButton_InSecondSection_ShowTitleUncheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(deleteButtonTitle, "Uncheck")
    }
    
    func test_CheckingAnItem_UpdateItemManager() {
        sut.itemManager?.add(ToDoItem(title: "SampleList"))
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(sut.itemManager?.listsCount, 0)
        XCTAssertEqual(sut.itemManager?.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }
    
    func test_UncheckingAnItem_UncheckInItemManager() {
        sut.itemManager?.add(ToDoItem(title: "SampleList"))
        sut.itemManager?.checkItem(at: 0)
        tableView.reloadData()
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(sut.itemManager?.listsCount, 1)
        XCTAssertEqual(sut.itemManager?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
    }
}

extension ItemListDataProviderTests{
    class MockableTableView: UITableView {
        var cellDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockableTableView {
            let frame = CGRect(x: 0, y: 0, width: 320, height: 480)
            let mockTableView = MockableTableView(frame: frame, style: .plain)
            mockTableView.dataSource = dataSource
            mockTableView.register(MockCell.self, forCellReuseIdentifier: ItemListDataProviderTests.cellIdentifier)
            return mockTableView
        }
    }
    
    class MockCell: ItemCell {
        var cachedItem: ToDoItem?
        
        override func configCell(with item: ToDoItem, checked: Bool = false) {
            cachedItem = item
        }
    }
}
