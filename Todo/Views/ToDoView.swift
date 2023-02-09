//
//  ToDo.swift
//  Todo
//
//  Created by Nuah on 2/6/23.
//

import SwiftUI

struct ToDoView: View {
    @ObservedObject var viewModel = ToDoViewModel()
            
    var body: some View {
        NavigationView {
            ZStack {
                Colors.background.ignoresSafeArea()
                VStack () {
                    Spacer()
                    List (viewModel.list, id: \.id) { item in
                        if !viewModel.deleteMode || item.id != viewModel.listCount - 1 {
                            ToDoEntryView(entry: item)
                        }
                    }
                    .listStyle(.plain)
                    .animation(.easeInOut)
                    .id(UUID())
                    Spacer()
                    Button (viewModel.deleteMode ? "Cancel" : "Delete Items", role: viewModel.deleteMode ? .cancel : .destructive) {
                        viewModel.deleteMode.toggle()
                    }
                }
                .padding([.trailing, .bottom], 10)
            }
            .environmentObject(viewModel)
            .navigationTitle("To Do")
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
