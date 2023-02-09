//
//  NoteListView.swift
//  Todo
//
//  Created by Nuah on 2/3/23.
//

import SwiftUI

struct NoteListView: View {
    @EnvironmentObject var viewModel: NotesViewModel
    
    var note: NotesEntry
    
    var body: some View {
        ZStack (alignment: Alignment(horizontal: .leading, vertical: .top)) {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Colors.accent, lineWidth: 4)
                .background(RoundedRectangle(cornerRadius: 20).fill(Colors.accent))
            VStack (alignment: .leading, spacing: 20){
                Text(note.title)
                    .font(.system(size: 20))
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Colors.altFont)
                Text(note.content)
                    .font(.system(size: 15))
                    .foregroundColor(Colors.altFont)
            }
            .padding()
            
        }
        .frame(width:170, height: 170)
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView(note: NotesEntry(id: 0, title: "Shopping List", content: "This is going to be a lot of text you hear me sir this")).environmentObject(NotesViewModel())
    }
}
