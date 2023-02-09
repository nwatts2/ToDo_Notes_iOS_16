//
//  List.swift
//  Todo
//
//  Created by Nuah on 2/3/23.
//

import Foundation

struct Notes {
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("notes").appendingPathExtension("plist")
    
    private(set) var list: [NotesEntry]
        
    init() {
        let loadedList = Notes.loadNotes()
        
        if loadedList.count > 0 {
            self.list = loadedList
        } else {
            self.list = []
        }
    }
    
    mutating func addNotesEntry(title: String, content: String) {
        let item = NotesEntry(id: list.count, title: title, content: content)
        
        list.append(item)
    }
    
    mutating func deleteNotesEntry(id: Int) {
        list.remove(at: id)
        
        for index in id..<list.count {
            list[index].id = index
        }
    }
    
    mutating func editNotesEntry(id: Int, title: String, content: String) {
        list[id].title = title
        list[id].content = content
    }
    
    static func saveNotes(newList: [NotesEntry]) {
        let encoder = PropertyListEncoder()
        
        let codedList = try? encoder.encode(newList)
        
        try? codedList?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadNotes() -> [NotesEntry] {
        let decoder = PropertyListDecoder()
        
        guard let codedList = try? Data(contentsOf: ArchiveURL) else {return []}
        
        return try! decoder.decode(Array<NotesEntry>.self, from: codedList)
    }
        
}

struct NotesEntry: Identifiable, Codable {
    var id: Int
    var title: String
    var content: String
    
    init(id: Int, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
}
