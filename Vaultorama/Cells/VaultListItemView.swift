
import SwiftUI
import SwiftData

struct VaultListItemView: View {
    
    var vault: Vault
    
    var body: some View {
        HStack (alignment: .top) {
            
            HStack(alignment: .top, spacing: 3 ){
               
                Label(vault.name, systemImage: "folder")
                
                Spacer()
            
                Label("0", systemImage: "photo")
                    .padding(.vertical,2)
                    .padding(.horizontal,5)
                    .background(.selection)
                    .clipShape(.capsule)
                    .font(.caption)
                
                
            }.padding(.vertical,4)
        }
    }
}
#Preview {
    ContentView()
}

