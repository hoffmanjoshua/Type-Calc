//
//  ContentView.swift
//  Shared
//
//  Created by Joshua Hoffman on 9/26/20.
//

import SwiftUI
import Expression
import MobileCoreServices

struct CalculatorView: View {
    
    @State private var isOnboarded = UserDefaults.standard.bool(forKey: "isOnboarded")
    @State private var helpPageIsShowing = false
    
    @State var currentText = ""
    @State var previous: [Solution] = []
    @State private var showingAlert = false
    @State private var showingCopiedText = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        helpPageIsShowing.toggle()
                    }, label: {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(#colorLiteral(red: 0.3307953775, green: 0.2530574799, blue: 1, alpha: 1)))
                    })
                    .padding()
                }
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
                                            .onTapGesture(count: 1) {
                                                UIPasteboard.general.setValue(row.result ?? "",
                                                        forPasteboardType: kUTTypePlainText as String)
                                                withAnimation {
                                                    showingCopiedText = true
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                    withAnimation {
                                                        showingCopiedText = false
                                                    }
                                                }
                                            }
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
                                    previous.append(Solution(expression: currentText, result: String(result)))
                                    currentText = ""
                                }
                                catch {
                                    showingAlert = true
                                }
                            })
                                .padding(.horizontal, 10)
                            .font(.system(size: 30))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .keyboardType(.alphabet)
                        )
                }
            }
            
            if (!isOnboarded){
                LaunchScreenView(isOnboarded: $isOnboarded)
            }
            
            if (showingCopiedText) {
                TextCopiedModalView()
            }
            
        }
        .sheet(isPresented: $helpPageIsShowing, content: {
            HelpSheetView(sheetOpen: $helpPageIsShowing)
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Invalid Expression"), message: Text("Please check your input."), dismissButton: .default(Text("Close")))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
        CalculatorView().colorScheme(.dark)
    }
}
