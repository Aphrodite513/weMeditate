//
//  BreathworkView.swift
//  WeMeditate
//
//  Created by Riona on 2025/1/25.
//

import SwiftUI
import YouTubePlayerKit

// 主视图
struct BreathworkView: View {
    @State private var videos: [Video] = [
        Video(title: "Long Deep Breaths", duration: "5:35", previewImage: "Long Deep Breaths", category: "5-10 min", videoURL: "https://www.youtube.com/watch?v=Z8emmFOuhxE"),
        Video(title: "Breathing Exercise", duration: "6:00", previewImage: "Breathing Exercise", category: "5-10 min", videoURL: "https://www.youtube.com/watch?v=enJyOTvEn4M"),
        Video(title: "Controlled Relaxation", duration: "10:33", previewImage: "Controlled Relaxation", category: "5-10 min", videoURL: "https://www.youtube.com/watch?v=GmMUMVn7aBM"),
        Video(title: "Nitric Oxide", duration: "10:00", previewImage: "Nitric Oxide", category: "5-10 min", videoURL: "https://www.youtube.com/watch?v=EdWVTxu7npE"),
        Video(title: "Relaxation and Inner Stillness", duration: "16:58", previewImage: "Relaxation and Inner Stillness", category: "10-20 min", videoURL: "https://www.youtube.com/watch?v=4Undv6MmQeE"),
        Video(title: "Release Stuck Energy", duration: "17:05", previewImage: "Release Stuck Energy", category: "10-20 min", videoURL: "https://www.youtube.com/watch?v=O4d7u7SikyA"),
        Video(title: "Nervous System Reset", duration: "22:03", previewImage: "Nervous System Reset", category: "10-20 min", videoURL: "https://www.youtube.com/watch?v=qlTC2HBmPeM"),
        Video(title: "Active Body Scan", duration: "21:22", previewImage: "Active Body Scan", category: "10-20 min", videoURL: "https://www.youtube.com/watch?v=AeOXCgF4S0s"),
        Video(title: "Unlock Infinite Possibilities", duration: "40:40", previewImage: "Unlock Infinite Possibilities", category: "Over 20 min", videoURL: "https://www.youtube.com/watch?v=-UJX8LgGz3I"),
        Video(title: "Bone Deep Breathing", duration: "30:51", previewImage: "Bone Deep Breathing", category: "Over 20 min", videoURL: "https://www.youtube.com/watch?v=cXcmyOEZzvE")
    ]
    
    @State private var selectedCategory: String = "All"
    private let categories = ["All", "5-10 min", "10-20 min", "Over 20 min"]
    
    var body: some View {
        NavigationView {
            ZStack {
                // 自定义背景
                Image("vidBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // 设定背景图片的尺寸
                    .ignoresSafeArea()
                    .opacity(0.7)
                VStack {
                    Spacer(minLength: 90)
                    // 顶部的筛选标签
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 10) {
                            ForEach(categories, id: \.self) { category in
                                Text(category)
                                    .font(.headline)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .background(selectedCategory == category ? Color.green.opacity(0.7) : Color.gray.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .onTapGesture {
                                        selectedCategory = category
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 20)
                    // 视频列表
                    List(filteredVideos()) { video in
                        NavigationLink(
                            destination: VideoPlayerView(videoID: extractYouTubeID(from: video.videoURL) ?? "", videoDuration: convertToSeconds(duration: video.duration) ?? 0)
                        ) {
                            HStack {
                                Image(video.previewImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 70)
                                    .clipped()
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(video.title)
                                        .font(.headline)
                                    Text("Duration: \(video.duration)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                        }
                        .listRowBackground(Color.white.opacity(0.7))
                        .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                    .listStyle(PlainListStyle())
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading) // 限制宽度 + 左对齐
                    .background(Color.clear)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Image("icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50) // 设置图标大小
                            .padding(.top, 30) // 调整图标和标题之间的间距
                        Text("Choose Your Journey")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    private func filteredVideos() -> [Video] {
        if selectedCategory == "All" {
            return videos
        } else {
            return videos.filter { $0.category == selectedCategory }
        }
    }
    
    func extractYouTubeID(from url: String) -> String? {
        let pattern = #"(?:(?:https?:\/\/)?(?:www\.)?youtube\.com\/(?:watch\?v=|embed\/|v\/)|youtu\.be\/)([a-zA-Z0-9_-]{11})"#
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: url.utf16.count)
        
        if let match = regex?.firstMatch(in: url, options: [], range: range),
           let videoIDRange = Range(match.range(at: 1), in: url) {
            return String(url[videoIDRange])
        }
        return nil
    }
    
    // 将 "mm:ss" 格式的时间字符串转换为总秒数
    func convertToSeconds(duration: String) -> Int? {
        let components = duration.split(separator: ":")
        if components.count == 2,
           let minutes = Int(components[0]),
           let seconds = Int(components[1]) {
            return minutes * 60 + seconds
        }
        return nil
    }
}

#Preview {
    BreathworkView()
}
