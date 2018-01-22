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
        items.append(item)
    }
    
    func item(at index: Int) -> ToDoItem {
        return items[index]
    }
    
    func checkItem(at index: Int) {
        doneItems.insert(item(at: index), at: index)
        items.remove(at: index)
    }
    
    func doneItem(at index: Int) -> ToDoItem {
        return doneItems[index]
    }
}
