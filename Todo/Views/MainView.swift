//
//  MainView.swift
//  Todo
//
//  Created by Nuah on 2/6/23.
//

import SwiftUI

struct MainView: View {    
    var body: some View {
        TabView {
            ToDoView()
                .tabItem {
                    Label("ToDo", systemImage: "checklist")
                }
            NotesView()
                .tabItem {
                    Label("Notes", systemImage: "square.and.pencil")
                }
        }
    }
        
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
