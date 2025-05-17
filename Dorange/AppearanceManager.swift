import SwiftUI

class AppearanceManager: ObservableObject {
    @Published var isCustomAppearance: Bool = false
    
    func toggleAppearance() {
        isCustomAppearance.toggle()
        
        let script = """
        tell application "System Events"
            tell appearance preferences
                set currentMode to dark mode
                if currentMode is true then
                    set dark mode to false
                else
                    set dark mode to true
                end if
            end tell
        end tell
        """
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: script) {
            let output = scriptObject.executeAndReturnError(&error)
            
            if error == nil {
                // 获取当前模式并记录日志
                let getCurrentModeScript = """
                tell application "System Events"
                    tell appearance preferences
                        return dark mode
                    end tell
                end tell
                """
                
                if let modeScriptObject = NSAppleScript(source: getCurrentModeScript) {
                    let modeOutput = modeScriptObject.executeAndReturnError(&error)
                    let isDarkMode = modeOutput.booleanValue
                    
                    if isDarkMode {
                        StatusLogManager.shared.addLog(message: "已切换系统到深色模式", moduleType: .appearance)
                    } else {
                        StatusLogManager.shared.addLog(message: "已切换系统到浅色模式", moduleType: .appearance)
                    }
                }
            } else {
                StatusLogManager.shared.addLog(message: "切换系统外观失败", moduleType: .appearance)
                isCustomAppearance = false
            }
        }
    }
}