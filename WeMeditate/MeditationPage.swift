import SwiftUI
import AVFoundation

struct MeditationPage: View {
    var meditationType: String
    var time: Int
    var track: String
    
    @State private var remainingTime: Int
    @State private var isPlaying: Bool = false
    @StateObject private var audioManager = AudioPlayerManager()
    @State private var isFinished: Bool = false
    @State private var exitButtonColor: Color = Color.gray.opacity(0.6)
    @State private var isExitEnabled: Bool = false
    @State private var navigateToExit = false // Navigation state for ExitView
    @State private var timer: Timer? // Timer reference
    
    init(meditationType: String, time: Int, track: String) {
        self.meditationType = meditationType
        self.time = time
        self.track = track
        _remainingTime = State(initialValue: time * 60)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Background image
                Image("puremusic")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .offset(x: -30)

                VStack {
                    // Title
                    Text(meditationType)
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 100)
                    
                    // Music track title
                    Text(track)
                        .font(.system(size: 24, weight: .bold))
                        .padding(.top, 20)
                    
                    // Countdown timer
                    Text("\(formattedTime)")
                        .font(.system(size: 48, weight: .bold))
                        .padding(.top, 50)

                    // Dynamic pulse effect
                    pulseEffect

                    Spacer()
                    
                    // App icon
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.top, -200)
                      
                    // Exit button
                    Button(action: {
                        if isExitEnabled {
                            navigateToExit = true
                        }
                    }) {
                        Text("Exit (Valid After Finishing)")
                            .font(.system(size: 18, weight: .bold))
                            .padding()
                            .background(exitButtonColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(!isExitEnabled) // Disable the button until meditation finishes
                    
                    // Navigation link to ExitView
                    NavigationLink(destination: ExitView().navigationBarBackButtonHidden(true), isActive: $navigateToExit) {
                        EmptyView()
                    }
                }
                .onAppear {
                    audioManager.toggleTrack(track)
                    startTimer()
                }
                .onDisappear {
                    audioManager.stopTrack()
                    stopTimer() // Stop the timer to avoid multiple triggers
                }
                .navigationBarBackButtonHidden(true) // Hide back button
                .toolbar {
                    // Ensure no other navigation buttons
                    ToolbarItem(placement: .navigationBarLeading) {
                        EmptyView()
                    }
                }
            }
        }
    }

    // Start the timer logic
    private func startTimer() {
        stopTimer() // Ensure the old timer is cleared
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer.invalidate()
                isFinished = true
                isExitEnabled = true
                exitButtonColor = Color.red // Change exit button color
                audioManager.stopTrack()
            }
        }
    }
    
    // Stop the timer
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    // Format time as MM:SS
    private var formattedTime: String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // Dynamic pulse effect
    private var pulseEffect: some View {
        Circle()
            .fill(Color.green.opacity(0.6))
            .frame(width: isPlaying ? 120 : 100, height: isPlaying ? 120 : 100)
            .animation(remainingTime > 0 ? .easeInOut(duration: 1).repeatForever(autoreverses: true) : .default, value: isPlaying)
            .onAppear {
                isPlaying = true
            }
            .onChange(of: remainingTime) { newValue in
                if newValue == 0 {
                    isPlaying = false
                }
            }
    }
}

#Preview {
    MeditationPage(meditationType: "Pure Music Meditation", time: 1, track: "Moonlight")
}

