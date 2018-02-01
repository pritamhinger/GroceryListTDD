//
//  InputViewControllerTests.swift
//  GroceryListTests
//
//  Created by Pritam Hinger on 27/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import XCTest
@testable import GroceryList
import CoreLocation

class InputViewControllerTests: XCTestCase {
    
    var sut: InputViewController!
    var placemark: MockPlacemark!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "InputViewControllerId") as! InputViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_HasTitleTextField() {
        let titleTextFieldIsSubView = sut.titleTextField.isDescendant(of: sut.view)
        XCTAssertTrue(titleTextFieldIsSubView)
    }
    
    func test_HasAddressTextField() {
        let addressTextFieldInSubView = sut.addressTextField.isDescendant(of: sut.view)
        XCTAssertTrue(addressTextFieldInSubView)
    }
    
    func test_HasDateTextField() {
        let dateTextFieldInSubView = sut.dateTextField.isDescendant(of: sut.view)
        XCTAssertTrue(dateTextFieldInSubView)
    }
    
    func test_HasLocationTextField() {
        let locationTextFieldInSubView = sut.locationTextField.isDescendant(of: sut.view)
        XCTAssertTrue(locationTextFieldInSubView)
    }
    
    func test_HasDescriptionTextField() {
        let descriptionTextFieldInSubView = sut.descriptionTextField.isDescendant(of: sut.view)
        XCTAssertTrue(descriptionTextFieldInSubView)
    }
    
    func test_Save_FetchedCoordinatesFromAddressStringUsingGeoCoder() {
        let title = "SampleList"
        let homeLocation = "HomeLocation"
        let addressString = "New Delhi Railway Station"
        let descriptionString = "Sample Description goes here..!!"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let timestamp:Double = 1456079400
        let date = Date(timeIntervalSince1970: timestamp)
        sut.titleTextField.text = title
        sut.dateTextField.text = dateFormatter.string(from: date)
        sut.locationTextField.text = homeLocation
        sut.addressTextField.text = addressString
        sut.descriptionTextField.text = descriptionString
        
        let mockGeoCoder = MockGeoCoder()
        sut.geoCoder = mockGeoCoder
        
        sut.itemManager = ItemManager()
        sut.save()
        
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2D(latitude: 33.22, longitude: 22.33)
        placemark.mockCoordinate = coordinate
        mockGeoCoder.completionHandler?([placemark], nil)
        
        let item = sut.itemManager?.item(at: 0)
        let testItem = ToDoItem(title: title, itemDescription: descriptionString, timestamp: timestamp, location: Location(name: homeLocation, coordinate: coordinate))
        
        XCTAssertEqual(item, testItem)
    }
    
    func test_Save_WithMinimumInput() {
        let title = "SampleList"
        sut.titleTextField.text = title
        let mockGeoCoder = MockGeoCoder()
        sut.geoCoder = mockGeoCoder
        
        sut.itemManager = ItemManager()
        sut.save()
        
        let item = sut.itemManager?.item(at: 0)
        let testItem = ToDoItem(title: title)
        XCTAssertEqual(item, testItem)
    }
    
    func test_SaveButton_SaveActionIsInvokedOnClick(){
        let saveButton: UIButton = sut.saveButton
        guard let actions = saveButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(actions.contains("save"))
    }
    
    func test_GeoCoder_FetchCoordinates() {
        let geoCoderAnswered = expectation(description: "CLGeoCoder")
        let address = "Infinite Loop 1, Cupertino"
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            let coordinate = placemarks?.first?.location?.coordinate
            guard let latitude = coordinate?.latitude else{
                XCTFail()
                return
            }
            
            guard let longitude = coordinate?.longitude else{
                XCTFail()
                return
            }
            
            XCTAssertEqual(latitude, 37.3316, accuracy: 0.001)
            XCTAssertEqual(longitude, -122.0300, accuracy: 0.001)
            geoCoderAnswered.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}

extension InputViewControllerTests{
    class MockGeoCoder: CLGeocoder{
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation?{
            guard let coordinate = mockCoordinate else{ return CLLocation() }
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
}
