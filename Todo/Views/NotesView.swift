//
//  ContentView.swift
//  Todo
//
//  Created by Nuah on 2/3/23.
//

import SwiftUI

struct NotesView: View {
    @StateObject var viewModel = NotesViewModel()
    @State var deleteMode: Bool = false
    
    @GestureState var isUpdating = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack {
                Colors.background.ignoresSafeArea()
                VStack {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.list) { item in
                            NavigationLink(
                                destination: NoteEditView(note: item),
                                label: {
                                    NoteListView(note: item)
                                }
                            )
                        }
                    }
                    Spacer()
                    NavigationLink (
                        destination: NoteEditView(note: NotesEntry(id: viewModel.list.count, title: "", content:"")),
                        label: {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Add")
                            }
                            .font(.headline)
                            .foregroundColor(Colors.accent)
                            .padding()
                        }
                    )
                    .simultaneousGesture(TapGesture().onEnded{
                        viewModel.addItem(title: "", content: "")
                    })
                }
                .padding()
            }
            .navigationTitle("Notes")
        }
        .environmentObject(viewModel)
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
