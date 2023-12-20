

import SwiftUI
import SwiftData


struct Home: View {
    
    @AppStorage("rootDirURL") private var rootDirURL: URL?
    @Environment(\.modelContext) private var modelContext
    @Query(animation: .snappy) private var vaults: [Vault]
    
//    @State private var vaultId: Vault.ID?
    @State private var selectedVault: Vault?
    @State private var showingAddAlert = false
    @State private var deletedVault: Vault? = nil
    @State private var name = ""

    var body: some View {
        
        NavigationSplitView() {
            
            HStack(alignment: .top) {
               
                Spacer()
                
                Button {
                    showingAddAlert.toggle()
                } label : {
                    Image(systemName: "plus")
                }.buttonStyle(.borderless)
                    .alert("Create new Vault", isPresented: $showingAddAlert, actions: {
                        TextField("Vault Name", text: $name, prompt: Text("This field is required"))
                        Button("Create", action: {
                            addVault(name)
                        }
                        ).disabled(name.isEmpty)
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Please give your vault a name.")
                    })
              
                Button {
                    synchroniseVaults()
                } label : {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
                .buttonStyle(.borderless)
            }
            .padding()

            
            List (vaults, id:\.self, selection: $selectedVault) { vault in
                HStack {
                    VaultListItemView(vault: vault)
                }
                .contextMenu {
                    Button {
                        deleteVault(vault: vault)
                    } label : {
                       Text("Delete")
                    }
                }
                
            }
            .navigationTitle("List")
            
            
            Spacer()
        
//            Button(action: {
//                rootDirURL = nil
//            }, label: {
//                HStack {
//                    Image(systemName: "plus.circle")
//                    Text("restore root dir")
//                    Spacer()
//                }.padding()
//            })
            Button(action: {
                showingAddAlert.toggle()
            }, label: {
                HStack {
                    Image(systemName: "plus.circle")
                    Text("Add Vault")
                    Spacer()
                }.padding()
            })
            .buttonStyle(.borderless)
            .alert("Create new Vault", isPresented: $showingAddAlert, actions: {
                TextField("Vault Name", text: $name, prompt: Text("This field is required"))
                Button("Create", action: {
                    addVault(name)
                }
                ).disabled(name.isEmpty)
                Button("Cancel", role: .cancel, action: {})
            }, message: {
                Text("Please give your vault a name.")
            })
            .navigationSplitViewColumnWidth(
                            min: 250, ideal: 220, max: 400)
            
            Spacer()
        } detail: {

            if let selectedVault = selectedVault  {
                VaultDetailView(vault: selectedVault)
            } else{
                Text("no Vault")
            }
        }
        .navigationTitle(selectedVault?.name ?? "No vault selected")
        .onAppear {
            synchroniseVaults()
        }
        
    }
    
    private func deleteVault(vault: Vault) {
        LocalFileManager.instance.deleteDirectory(vault.url)
        deletedVault = vault
        if let selection = self.deletedVault {
            print(selection.name)
            modelContext.delete(selection)
        } else {
            return
        }
    }
    
    
     private func deleteAllVault(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Vault.self)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func addVault(_ name: String) {
        LocalFileManager.instance.createDirectory(name)
        let dirURL: URL = LocalFileManager.instance.getDirectory(name)
        let newVault: Vault = Vault(url: dirURL)
        modelContext.insert(newVault)
    }
    
    private func synchroniseVaults() {
        let dirs: [URL] = LocalFileManager.instance.getAllDirectories()
        if dirs.isEmpty {
            return
        }
        deleteAllVault(modelContext: modelContext)
        for dirURL in dirs {
            let vault: Vault = Vault(url: dirURL)
            modelContext.insert(vault)
        }
    }
}

#Preview {
    ContentView()
}

