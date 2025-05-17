//
//  DorangeApp.swift
//  Dorange
//
//  Created by 许彭文 on 2025/5/13.
//

import SwiftUI

@main
struct DorangeApp: App {
    @StateObject private var menuBarManager = MenuBarManager()
    
    init() {
            requestAutomationPermission()
        }
    
    var body: some Scene {
        MenuBarExtra {
            MenuView()
                .environmentObject(menuBarManager)
        } label: {
            Image(systemName: "sun.max")
        }
        .menuBarExtraStyle(.window)
    }
}

class MenuBarManager: ObservableObject {
    @Published var isMenuVisible = true
    
    func dismissMenu() {
        Task { @MainActor in
            NSApp.sendAction(#selector(NSPopover.performClose(_:)), to: nil, from: nil)
        }
    }
}

// ✅ 自动化权限触发方法
func requestAutomationPermission() {
    let appleScript = """
    tell application "System Events"
        set dummy to name of every process
    end tell
    """
    
    if let script = NSAppleScript(source: appleScript) {
        var error: NSDictionary? = nil
        script.executeAndReturnError(&error)
        
        if let error = error {
            StatusLogManager.shared.addLog(message: "自动化权限获取失败", moduleType: .other)
        } else {
            StatusLogManager.shared.addLog(message: "自动化权限获取成功", moduleType: .other)
        }
    }
}
