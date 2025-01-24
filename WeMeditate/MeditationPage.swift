//
//  MeditationPage.swift
//  WeMeditate
//
//  Created by 小椰 on 23/1/2025.
//

import Foundation
<<<<<<< HEAD
import SwiftUI

struct MeditationPage: View {
    var meditationType: String
    var time: Int
    var track: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "hourglass.bottomhalf.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding()
                
                Text("\(meditationType) - \(time) minutes")
                    .font(.system(size: 24, weight: .bold))
                    .padding()
                
                Spacer()
            }
            
            // Countdown Timer
            
            // Video or Audio player
            .padding()
        }
    }
}
=======
>>>>>>> Video-Interface-Features
