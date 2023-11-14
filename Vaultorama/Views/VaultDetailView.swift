
import SwiftUI
import SwiftData


struct VaultDetailView: View {
    
    let vault: Vault
    
    init(vault: Vault) {
        self.vault = vault
    }
    var body: some View {
        GridView(vault: vault)
    }
}

struct GridView: View {
    
    let vault: Vault
    
    init(vault: Vault) {
        self.vault = vault
    }
    @Environment(\.modelContext) private var modelContext
    private static var initialColumns = 10
    @State private var numColumns: Double = Double(initialColumns)
    @State private var isEditing = false
    @State private var isOn: Bool = false
    @State private var isGridView: Bool = true
    @State private var isListView: Bool = false
    @State private var pickedFiles: [URL]?

    var body: some View {
        VStack {
            if !vault.images!.isEmpty{
                ScrollView {
                    if isGridView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: Int(numColumns))) {
                            ForEach(vault.files, id:\.fileName) { item in
                                GeometryReader { geo in
                                    GridItemView(size: geo.size.width, file: item)
                                }
                                .cornerRadius(6.0)
                                .scaledToFit()
                            }
                        }
                    }
                    if isListView {
                        Text("List View")
                    }
                    
                }.padding(10)
            }
            else {
                Button("Add Files", systemImage: "photo.on.rectangle") {
                    print("Add files")
                }
                .padding()
                .buttonStyle(.bordered)
                .controlSize(.large)
                .tint(Color.accentColor)
                
            }
        }
        .toolbar() {
            
            ToolbarItemGroup (placement: .navigation){
                
                Toggle(isOn: $isGridView) {
                    Image(systemName: "square.grid.2x2")
                }.onChange(of: isListView) { oldValue, newValue in
                    if newValue {
                        isGridView = false
                    }
                }
                
                Toggle(isOn: $isListView) {
                    Image(systemName: "list.bullet")
                }.onChange(of: isGridView) { oldValue, newValue in
                    if newValue {
                        isListView = false
                    }
                }
            }
           
            ToolbarItemGroup (placement: .cancellationAction){
                HStack{
                    Slider(
                            value: $numColumns,
                            in: 2...10,
                            minimumValueLabel: Text("2"),
                            maximumValueLabel: Text("10"),
                            label: {
                                Text("Values from 0 to 50")
                            }
                        )
                        .accentColor(.red)
                    Button {
                        addFiles()
                       
                    } label : {
                        Image(systemName: "folder.badge.plus")
                    }.buttonStyle(.borderless)
                }
                .frame(width: 150)
            }
        }
    }
    
    private func addFiles() {
            let openPanel = NSOpenPanel()
            openPanel.message = "Select images"
            openPanel.prompt = "Load"
            openPanel.allowedFileTypes = ["jpg", "jpeg", "png"] // Add the allowed file types
            openPanel.canChooseFiles = true
            openPanel.canChooseDirectories = false
            openPanel.allowsMultipleSelection = true
            openPanel.begin { response in
                if response == .OK, !openPanel.urls.isEmpty {
                   self.pickedFiles = openPanel.urls
                    LocalFileManager.instance.addFilesToVault(self.pickedFiles!, vault)
                    vault.images = self.pickedFiles
               }
           }
       }
}



#Preview {
    ContentView()
}
