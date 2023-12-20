
import SwiftUI

struct AppLaunchView: View {
    
    
    var body: some View {
        ZStack () {
            Image("vaultorama-bg")
                .resizable()
                .scaledToFill()
                .overlay(LinearGradient(gradient: Gradient(colors: [.clear, .black]),
                                       startPoint: .top,
                                       endPoint: .bottom)
            )
            VStack(alignment: .trailing) {
                Spacer()
                Text("Vaultorama")
                    .font(.system(size: 70))
                Text("Keep your data safe !")
                    .font(.title)
                Spacer()
                Button("Let's start !") {
                    LocalFileManager.instance.setRootDirectory()
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .frame(maxWidth: 350, maxHeight: 400)
            .padding(.horizontal, 100)
            .background(.opacity(0.1))
            .cornerRadius(10)
        }
    }
}
    
#Preview {
    ContentView()
}
