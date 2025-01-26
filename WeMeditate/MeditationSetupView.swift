// MeditationSetupView.swift
// WeMeditate
//
// Created by 小椰 on 23/1/2025.
//

import SwiftUI

struct MeditationSetupView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.5)
            
            VStack {
                // Icon and title
                HStack {
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.leading, 40)
                    Spacer()
                }
                .padding(.top, 40)
                
                Text("Choose My Meditation")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 10)
                    .padding(.leading, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("A complete release")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding(.top, 0)
                    .padding(.leading, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Meditation Buttons
                VStack(spacing: 20) {
                    NavigationLink(destination: VideoPreviewListView().navigationBarBackButtonHidden(true)) {
                        MeditationButton(title: "Guided Meditation", imageName: "type1", description: "Step-by-step guidance for calmness")
                    }
                    
                    NavigationLink(destination: BreathworkView().navigationBarBackButtonHidden(true)) {
                        MeditationButton(title: "Breath Meditation", imageName: "type2", description: "Focus on breathing for inner peace")
                    }
                    
                    NavigationLink(destination: PureMusicSelectionView().navigationBarBackButtonHidden(true)) {
                        MeditationButton(title: "Pure Music Meditation", imageName: "type3", description: "Silent reflection with calming music")
                    }
                }
                .padding(.top, 10) // Shifting buttons upward slightly
                .padding(.bottom, 40) // Giving more space at the bottom
                .frame(maxHeight: .infinity, alignment: .top) // Ensures buttons stay visible
            }
        }
    }
}

struct MeditationButton: View {
    var title: String
    var imageName: String
    var description: String
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 150) // Adjusted height
                .cornerRadius(20)
            
            VStack {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 19)
                
                Text(description)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 150) // Adjusted height here as well
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MeditationSetupView()
}

