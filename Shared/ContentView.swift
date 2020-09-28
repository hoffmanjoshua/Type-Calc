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
    @State private var helpPageIsShowing = false
    
    @State var currentText = ""
    @State var previous: [Solution] = []
    @State private var showingAlert = false
    
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
                LaunchScreen(isOnboarded: $isOnboarded)
            }
        }
        .sheet(isPresented: $helpPageIsShowing, content: {
            HelpSheet(sheetOpen: $helpPageIsShowing)
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Invalid Expression"), message: Text("Please check your input."), dismissButton: .default(Text("Close")))
        }
    }
    
}

struct LaunchScreen: View {
    
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
                                Text("Type Calc supports basic math operations (+, -, /, *) and other functions")
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

struct HelpSheet: View {
    
    @Binding var sheetOpen: Bool
    
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                Text("Operations and Methods")
                    .font(.title)
                    .bold()
                Divider()
                    .padding()
                Text("Basic Operations")
                    .font(.headline)
                LazyVGrid(columns: [GridItem(.flexible()),
                                    GridItem(.flexible())], alignment: .leading, content: /*@START_MENU_TOKEN@*/{
                    HStack {
                        Text("Add")
                        Text("+")
                            .font(.system(.body, design: .monospaced))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                    }
                            HStack {
                                Text("Subtract")
                                Text("-")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("Multiply")
                                Text("*")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("Divide")
                                Text("/")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                }/*@END_MENU_TOKEN@*/)
                
                Text("Mathematical Functions")
                    .font(.headline)
                    .padding(.top)
                LazyVGrid(columns: [GridItem(.flexible()),
                          GridItem(.flexible())], alignment: .leading, content: /*@START_MENU_TOKEN@*/{
                            HStack {
                                Text("Power")
                                Text("pow(x, y)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("Sqr. Root")
                                Text("sqrt(x)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("Absolute Value")
                                Text("abs(x)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("Floor")
                                Text("floor(x)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("Ceiling")
                                Text("ceil(x)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("Round ")
                                Text("round(x)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                }/*@END_MENU_TOKEN@*/)
                Text("Trig Functions")
                    .font(.headline)
                    .padding(.top)
                Text("(Input in radians)")
                    .font(.subheadline)
                    .padding(.bottom, 2)
                LazyVGrid(columns: [GridItem(.flexible()),
                          GridItem(.flexible())], alignment: .leading, content: /*@START_MENU_TOKEN@*/{
                            HStack {
                                Text("Cosine")
                                Text("cos(x)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("cos")
                                    .font(.callout)
                                    + Text("-1")
                                        .font(.system(size: 8.0))
                                        .baselineOffset(6.0)
                                Text("acos(x)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("Sine")
                                Text("sin(x)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("sin")
                                    .font(.callout)
                                    + Text("-1")
                                        .font(.system(size: 8.0))
                                        .baselineOffset(6.0)
                                Text("asin(x)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("Tangent")
                                Text("tan(x)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                            HStack {
                                Text("tan")
                                    .font(.callout)
                                    + Text("-1")
                                        .font(.system(size: 8.0))
                                        .baselineOffset(6.0)
                                Text("atan(x)")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.quaternarySystemFill)))
                            }
                }/*@END_MENU_TOKEN@*/)
            }
            .padding()
            .frame(maxWidth: .infinity)
            Button(action: {
                sheetOpen = false
            }, label: {
                Text("Back to Calculator")
                    .font(.system(size: 20))
                    .padding()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 20.0).fill(Color(#colorLiteral(red: 0.3307953775, green: 0.2530574799, blue: 1, alpha: 1))))
                    .shadow(radius: 2)
                    .padding()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().colorScheme(.dark)
    }
}
