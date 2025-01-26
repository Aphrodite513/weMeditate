import Foundation
import SwiftUI
import AVFoundation

// AudioPlayerManager: Manages the playback of audio tracks
class AudioPlayerManager: ObservableObject {
    @Published var playingTrack: String? = nil // The currently playing track
    private var audioPlayer: AVAudioPlayer? // AVAudioPlayer instance to handle audio playback

    // Toggle playback of a track: either play or stop the track
    func toggleTrack(_ track: String) {
        if playingTrack == track {
            audioPlayer?.stop() // Stop the audio if it's already playing
            playingTrack = nil // Reset the current track
        } else {
            // Locate the audio file in the app bundle
            guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
                print("Not find file: \(track)") // Handle missing file
                return
            }
            
            do {
                audioPlayer?.stop() // Stop any currently playing audio
                audioPlayer = try AVAudioPlayer(contentsOf: url) // Initialize a new audio player
                audioPlayer?.play() // Start playing the track
                playingTrack = track // Set the currently playing track
            } catch {
                print("Failure of playing music: \(error)") // Handle playback error
            }
        }
    }

    // Stop the current track
    func stopTrack() {
        audioPlayer?.stop()
        playingTrack = nil
    }
}

// PureMusicSelectionView: The main view for selecting pure music meditation
struct PureMusicSelectionView: View {
    @StateObject private var audioManager = AudioPlayerManager() // Manage audio playback
    @State private var selectedTime: Int = 5 // The selected meditation time, default is 5 minutes
    @State private var selectedTrack: String? = nil // The selected music track
    @State private var navigationPath = NavigationPath() // Navigation state

    // List of music tracks available for preview
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
        NavigationStack {
            ZStack {
                Image("background") // Background image
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .offset(x: -30)
                
                VStack(spacing: 0) {
                    header // Header view
                    timeSelection // Time selection picker
                    previewMusicTitle // Title for the music preview section
                    musicList // List of music tracks
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }

    // MARK: - Header
    private var header: some View {
        VStack(spacing: 0) {
            HStack {
                Image("icon") // App icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 170)
                Spacer()
            }
            .padding(.top, 100)

            Text("Pure Music Meditation") // Title for the meditation view
                .font(.system(size: 30, weight: .bold))
        }
    }
    
    // MARK: - Time Selection Picker
    private var timeSelection: some View {
        VStack(spacing: 10) {
            Text("Choose Time") // Label for time selection
                .font(.system(size: 24, weight: .bold))
            
            Picker("Select Time", selection: $selectedTime) {
                ForEach(1..<61, id: \.self) { time in
                    Text("\(time) minutes").tag(time) // Display time options from 1 to 60 minutes
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 80)
            .clipped()
        }
    }
    
    // MARK: - Preview Music Title
    private var previewMusicTitle: some View {
        Text("Preview Music") // Title for music preview section
            .font(.system(size: 24, weight: .bold))
            .padding(.top, 0)
    }
    
    // MARK: - Music List
    private var musicList: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(tracks, id: \.self) { track in
                    HStack {
                        Text(track) // Display track name
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button(action: {
                            audioManager.toggleTrack(track) // Toggle track playback
                        }) {
                            Text(audioManager.playingTrack == track ? "Stop" : "Play") // Play/Stop button
                                .font(.system(size: 14, weight: .bold))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(
                                    audioManager.playingTrack == track ? Color.red.opacity(0.8) : Color.blue.opacity(0.8)
                                )
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                        
                        // Navigation to meditation page with selected track and time
                        NavigationLink(destination: MeditationPage(meditationType: "Pure Music", time: selectedTime, track: track)
                            .navigationBarBackButtonHidden(true),
                                       label: {
                            Text("Start") // Button to start the meditation session
                                .font(.system(size: 14, weight: .bold))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        })
                        .simultaneousGesture(TapGesture().onEnded {
                            navigationPath = NavigationPath() // Reset navigation path
                        })}
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
    PureMusicSelectionView() // Preview of the music selection view
}



