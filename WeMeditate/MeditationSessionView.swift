//
//  MeditationSessionView.swift
//  WeMeditate
//
//  Created by 小椰 on 23/1/2025.
//

import Foundation
import SwiftUI

struct MeditationSessionView: View {
    let time: Int
    let type: String
    @State private var remainingTime: Int
    @State private var timer: Timer? = nil
    @State private var isMeditationFinished: Bool = false
    @Environment(\.presentationMode) var presentationMode

    init(time: Int, type: String) {
        self.time = time
        self.type = type
        self._remainingTime = State(initialValue: time * 60) // 转换为秒
    }

    var body: some View {
        VStack {
            Text("冥想中: \(type)")
                .font(.largeTitle)
            Text("剩余时间: \(remainingTime / 60) 分 \(remainingTime % 60) 秒")
                .font(.headline)

            Button("提前结束") {
                stopMeditation()
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)

            if isMeditationFinished {
                Text("您已完成 Meditation Journey，祝您拥有美好的一天！")
                    .font(.headline)
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startMeditation()
        }
    }

    func startMeditation() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                stopMeditation()
                isMeditationFinished = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }

    func stopMeditation() {
        timer?.invalidate()
        timer = nil
    }
}
