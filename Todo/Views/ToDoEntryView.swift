//
//  ToDoEntryView.swift
//  Todo
//
//  Created by Nuah on 2/6/23.
//

import SwiftUI

struct ToDoEntryView: View {
    @EnvironmentObject var viewModel: ToDoViewModel
    
    var entry: ToDoEntry
    
    @State var note: String = ""
    
    @FocusState private var focused: Bool
        
    init(entry: ToDoEntry) {
        self.entry = entry
        _note = State(initialValue: entry.value)
    }
    
    var body: some View {
        HStack {
            Button {
                if entry.isChecked {
                    viewModel.checkItem(at: entry.id, isChecked: false)
                } else {
                    viewModel.checkItem(at: entry.id, isChecked: true)

                }
                                
            } label: {
                Image(systemName: entry.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Colors.accent)
                    .opacity(viewModel.deleteMode ? 0 : 1)
                    .frame(width: viewModel.deleteMode ? 0 : 25)
            }
            .disabled(viewModel.deleteMode || entry.id == viewModel.listCount - 1)
                .animation(.easeInOut(duration: 0.2).delay(viewModel.deleteMode ? 0 : 0.15))
            
            TextField("Enter new note", text: $note)
                .onChange(of: note) { [note] newValue in
                    if newValue == "" && viewModel.listCount > 1 {
                        viewModel.removeItem(at: entry.id)
                    } else {
                        if note == "" {
                            viewModel.addItem("")
                            viewModel.editItem(at: entry.id, value: newValue)
                        } else {
                            viewModel.editItem(at: entry.id, value: newValue)

                        }
                    }
                }
                .strikethrough(entry.isChecked)
                .disabled(entry.isChecked)
                .focused($focused)
                .animation(.easeInOut(duration: 0.2).delay(viewModel.deleteMode ? 0.15 : 0))
                .onAppear(perform: {
                    if (viewModel.focusedIndex == entry.id) {
                        focused = true
                    } else {
                        focused = false
                    }
                })
            Button (role: .destructive) {
                if entry.id < viewModel.listCount - 1 && viewModel.listCount > 1{
                    viewModel.removeItem(at: entry.id)
                }
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .opacity(viewModel.deleteMode ? 1 : 0)
            }
            .disabled(!viewModel.deleteMode || entry.id == viewModel.listCount - 1)
            .animation(.easeInOut(duration: 0.2).delay(viewModel.deleteMode ? 0.15 : 0))
            
            Spacer()
        }
        .padding()
    }
}

struct ToDoEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoEntryView(entry: ToDoEntry(id: 0, value: "String Cheese", isChecked: false))
            .environmentObject(ToDoViewModel())
    }
}
