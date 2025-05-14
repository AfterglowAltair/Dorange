import SwiftUI

struct MainView: View {
    @StateObject private var sleepManager = SleepManager()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Dorange")
                .font(.title)
                .fontWeight(.bold)
            
            
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }

            Toggle(isOn: $sleepManager.isPreventingSleep) {
                Text("防止系统休眠")
            }
            .padding()
            
            if sleepManager.isPreventingSleep {
                Text("系统将保持唤醒状态")
                    .foregroundColor(.green)
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
