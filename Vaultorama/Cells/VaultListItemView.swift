
import SwiftUI
import SwiftData

struct VaultListItemView: View {
    
    var vault: Vault
    
    @State private var openMenu: Bool = false
    
    var body: some View {
        
        HStack (alignment: .top) {
            
            HStack(alignment: .top, spacing: 3 ){
               
                Label(vault.name, systemImage: "folder")
                
                Spacer()
                
                Label("\(vault.count)", systemImage: "photo")
                    .padding(.vertical,2)
                    .padding(.horizontal,5)
                    .background(.selection)
                    .clipShape(.capsule)
                    .font(.caption)
                
                Label(vault.size, systemImage: "simcard")
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

