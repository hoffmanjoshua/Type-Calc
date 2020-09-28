//
//  ContentView.swift
//  Shared
//
//  Created by Joshua Hoffman on 9/26/20.
//

import SwiftUI
import Expression

struct ContentView: View {
    
    @State private var isOnboarded = UserDefaults.standard.bool(forKey: "isOnboarded")
    
    @State var currentText = ""
    @State var previous: [Solution] = []
    
    var body: some View {
        ZStack {
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
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        )
                }
            }
            
            if (!isOnboarded){
                HelpScreen(isOnboarded: $isOnboarded)
            }
        }
    }
    
}

struct HelpScreen: View {
    
    @Binding var isOnboarded: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Color(red: 0, green: 0, blue: 0, opacity: 0.8)
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Welcome to Type Calc!")
                        .font(.title)
                    Divider()
                    Text("Some quick tips:")
                        .font(.title3)
                        .bold()
                        .padding()
                    VStack(alignment: .leading, spacing: 7){
                        HStack(alignment: .top) {
                            VStack {
                                Text("•")
                                    .bold()
                            }
                            Text("Type your expression into the text box below the line, and hit return to get your result.")
                        }
                        HStack(alignment: .top) {
                            VStack {
                                Text("•")
                                    .bold()
                            }
                            HStack {
                                Text("Type Calc supports basic math operations (+, -, /, x) and other functions")
                            }
                            
                        }
                        HStack(alignment: .top) {
                            VStack {
                                Text("•")
                                    .bold()
                            }
                            HStack {
                                Text("Press \(Image(systemName: "questionmark.circle.fill")) to learn about all of the different operations and functions that Type Calc supports.")
                            }
                            
                        }
                        
                    }
                    .font(.system(size: 20))
                    
                    Button(action: {
                        UserDefaults.standard.set(true, forKey: "isOnboarded")
                        isOnboarded = true
                    }, label: {
                        Text("Get Started")
                            .font(.system(size: 20))
                            .padding()
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 25.0).fill(Color(#colorLiteral(red: 0.3307953775, green: 0.2530574799, blue: 1, alpha: 1))))
                            .shadow(radius: 2)
                            .padding()
                    })
                    
                }
                .padding()
                .frame(maxWidth: 350, minHeight: 500)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                    .fill(Color(UIColor.secondarySystemBackground)))
                .shadow(radius: 20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().colorScheme(.dark)
    }
}
