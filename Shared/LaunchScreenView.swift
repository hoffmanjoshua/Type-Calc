//
//  LaunchScreenView.swift
//  Type-Calc
//
//  Created by Joshua Hoffman on 9/27/20.
//

import SwiftUI

struct LaunchScreenView: View {
    
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
