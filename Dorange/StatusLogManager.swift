import Foundation

/// 状态记录项模型
struct StatusLogItem: Identifiable {
    let id = UUID()
    let message: String
    let timestamp: Date
    let moduleType: ModuleType
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: timestamp)
    }
}

/// 功能模块类型枚举
enum ModuleType {
    case sleep
    case other // 未来可以添加更多模块类型
}

/// 状态记录管理器
class StatusLogManager: ObservableObject {
    /// 状态历史记录
    @Published private(set) var statusLogs: [StatusLogItem] = []
    
    static let shared = StatusLogManager()
    
    private init() {}
    
    /// 添加状态记录
    func addLog(message: String, moduleType: ModuleType) {
        let newLog = StatusLogItem(message: message, timestamp: Date(), moduleType: moduleType)
        DispatchQueue.main.async {
            self.statusLogs.append(newLog)
            // 保持最近9条记录
            if self.statusLogs.count > 9 {
                self.statusLogs.removeFirst(self.statusLogs.count - 9)
            }
        }
    }
    
    /// 清空状态记录
    func clearLogs() {
        statusLogs.removeAll()
    }
}