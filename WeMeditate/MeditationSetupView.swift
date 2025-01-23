//
//  MeditationSetupView.swift
//  WeMeditate
//
//  Created by 小椰 on 23/1/2025.
//

import Foundation
import SwiftUI

struct MeditationSetupView: View {
    @State private var selectedTime: Double = 20 // 默认 20 分钟
    @State private var selectedType: String = "纯音乐" // 默认纯音乐
    let meditationTypes = ["纯音乐", "引导冥想", "呼吸冥想"]

    var body: some View {
        VStack {
            Spacer()
            Text("设置冥想")
                .font(.largeTitle)

            Text("选择时间（分钟）")
            Slider(value: $selectedTime, in: 0...60, step: 1)
            Text("时间: \(Int(selectedTime)) 分钟")

            Text("选择冥想类型")
                .font(.largeTitle)
            Picker("冥想类型", selection: $selectedType) {
                ForEach(meditationTypes, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Spacer()

            NavigationLink(destination: MeditationSessionView(time: Int(selectedTime), type: selectedType)) {
                Text("确定")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("冥想设置")
    }
}
