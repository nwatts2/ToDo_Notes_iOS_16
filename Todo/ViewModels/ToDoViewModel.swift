//
//  ToDoViewModel.swift
//  Todo
//
//  Created by Nuah on 2/6/23.
//

import SwiftUI

class ToDoViewModel: ObservableObject {
    @ObservedObject var todo = ToDo()
    
    @Published var deleteMode: Bool = false
    @Published var focusedIndex: Int = 100
    
    var list: [ToDoEntry] {
        return todo.list
    }
    
    var listCount: Int {
        return todo.list.count
    }
      
    
    func addItem (_ value: String) {
        todo.addListItem(value: value)
        saveList()
    }
    
    func checkItem (at index: Int, isChecked: Bool) {
        todo.checkListItem(index: index, isChecked: isChecked)
        saveList()
    }
    
    func editItem (at index: Int, value: String) {
        todo.editListItem(index: index, value: value)
        self.focusedIndex = index
        saveList()
    }
    
    func removeItem (at index: Int) {
        todo.removeListItem(index: index)
        saveList()
    }
    
    func saveList () {
        ToDo.saveList(newList: todo.list)
        updateView()
    }
    
    func updateView() {
        self.objectWillChange.send()
    }
    
}
