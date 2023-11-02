//
//  Home.swift
//  Vaultorama
//
//  Created by Olivier Guillemot on 30/10/2023.
//

import SwiftUI
import SwiftData


struct Home: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(animation: .snappy) private var vaults: [Vault]
    @State private var vaultId: Vault.ID?
    @State private var showingAlert = false
    @State private var name = ""
    @AppStorage("rootDirectory") private var rootDirectory: String?

    var body: some View {
        
        NavigationSplitView() {

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
                reloadSampleData(modelContext: modelContext)
            }, label: {
                Text("delete All")
            })
            Button(action: {
                rootDirectory = nil
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
    
     func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Vault.self)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    
    func removeAllVault(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(vaults[index])
        }
    }
    
    func addVault(_ name: String) {
        let fileManager = FileManager.default
        let rootDirectoryPath: String = rootDirectory ?? ""
        let newDirectoryPath: String = "\(rootDirectoryPath)/\(name)"
        do {
            try fileManager.createDirectory(atPath: newDirectoryPath, withIntermediateDirectories: false, attributes: nil)
            print("done")
            if name != "" {
                let item = Vault(name: name)
                modelContext.insert(item)
            }
        } catch {
            print(error.localizedDescription)
        }
        
       
    }
    
}

//struct DetailView: View {
//    
//    
//    var body: some View {
//        Text()
//    }
//}


#Preview {
    ContentView()
}

