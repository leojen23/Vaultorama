import SwiftUI
import SwiftData

struct ContentView: View {
    
    @AppStorage("rootDirURL") private var rootDirURL: URL?
    
    var body: some View {
        if rootDirURL != nil{
            Home()
        } else {
            AppLaunchView()
        }
    }
}
#Preview {
    ContentView()
}
