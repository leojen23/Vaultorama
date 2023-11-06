//
//  Home.swift
//  Vaultorama
//
//  Created by Olivier Guillemot on 30/10/2023.
//

import SwiftUI
import SwiftData


struct Home: View {
    
    @AppStorage("rootDirURL") private var rootDirURL: URL?
    @Environment(\.modelContext) private var modelContext
    @Query(animation: .snappy) private var vaults: [Vault]
    
    @State private var vaultId: Vault.ID?
    @State private var showingAlert = false
    @State private var name = ""

    var body: some View {
        
        NavigationSplitView() {
            
            HStack(alignment: .top) {
                Spacer()
                Button {
                    synchroniseVaults()
                } label : {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }.buttonStyle(.borderless)
                
            }
            .padding()

            List (vaults, selection: $vaultId) { vault in
                HStack {
                    VaultListItemView(vault: vault)
                }
        
            }
            Spacer()
            
            Button("Add Vault item") {
                showingAlert.toggle()
                    }
                    .alert("Create new Vault", isPresented: $showingAlert, actions: {
                        TextField("Vault Name", text: $name, prompt: Text("This field is required"))
                        Button("Create", action: {
                            addVault(name)
                        }
                        ).disabled(name.isEmpty)
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Please give your vault a name.")
                    })
                
            Spacer()
        
            Button(action: {
                deleteAllVault(modelContext: modelContext)
            }, label: {
                Text("delete All")
            })
            Button(action: {
                rootDirURL = nil
            }, label: {
                Text("restore root dir")
            })
            .navigationSplitViewColumnWidth(
                            min: 250, ideal: 220, max: 400)
        } detail: {
//            if let vaultId = vaultId {
//                Text("\(vaultId)")
//            } else {
//                Text("no id")
//            }
        }
        .navigationTitle("VAULT")
        
    }
    
     func deleteAllVault(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Vault.self)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addVault(_ name: String) {
        LocalFileManager.instance.createDirectory(name)
        let dirURL: URL = LocalFileManager.instance.getDirectory(name)
//        let attr = LocalFileManager.instance.getDirectoryAttributes(dirURL)
        let newVault: Vault = Vault(name: name, url: dirURL)
        modelContext.insert(newVault)
    }
    
    func synchroniseVaults() {
        let dirs: [URL] = LocalFileManager.instance.getAllDirectories()
        if dirs.isEmpty {
            return
        }
        deleteAllVault(modelContext: modelContext)
        for dir in dirs {
//            let attr = LocalFileManager.instance.getDirectoryAttributes(dir)
            let vault: Vault = Vault( name: dir.lastPathComponent.lowercased(), url: dir)
            modelContext.insert(vault)
        }
    }
    
}

#Preview {
    ContentView()
}

