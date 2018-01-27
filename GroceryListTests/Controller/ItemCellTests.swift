//
//  ItemCellTests.swift
//  GroceryListTests
//
//  Created by Pritam Hinger on 26/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import XCTest
@testable import GroceryList
import CoreLocation

class ItemCellTests: XCTestCase {

    static let cellIdentifier = "ItemCellIdentifier"
    
    var controller: ItemListViewController!
    var tableView: UITableView!
    var cell: ItemCell!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewControllerId") as! ItemListViewController
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        let datasource = FakeListDataSource()
        tableView.dataSource = datasource
        
        cell = tableView.dequeueReusableCell(withIdentifier: ItemCellTests.cellIdentifier, for: IndexPath(row: 0, section: 0)) as! ItemCell
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_HasNameLabel() {
        XCTAssertNotNil(cell.titleLabel)
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func test_ItemCell_HasLocationLabel() {
        XCTAssertNotNil(cell.locationLabel)
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func test_ItemCell_HasDateLabel() {
        XCTAssertNotNil(cell.dateLabel)
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    func test_ConfigCell_SetTitle() {
        let title = "SampleList"
        cell.configCell(with: ToDoItem(title: title))
        XCTAssertEqual(cell.titleLabel.text, title)
    }
    
    func test_ConfigCell_SetDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: "24-12-1987")
        let timestamp = date?.timeIntervalSince1970
        cell.configCell(with: ToDoItem(title: "SampleList", timestamp: timestamp))
        XCTAssertEqual(cell.dateLabel.text, "24-12-1987")
    }
    
    func test_ConfigCell_SetLocation() {
        let latitude = 0.0
        let longitude = 1.0
        let landmark = "TestLocation"
        
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let location = Location(name: landmark, coordinate: coordinates)
        
        cell.configCell(with: ToDoItem(title: "SampleList", location: location))
        XCTAssertEqual(cell.locationLabel.text, landmark)
    }
    
    func test_Title_WhenItemIsChecked_IsStrokeThrough(){
        let listTitle = "SampleList"
        let location = Location(name: "TestLocation")
        let item = ToDoItem(title: listTitle, itemDescription: nil, timestamp: 1456150025, location: location)
        
        cell.configCell(with: item, checked: true)
        let attributedString = NSAttributedString(string: listTitle, attributes: [NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue])
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
}

extension ItemCellTests{
    class FakeListDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
