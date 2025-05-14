import Foundation
import IOKit.pwr_mgt

class SleepManager: ObservableObject {
    @Published var isPreventingSleep: Bool = false {
        didSet {
            if isPreventingSleep {
                preventSleep()
            } else {
                allowSleep()
            }
        }
    }
    
    private var assertionID: IOPMAssertionID = 0
    
    private func preventSleep() {
        var assertionID: IOPMAssertionID = 0
        let success = IOPMAssertionCreateWithName(
            kIOPMAssertionTypeNoDisplaySleep as CFString,
            IOPMAssertionLevel(kIOPMAssertionLevelOn),
            "Dorange Prevent Sleep" as CFString,
            &assertionID)
        
        if success == kIOReturnSuccess {
            self.assertionID = assertionID
            StatusLogManager.shared.addLog(message: "系统休眠已禁用", moduleType: .sleep)
        } else {
            StatusLogManager.shared.addLog(message: "系统休眠禁用失败", moduleType: .sleep)
        }
    }
    
    private func allowSleep() {
        if assertionID != 0 {
            let result = IOPMAssertionRelease(assertionID)
            if result == kIOReturnSuccess {
                StatusLogManager.shared.addLog(message: "系统休眠已启用", moduleType: .sleep)
            } else {
                StatusLogManager.shared.addLog(message: "系统休眠启用失败", moduleType: .sleep)
            }
            assertionID = 0
        }
    }
    
    deinit {
        allowSleep()
    }
}


