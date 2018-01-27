//
//  ItemListViewController.swift
//  GroceryListTests
//
//  Created by Pritam Hinger on 26/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import XCTest
@testable import GroceryList

class ItemListViewControllerTest: XCTestCase {
    
    lazy var sut: ItemListViewController! = {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ItemListViewControllerId")
        let sut = viewController as! ItemListViewController
        sut.loadViewIfNeeded()
        return sut
    }()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_TableView_IsNotNil_AfterViewDidLoad() {
        XCTAssertNotNil(sut.tableView, "Table View should be not nil")
    }
    
    func test_LoadingView_SetsTableViewDataSource() {
        XCTAssertTrue(sut.tableView?.dataSource is ItemListDataProvider)
    }
    
    func test_LoadingView_SetsTableViewDelegate() {
        XCTAssertTrue(sut.tableView?.delegate is ItemListDataProvider)
    }
    
    func test_LoadingView_DelegateAndDataSource_AreEqual() {
        XCTAssertEqual(sut.tableView?.delegate as? ItemListDataProvider, sut.tableView?.dataSource as? ItemListDataProvider)
    }
}













