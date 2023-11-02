import SwiftUI
import SwiftData

struct ContentView: View {
    
    @AppStorage("rootDirectory") private var rootDirectory: String?
    
    var body: some View {
        if rootDirectory != nil{
            Home()
        } else {
            AppLaunchView()
        }
    }
}
#Preview {
    ContentView()
}
