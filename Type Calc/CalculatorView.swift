//
//  ContentView.swift
//  Type Calc
//
//  Created by Joshua Hoffman on 9/29/20.
//

import SwiftUI
import Expression

struct CalculatorView: View {
    
    @State private var isOnboarded = UserDefaults.standard.bool(forKey: "isOnboarded")
    @State private var helpPageIsShowing = false
    
    @State var currentText = ""
    @State var previous: [Solution] = [Solution(expression: "2 + 2", result: "4")]
    @State private var showingAlert = false
    @State private var showingCopiedText = false
    
    var body: some View {
        Group {
            VStack {
                Spacer()
                VStack (spacing: 1) {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(previous.reversed(), id: \.id) { row in
                                VStack {
                                    Divider()
                                    HStack {
                                        Text(row.expression)
                                            .foregroundColor(Color(NSColor.systemGray))
                                        Spacer()
                                        Button(action: {
                                            print(row.result ?? "")
                                            print("Clicked")
                                            let pasteboard = NSPasteboard.general
                                            pasteboard.clearContents()
                                            pasteboard.setString(row.result!, forType: .string)
                                        }, label: {
                                            Text(row.result ?? "Invalid")
                                                .padding(2)
                                                .contentShape(Rectangle())
                                        })
                                        .tooltip("Click to Copy")
                                        .buttonStyle(BorderlessButtonStyle())
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
                    .background(LinearGradient(gradient:  Gradient(colors: [Color(#colorLiteral(red: 0.3294117647, green: 0.2549019608, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.09411764706, green: 0.3333333333, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(5)
                    .padding(.horizontal, 5)
                    .frame(height: 7)
                    .shadow(radius: 20)
                    TextField("5 + 4", text: $currentText, onCommit: {
                        let expression = Expression(currentText)
                        var result = ""
                        do {
                            let numResult = try expression.evaluate()
                            let formatter = NumberFormatter()
                            formatter.minimumFractionDigits = 0
                            formatter.maximumFractionDigits = 2
                            result = formatter.string(from: NSNumber(value: numResult)) ?? ""
                            previous.append(Solution(expression: currentText, result: result))
                            currentText = ""
                        }
                        catch {
                            print("invalid expression")
                        }
                    })
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 20))
                    .background(Color.clear)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.top, 4)
                }
            }
        }
        .frame(minWidth: 500, maxWidth: 500, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
