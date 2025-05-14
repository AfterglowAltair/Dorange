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
