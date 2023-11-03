////
////  VaultDataModel.swift
////  Vaultorama
////
////  Created by Olivier Guillemot on 19/10/2023.
////
//
//import SwiftUI
//import AppKit
//
//
//final class VaultDataModel: ObservableObject {
//    
//    @Published var vaults: [Vault] = []
//    
//    
//    init() {
//        
//        let fileManager = FileManager.default
//        let rootDirectoryPath: String = "/Users/olly/Desktop/testDir"
//        var isDirectory: ObjCBool = false
//        
//        let openPanel = NSOpenPanel()
//        
//        openPanel.message = "Choose a root Directory to store your image"
//        openPanel.prompt = "Authorize"
//        openPanel.canChooseFiles = false
//        openPanel.canChooseDirectories = true
//        openPanel.canCreateDirectories = true
//        openPanel.directoryURL = openPanel.url
//
//        openPanel.begin { response in
//            if response == .OK, let directoryURL = openPanel.url {
//                print(directoryURL.path)
//                do {
//                    // get Directories ONLY from the root Directory
//                    let directories: [URL] = try fileManager.contentsOfDirectory(at: openPanel.url!, includingPropertiesForKeys: nil).filter { $0.isDirectory}
//                    for dir in directories {
//                        print(dir.dataRepresentation)
//                        let vault: Vault = Vault(url: dir)
//                        self.vaults.append(vault)
//                    }
//              
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
////
////    func add(_ appetizer: Appetizer){
////        items.append(appetizer)
////    }
////    
////    func delete (offSets: IndexSet) {
////        items.remove(atOffsets: offSets)
////    }
////    
////    var totalPrice: Double {
////        items.reduce(0) {$0 + $1.price}
////    }
////    
//}
//
//extension URL {
//    var isDirectory: Bool {
//       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
//    }
//}
//
 
