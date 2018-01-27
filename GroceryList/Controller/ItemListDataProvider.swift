//
//  ItemListDataProvider.swift
//  GroceryList
//
//  Created by Pritam Hinger on 26/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let cellIdentifier = "ItemCellIdentifier"
    
    var itemManager: ItemManager?
    
    // MARK: - UITableViewDataSource DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManager else { return 0 }
        guard let itemSection =  Section(rawValue: section) else{
            fatalError("Invalid Section Number")
        }
        
        let numberOfRows:Int
        switch itemSection {
        case .toDoItem:
            numberOfRows = itemManager.listsCount
        case .doneItem:
            numberOfRows = itemManager.doneCount
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ItemCell
        
        guard let itemManager = itemManager else { fatalError("Data Manager is nil") }
        guard let section = Section(rawValue: indexPath.section) else{
            fatalError("Invalid Section")
        }
        
        let item:ToDoItem
        switch section {
        case .toDoItem:
            item = itemManager.item(at: indexPath.row)
        case .doneItem:
            item = itemManager.doneItem(at: indexPath.row)
        }
        
        cell.configCell(with: item)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // MARK: - UITableViewDelegate Delegate Methods
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        guard let section = Section(rawValue: indexPath.section) else{ fatalError() }
        
        let buttonTitle: String
        
        switch section {
        case .toDoItem:
            buttonTitle = "Check"
        case .doneItem:
            buttonTitle = "Uncheck"
        }
        return buttonTitle
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let itemManager = itemManager else { fatalError("Data Provider is nil")}
        
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Invalid Section")}
        
        switch section {
        case .toDoItem:
            itemManager.checkItem(at: indexPath.row)
        case .doneItem:
            itemManager.unCheckItem(at: indexPath.row)
        }
        
        tableView.reloadData()
    }
}

enum Section : Int{
    case toDoItem
    case doneItem
}
