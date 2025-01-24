<<<<<<< HEAD

=======
>>>>>>> Video-Interface-Features
//
//  ExitView.swift
//  WeMeditate
//
//  Created by 小椰 on 24/1/2025.
//

import Foundation
<<<<<<< HEAD
import SwiftUI

struct ExitView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // 背景图片
                Image("finishpage")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.8) // 设置透明度为 50%
                    .edgesIgnoringSafeArea(.all) // 背景填满整个屏幕
                    .offset(x: -30)
                
                VStack {
                    // 添加中心顶部的icon
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100) // 调整icon的大小
                        .padding(.top, 60) // 顶部间距
                    
                    Spacer().frame(height: 20) // icon和标题之间的间距

                    // Congratulations message
                    Text("Congratulations!")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    
                    // Move this text upward
                    Text("You have completed the practice")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                        .padding(.top, 0) // 减少顶部间距
                        .padding(.bottom, 10) // 增加与按钮的间距

                    Spacer() // 增加空白间距
                    
                    // Buttons
                    VStack(spacing: 20) {
                        // Exit Now button
                
                        
                        // Back to Homepage button
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
                    .padding(.bottom, 300) // 保持底部按钮与屏幕边缘的间距
                }
            }
        }
    }
}

#Preview {
    ExitView()
}
=======
>>>>>>> Video-Interface-Features
