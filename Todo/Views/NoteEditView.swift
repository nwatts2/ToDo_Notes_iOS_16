//
//  NoteEditView.swift
//  Todo
//
//  Created by Nuah on 2/4/23.
//

import SwiftUI
import Combine

struct NoteEditView: View {
    @EnvironmentObject var viewModel: NotesViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var isPresentingConfirm: Bool = false
    
    var note: NotesEntry
    
    @State var currentTitle: String = ""
    @State var currentContent: String = ""
    
    init(note: NotesEntry) {
        self.note = note
        _currentTitle = State(initialValue: note.title)
        _currentContent = State(initialValue: note.content)
    }
    
    let titleLimit = 30
    let contentLimit = 10000
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Colors.background.ignoresSafeArea()
                VStack {
                        VStack(alignment: .leading) {
                            TextField("Title", text: $currentTitle, axis: .vertical)
                                .font(.title)
                                .underline()
                                .onReceive(Just(currentTitle)) {_ in limitTitle(titleLimit)}
                            TextField("Note", text: $currentContent, axis: .vertical)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .onReceive(Just(currentContent)) {_ in limitContent(contentLimit)}
                            Spacer()
                            Text("\(currentContent.count) / \(contentLimit)")
                                .font(.callout)
                        }
                        .padding()
                    Spacer()
                    Button (role: .destructive) {
                        isPresentingConfirm = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete Note")
                        }
                    }
                    .confirmationDialog("Are you sure you would like to delete the note '\(currentTitle)'?",
                                        isPresented: $isPresentingConfirm) {
                        Button("Delete Note", role: .destructive) {
                            viewModel.deleteItem(title: note.title, content: note.content)
                            dismiss()
                        }
                    } message: {
                        Text("Are you sure you would like to delete the note '\(currentTitle)'? You cannot undo this action")
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        if note.title == "" || note.content == "" {
                            viewModel.deleteItem(title: note.title, content: note.content)
                        }
                        dismiss()
                    } label: {
                        Text("Discard")
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        viewModel.editItem(oldTitle: note.title, oldContent: note.content, title: currentTitle, content: currentContent)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(currentTitle == "" || currentContent == "")
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    func limitTitle(_ upperLimit: Int) {
        if (currentTitle.count > upperLimit) {
            currentTitle = String(currentTitle.prefix(upperLimit))
        }
    }
    
    func limitContent(_ upperLimit: Int) {
        if (currentContent.count > upperLimit) {
            currentContent = String(currentContent.prefix(upperLimit))
        }
    }
}

struct NoteEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditView(note: NotesEntry(id: 0, title: "Shopping List", content: "Eggs\nButter\nMilk")).environmentObject(NotesViewModel())
    }
}
