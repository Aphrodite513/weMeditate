<<<<<<< HEAD
import Foundation
import SwiftUI
import AVFoundation

// Create a class to manage the audio player
class AudioPlayerManager: ObservableObject {
    @Published var playingTrack: String? = nil
    private var audioPlayer: AVAudioPlayer?

    func toggleTrack(_ track: String) {
        if playingTrack == track {
            // Stop the music
            audioPlayer?.stop()
            playingTrack = nil
        } else {
            // Find the audio file path
            guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
                print("Audio file not found: \(track)")
                return
            }
            
            do {
                // Stop the previous track if it's playing
                audioPlayer?.stop()

                // Initialize and play the new track
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
                playingTrack = track
            } catch {
                print("Failed to play audio: \(error)")
            }
        }
    }
}

// Main view
struct PureMusicSelectionView: View {
    @StateObject private var audioManager = AudioPlayerManager()
    @State private var selectedTime: Int = 0
    @State private var selectedTrack: String? = nil // Selected track for visual feedback

    let tracks = [
        "Moonlight",
        "SpringBreeze",
        "CalmSoul",
        "BodyRelaxation",
        "Nature",
        "DeepHealing",
        "EnergyVibration",
        "HealingStress",
        "QuietContemplation",
        "ZenCascade"
    ]
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .offset(x: -30)
            
            VStack(spacing: 15) {
                header
                timeSelection
                previewMusicTitle
                musicList
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        }
    }

    // MARK: - Header
    private var header: some View {
        VStack(spacing: 15) {
            HStack {
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 5)
                Spacer()
            }
            .padding(.top, 30)

            Text("Pure Music Meditation")
                .font(.system(size: 30, weight: .bold))
        }
    }
    
    // MARK: - Time Selection Picker
    private var timeSelection: some View {
        VStack(spacing: 10) {
            Text("Choose Time")
                .font(.system(size: 24, weight: .bold))
            
            Picker("Select Time", selection: $selectedTime) {
                ForEach(0..<61, id: \.self) { time in
                    Text("\(time) minutes").tag(time)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 80)
            .clipped()
        }
    }
    
    // MARK: - Preview Music Title
    private var previewMusicTitle: some View {
        Text("Preview Music")
            .font(.system(size: 24, weight: .bold))
            .padding(.top, 0)
    }
    
    // MARK: - Music List
    private var musicList: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(tracks, id: \.self) { track in
                    HStack {
                        Text(track)
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Play/Stop Button
                        Button(action: {
                            audioManager.toggleTrack(track)
                        }) {
                            Text(audioManager.playingTrack == track ? "Stop" : "Play")
                                .font(.system(size: 14, weight: .bold))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(
                                    audioManager.playingTrack == track ? Color.red.opacity(0.8) : Color.blue.opacity(0.8)
                                )
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                        
                        // Start Button
                        NavigationLink(destination: MeditationPage(meditationType: "Pure Music", time: selectedTime, track: track)) {
                            Text("Start")
                                .font(.system(size: 14, weight: .bold))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        selectedTrack == track ? Color.green.opacity(0.2) : Color.clear
                    )
                    .cornerRadius(8)
                }
            }
        }
    }
}
#Preview {
    PureMusicSelectionView()
}
=======
//
//  PureMusicSelectionView.swift
//  WeMeditate
//
//  Created by 小椰 on 23/1/2025.
//

import Foundation
>>>>>>> Video-Interface-Features
