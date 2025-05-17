import SwiftUI

struct StatusHistoryView: View {
    @StateObject private var statusManager = StatusLogManager.shared
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("状态历史")
                .font(.system(size: 12))
                .foregroundColor(colorScheme == .dark ? .gray : .black)//.gray
                .padding(.horizontal)
                .padding(.bottom, 4)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(statusManager.statusLogs) { log in
                        HStack(spacing: 6) {
                            Text(log.formattedTime)
                                .font(.system(size: 10))
                                .foregroundColor(colorScheme == .dark ? .gray : .gray)
                            Text(log.message)
                                .font(.system(size: 12))
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        .padding(.vertical, 2)
                        .padding(.leading, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 180) // 将高度从100增加到180，以容纳9行信息
            .frame(maxWidth: .infinity)
            .background(colorScheme == .dark ? Color.black : Color.gray.opacity(0.1))
        }
        .padding(.vertical, 8)
    }
}
