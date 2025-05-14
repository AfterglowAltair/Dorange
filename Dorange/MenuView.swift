import SwiftUI


// 自定义按钮样式

struct MenuButtonStyle: ButtonStyle {
    @State private var isHovered = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                configuration.isPressed ? Color.orange.opacity(0.5) :
                    (isHovered ? Color.orange.opacity(0.2) : Color.clear)
            )
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .contentShape(Rectangle())
            .onHover { hovering in
                isHovered = hovering
            }
    }
}

struct MenuView: View {
    @StateObject private var sleepManager = SleepManager()
    @StateObject private var statusManager = StatusLogManager.shared
    @EnvironmentObject private var menuBarManager: MenuBarManager
    
    var body: some View {
        VStack(spacing: 0) {
            // 功能模块列表部分
            VStack(alignment: .leading, spacing: 8) {
                Text("功能模块")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                Button(action: {
                    sleepManager.isPreventingSleep.toggle()
                }) {
                    HStack {
                        Image(systemName: "sun.max")
                        Text("防止系统休眠")
                        Spacer()
                        if sleepManager.isPreventingSleep {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                }
                .buttonStyle(MenuButtonStyle())
                
                Divider()
                    .padding(.vertical, 8)
            }
            
            // 使用独立的状态历史记录视图
            StatusHistoryView()
            
            Divider()
            
            // 退出按钮
            Button(action: {
                statusManager.clearLogs()
                NSApplication.shared.terminate(nil)
            }) {
                Text("退出")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .buttonStyle(MenuButtonStyle())
            .padding(.vertical, 4)
        }
        .frame(width: 250)
    }
}

extension ButtonStyleConfiguration {
    struct Trigger {
        var isHovered: Bool = false
    }
    
    var trigger: Trigger {
        return Trigger()
    }
}
