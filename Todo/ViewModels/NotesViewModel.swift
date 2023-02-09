//
//  ListViewModel.swift
//  Todo
//
//  Created by Nuah on 2/3/23.
//

import SwiftUI

class NotesViewModel: ObservableObject {
    @Published var listMain = Notes()
    
    var list: [NotesEntry] {
        return listMain.list
    }
    
    func addItem(title: String, content: String) {
        listMain.addNotesEntry(title: title, content: content)
        saveNotes()
    }
    
    func deleteItem(title: String, content: String) {
        for index in 0..<listMain.list.count {
            if listMain.list[index].title == title && listMain.list[index].content == content {
                listMain.deleteNotesEntry(id: index)
                break
            }
        }
        
        saveNotes()
    }
    
    func editItem(oldTitle: String, oldContent: String, title: String, content: String) {
        for index in 0..<listMain.list.count {
            if listMain.list[index].title == oldTitle && listMain.list[index].content == oldContent {
                
                listMain.editNotesEntry(id: index, title: title, content: content)
                break
            }
        }
        
        saveNotes()
    }
    
    func saveNotes() {
        Notes.saveNotes(newList: list)
    }
    
}
