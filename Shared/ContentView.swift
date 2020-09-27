//
//  ContentView.swift
//  Shared
//
//  Created by Joshua Hoffman on 9/26/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentText = ""
    @State var previous: [String] = ["5 + 1", "6 x 3"]
    
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 1) {
                ScrollView {
                    VStack {
                        ForEach(previous.reversed(), id: \.self) { row in
                            VStack {
                                Divider()
                                HStack {
                                    Text(row)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            }
                            .rotationEffect(.degrees(180))
                        }
                    }
                    .background(Color.clear)
                }
                .rotationEffect(.degrees(180))
                .padding(.bottom)
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient:  Gradient(colors: [Color(#colorLiteral(red: 0.3307953775, green: 0.2530574799, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.09580274671, green: 0.3324514627, blue: 0.9993233085, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .frame(height: 30)
                    .shadow(radius: 20)
                Rectangle()
                    .fill(Color(UIColor.systemBackground))
                    .frame(height: 75)
                    .padding(0)
                    .overlay(
                        TextField("5 + 4", text: $currentText, onCommit: {
                            previous.append(currentText)
                            currentText = ""
                        })
                            .padding(.horizontal, 10)
                        .font(.system(size: 30, design: .serif))
                    )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
