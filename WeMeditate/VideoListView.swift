import SwiftUI
import YouTubePlayerKit

// 视频模型
struct Video: Identifiable {
    let id = UUID()
    let title: String
    let duration: String
    let previewImage: String // 预览图片
    let category: String     // 视频分类
    let videoURL: String     // 视频链接
}

// 主视图
struct VideoPreviewListView: View {
    @State private var videos: [Video] = [
        Video(title: "Reset Your Day", duration: "5:17", previewImage: "Reset Your Day", category: "5-10 min", videoURL: "https://www.youtube.com/watch?v=inpok4MKVLM"),
        Video(title: "Re-Center & Clear Your Mind", duration: "6:01", previewImage: "Re-Center & Clear Your Mind", category: "5-10 min", videoURL: "https://www.youtube.com/watch?v=ssss7V1_eyA"),
        Video(title: "Be Present", duration: "10:30", previewImage: "Be Present", category: "5-10 min", videoURL: "https://www.youtube.com/watch?v=ZToicYcHIOU"),
        Video(title: "Mindfulness Meditation", duration: "10:24", previewImage: "Mindfulness Meditation", category: "5-10 min", videoURL: "https://www.youtube.com/watch?v=lNpuUk55kuI"),
        Video(title: "Energy Cleanse", duration: "15:16", previewImage: "Energy Cleanse", category: "10-20 min", videoURL: "https://www.youtube.com/watch?v=zdFWA4dp3zk"),
        Video(title: "Surrender To The Flow", duration: "14:52", previewImage: "Surrender To The Flow", category: "10-20 min", videoURL: "https://www.youtube.com/watch?v=JR02fcXyLQY"),
        Video(title: "Inner Wisdom & Compassion", duration: "20:05", previewImage: "Inner Wisdom & Compassion", category: "10-20 min", videoURL: "https://https://www.youtube.com/watch?v=TPC_36ZHOjo"),
        Video(title: "Feel Power Presence", duration: "21:05", previewImage: "Feel Power Presence", category: "10-20 min", videoURL: "https://www.youtube.com/watch?v=zYpvOotEbhQ"),
        Video(title: "Powerful Release", duration: "28:03", previewImage: "Powerful Release", category: "Over 20 min", videoURL: "https://www.youtube.com/watch?v=2DXqMBXmP8Q"),
        Video(title: "Grounding Energy", duration: "30:45", previewImage: "Grounding Energy", category: "Over 20 min", videoURL: "https://www.youtube.com/watch?v=_toq43rAAlI")
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

// 视频播放视图
struct VideoPlayerView: View {
    let videoID: String // YouTube 视频的 ID
    let videoDuration: Int

    @State private var isFinished = false
    @State private var player = YouTubePlayer(
            source: .video(id: ""),
            configuration: .init(
                autoPlay: true, // 自动播放
                showControls: false, // 显示控制条
                showFullscreenButton: false // 显示全屏按钮
            )
        )

    var body: some View {
        ZStack {
            // 自定义背景
            Image("vidBackground")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // 设定背景图片的尺寸
                .ignoresSafeArea()
                .opacity(0.7)
            
            YouTubePlayerView(player) // 播放器视图
                .cornerRadius(20) // 设置圆角
                .aspectRatio(16/9, contentMode: .fit) // 确保播放器按照 16:9 比例显示
                .background(Color.clear) // 设置播放器背景
                .onAppear {
                    player.load(source: .video(id: videoID)) // 加载指定视频
                }
                .navigationBarBackButtonHidden(true) // 隐藏返回按钮
            // 居中的图标
            HStack {
                Spacer()
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(.top, 500) // 底部间距
                Spacer()
            }

            // 禁用用户交互透明层
            Rectangle()
                .foregroundColor(Color.black.opacity(0.001)) // 不可见但捕获点击
                .allowsHitTesting(true)

            // 视频播放结束后跳转到 ExitView
            if isFinished {
                NavigationLink(destination: ExitView()) {
                    EmptyView()
                }
            }
        }
        .onAppear {
            // 禁止锁屏
            UIApplication.shared.isIdleTimerDisabled = true
            
            // 视频播放完成后跳转
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(videoDuration)) {
                isFinished = true
            }
        }
        .onDisappear {
            // 恢复锁屏
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

// 主入口
struct ContentView: View {
    var body: some View {
        VideoPreviewListView()
    }
}

#Preview {
    ContentView()
}
