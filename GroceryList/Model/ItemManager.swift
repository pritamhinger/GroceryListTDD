//
//  ItemManager.swift
//  GroceryList
//
//  Created by Pritam Hinger on 22/01/18.
//  Copyright © 2018 AppDevelapp. All rights reserved.
//

import Foundation

class ItemManager {
    var listsCount: Int {
        return items.count
    }
    
    var doneCount: Int{
        return doneItems.count
    }
    
    private var items = [ToDoItem]()
    private var doneItems = [ToDoItem]()
    
    func add(_ item: ToDoItem) {
        if !items.contains(item) {
            items.append(item)
        }
    }
    
    func item(at index: Int) -> ToDoItem {
        return items[index]
    }
    
    func checkItem(at index: Int) {
        let item = items.remove(at: index)
        doneItems.append(item)
    }
    
    func unCheckItem(at index: Int) {
        let item = doneItems.remove(at: index)
        items.append(item)
    }
    
    func doneItem(at index: Int) -> ToDoItem {
        return doneItems[index]
    }
    
    func removeAll() {
        items.removeAll()
        doneItems.removeAll()
    }
}
