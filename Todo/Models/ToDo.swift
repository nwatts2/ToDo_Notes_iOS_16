//
//  ToDo.swift
//  Todo
//
//  Created by Nuah on 2/6/23.
//

import Foundation

class ToDo: ObservableObject {
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todo").appendingPathExtension("plist")
    
    @Published var list: [ToDoEntry]
    
    init() {
        let loadedList = ToDo.loadList()
        
        if loadedList.count > 1 {
            self.list = loadedList
        } else {
            self.list = [ToDoEntry(id: 0, value: "", isChecked: false)]
        }
    }
    
    func addListItem(value: String) {
        self.list.insert(ToDoEntry(id: self.list.count - 1, value: value, isChecked: false), at: self.list.count - 1)
        self.list[self.list.count - 1].id = self.list.count - 1
        
        print(self.list)
    }
    
    func checkListItem(index: Int, isChecked: Bool) {
        self.list[index].isChecked = isChecked
    }
    
    func editListItem(index: Int, value: String) {
        self.list[index].value = value
    }
    
    func removeListItem(index: Int) {
        self.list.remove(at: index)
        for i in index..<self.list.count {
            self.list[i].id -= 1
        }
        print(self.list)
    }
    
    static func saveList (newList: [ToDoEntry]) {
        let encoder = PropertyListEncoder()
        
        let codedList = try? encoder.encode(newList)
        
        try? codedList?.write(to: ArchiveURL, options: .noFileProtection)
        
    }
    
    static func loadList () -> [ToDoEntry] {
        guard let codedList = try? Data(contentsOf: ArchiveURL) else {return []}
        
        let decoder = PropertyListDecoder()
        return try! decoder.decode(Array<ToDoEntry>.self, from: codedList)
    }
}

struct ToDoEntry: Identifiable, Codable {
    var id: Int
    var value: String
    var isChecked: Bool
    
    init(id: Int, value: String, isChecked: Bool) {
        self.id = id
        self.value = value
        self.isChecked = isChecked
    }
}
