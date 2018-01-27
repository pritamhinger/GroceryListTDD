//
//  DetailViewControllerTests.swift
//  GroceryListTests
//
//  Created by Pritam Hinger on 27/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import XCTest
@testable import GroceryList
import CoreLocation

class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "DetailViewControllerId") as! DetailViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_HasTitleLabel() {
        let titleLabelIsSubView = sut.titleLabel?.isDescendant(of: sut.view) ?? false
        XCTAssertTrue(titleLabelIsSubView)
    }
    
    func test_HasLocationLabel() {
        let locationLabelIsSubView = sut.locationLabel.isDescendant(of: sut.view)
        XCTAssertTrue(locationLabelIsSubView)
    }
    
    func test_HasDateLabel() {
        let dateLabelIsSubView = sut.dateLabel.isDescendant(of: sut.view)
        XCTAssertTrue(dateLabelIsSubView)
    }
    
    func test_HasDescriptionLabel() {
        let descriptionLabelIsSubView = sut.descriptionLabel.isDescendant(of: sut.view)
        XCTAssertTrue(descriptionLabelIsSubView)
    }
    
    func test_HasMapView(){
        let mapViewIsSubView = sut.mapView.isDescendant(of: sut.view)
        XCTAssertTrue(mapViewIsSubView)
    }
    
    func test_SettingItemsInfo_SetsTextToLabels() {
        let title = "SampleList"
        let locationName = "HomeLocation"
        let desc = "Sample Description Goes Here"
        let coordinate = CLLocationCoordinate2D(latitude: 22.23, longitude: 24.33)
        let location = Location(name: locationName, coordinate: coordinate)
        let item = ToDoItem(title: title, itemDescription: desc, timestamp: 1456150025, location: location)
        let itemManager = ItemManager()
        itemManager.add(item)
        
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, title)
        XCTAssertEqual(sut.locationLabel.text, locationName)
        XCTAssertEqual(sut.dateLabel.text, "22-02-2016")
        XCTAssertEqual(sut.descriptionLabel.text, desc)
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, 22.23, accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, 24.33, accuracy: 0.001)
        
    }
    
    func test_CheckItem_ChecksItemInItemManager() {
        let itemManager = ItemManager()
        itemManager.add(ToDoItem(title: "SampleList"))
        
        sut.itemInfo = (itemManager, 0)
        sut.checkItem()
        
        XCTAssertEqual(itemManager.doneCount, 1)
        XCTAssertEqual(itemManager.listsCount, 0)
    }
}
