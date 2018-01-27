//
//  File.swift
//  GroceryList
//
//  Created by Pritam Hinger on 27/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var saveButton:UIButton!
    
    lazy var geoCoder = CLGeocoder()
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    var itemManager: ItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
    }
    
    @objc func save() {
        guard let titleString = titleTextField.text, titleString.count > 0 else { return }
        let date:Date?
        
        if let dateText = dateTextField.text, dateText.count > 0{
            date = dateFormatter.date(from: dateText)
        }
        else{
            date = nil
        }
        
        var descriptionString: String?
        if let str = descriptionTextField.text, str.count > 0{
            descriptionString = str
        }
        else{
            descriptionString = nil
        }
        
        var location: Location?
        
        if let locationName = locationTextField.text, locationName.count > 0{
            if let address = addressTextField.text, address.count > 0{
                geoCoder.geocodeAddressString(address, completionHandler: {[unowned self](placeMarks, error) in
                    let placeMark = placeMarks?.first
                    location = Location(name: locationName, coordinate: placeMark?.location?.coordinate)
                    let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: location)
                    self.itemManager?.add(item)
                })
            }
        }
        else{
            let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: nil)
            itemManager?.add(item)
        }
    }
    
    
}
