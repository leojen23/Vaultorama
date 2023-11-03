
import SwiftUI
import SwiftData

@main
struct VaultoramaApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 300, minHeight: 400)
        }
        .modelContainer(for: Vault.self)
        .windowResizability(.contentSize)
        
    }
}



#Preview {
    ContentView()
}
