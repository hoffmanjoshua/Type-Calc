//
//  ContentView.swift
//  Shared
//
//  Created by Joshua Hoffman on 9/26/20.
//

import SwiftUI
import Expression

struct ContentView: View {
    
    @State var currentText = ""
    @State var previous: [Solution] = []
    
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 1) {
                ScrollView {
                    VStack {
                        ForEach(previous.reversed(), id: \.id) { row in
                            VStack {
                                Divider()
                                HStack {
                                    Text(row.expression)
                                        .foregroundColor(Color(UIColor.systemGray))
                                    Spacer()
                                    Text(row.result ?? "Invalid")
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
                    .cornerRadius(5)
                    .padding(.horizontal, 5)
                    .frame(height: 7)
                    .shadow(radius: 20)
                Rectangle()
                    .fill(Color(UIColor.systemBackground))
                    .frame(height: 75)
                    .padding(0)
                    .overlay(
                        TextField("5 + 4", text: $currentText, onCommit: {
                            let expression = Expression(currentText)
                            var result = ""
                            do {
                                let numResult = try expression.evaluate()
                                let formatter = NumberFormatter()
                                formatter.minimumFractionDigits = 0
                                formatter.maximumFractionDigits = 2
                                result = formatter.string(from: NSNumber(value: numResult)) ?? ""
                            }
                            catch {
                                result = "Invalid"
                            }
                            previous.append(Solution(expression: currentText, result: String(result)))
                            currentText = ""
                        })
                            .padding(.horizontal, 10)
                        .font(.system(size: 30))
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
