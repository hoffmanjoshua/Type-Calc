//
//  HelpSheetView.swift
//  Type-Calc
//
//  Created by Joshua Hoffman on 9/27/20.
//

import SwiftUI

struct HelpSheetView: View {
    
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
                                    GridItem(.flexible())], alignment: .leading, spacing: 3, content: /*@START_MENU_TOKEN@*/{
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
                                    GridItem(.flexible())], alignment: .leading, spacing: 3, content: /*@START_MENU_TOKEN@*/{
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
                                Text("Abs. Value")
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
                          GridItem(.flexible())], alignment: .leading, spacing: 3, content: /*@START_MENU_TOKEN@*/{
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
            
            VStack {
                Divider()
                Text("Extra tip \(Image(systemName: "lightbulb.fill")): Tap on any result to copy it to your clipboard.")
                    .multilineTextAlignment(.center)
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
