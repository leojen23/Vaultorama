
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
   
    private static var initialColumns = 10
    @State private var numColumns: Double = Double(initialColumns)
    @State private var isEditing = false
    @State private var isOn: Bool = false
    @State private var isGridView: Bool = true
    @State private var isListView: Bool = false

    var body: some View {
        VStack {
            if !vault.files.isEmpty{
                ScrollView {
                    if isGridView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: Int(numColumns))) {
                            ForEach(vault.files, id:\.fileName) { item in
                                GeometryReader { geo in
                                    GridItemView(size: geo.size.width, file: item )
                                }
                                .cornerRadius(8.0)
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(alignment: .topTrailing) {
                                    if isEditing {
                                        Button {
                                            withAnimation {
        //                                     dataModel.removeItem(item)
                                            }
                                        } label: {
                                            Image(systemName: "xmark.square.fill")
                                                        .font(Font.title)
                                                        .symbolRenderingMode(.palette)
                                                        .foregroundStyle(.white, .red)
                                        }
                                        .offset(x: 7, y: -7)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    if isListView {
                        Text("List View")
                    }
                    
                }
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
                }
                .frame(width: 150)
            }
        }
    }
}

#Preview {
    ContentView()
}
