//
//  Colors.swift
//  Todo
//
//  Created by Nuah on 2/3/23.
//
import SwiftUI

struct Colors {
    @Environment(\.colorScheme) var colorScheme
    
    static let background = Color(.systemBackground)
    static let accent = Color(.systemBlue)
    static let altFont = Color.white
    static let border = Color.gray
    static let darkBorder = Color(red: 0.85, green: 0.85, blue: 0.85)
}
