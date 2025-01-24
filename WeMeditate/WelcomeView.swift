//
//  WelcomeView.swift
//  WeMeditate
//
//  Created by 小椰 on 23/1/2025.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // background
                Image("background")                  .resizable()
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .offset(x: -30)
                    
                //
                VStack {
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.top, -200)
                      

                    Text("Welcome")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.black
                        )
                        .frame(maxWidth: UIScreen.main.bounds.width * 1)
                        .multilineTextAlignment(.center)
                        .padding(.top, -50)
                    
                    Text("To WeMeditate")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                        .multilineTextAlignment(.center)
                        .padding(.top, 0)
                    
                    NavigationLink(destination: MeditationSetupView()) {
                        Text("Start My Journey")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 36)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(30)
                    }
                    
                    .padding(.top, 20)
                }
            }
        }
    }
}


#Preview {
    WelcomeView()
}
