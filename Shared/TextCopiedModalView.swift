//
//  TextCopiedModalView.swift
//  Type-Calc
//
//  Created by Joshua Hoffman on 9/27/20.
//

import SwiftUI

struct TextCopiedModalView: View {
    var body: some View {
        ZStack {
            Color(red: 0, green: 0, blue: 0, opacity: 0.8)
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            Text("Value copied to clipboard")
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(UIColor.tertiarySystemBackground)))
        }
    }
}
