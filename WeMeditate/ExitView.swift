import Foundation
import SwiftUI

struct ExitView: View {
    @State private var stars: Int = 0
    @State private var badges: Int = 0
    @State private var earnedDiscount: Bool = false
    @State private var rewardClaimed: Bool = false // New state to track if the reward is claimed

    var body: some View {
        NavigationView {
            ZStack {
                // Background image
                Image("finishpage")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                    .offset(x: -30)

                VStack {
                    // Icon
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 190, height: 100)
                        .padding(.top, 120)

                    Spacer().frame(height: 20)

                    // Reward Box
                    ZStack {
                        VStack(spacing: 15) {
                            Text("Congratulations!")
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)

                            Text("You have completed the practice")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)

                            Text("Your Progress")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.top, 10)

                            Text("Stars: \(stars)/10")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)

                            Text("Badges: \(badges)/5")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)

                            if earnedDiscount {
                                Text("You've earned 10% off from the bookstore! 🎉")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.green)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 10)
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal, 20)

                    Spacer()

                    // Claim Button
                    VStack(spacing: 20) {
                        Button(action: {
                            claimReward()
                        }) {
                            Text(rewardClaimed ? "Reward Claimed" : "Claim Your Reward")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 50)
                                .background(rewardClaimed ? Color.gray : Color.blue) // Disable style
                                .cornerRadius(30)
                        }
                        .disabled(rewardClaimed) // Disable button if reward is already claimed

                        // NavigationLink to WelcomeView without back button
                        NavigationLink(destination: WelcomeView().navigationBarBackButtonHidden(true)) {
                            Text("Back to Homepage")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 50)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(30)
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    private func claimReward() {
        guard !rewardClaimed else { return }
        stars += 1
        if stars == 10 {
            badges += 1
            stars = 0
        }
        if badges == 5 {
            earnedDiscount = true
        }
        rewardClaimed = true // Mark reward as claimed
    }
}

#Preview {
    ExitView()
}
