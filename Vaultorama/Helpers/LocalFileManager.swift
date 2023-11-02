//
//  LocalFileManager.swift
//  Vaultorama
//
//  Created by Olivier Guillemot on 01/11/2023.
//

import SwiftUI


class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    @AppStorage("rootDirectory") private var rootDirectory: String?
    
    func setRootDirectory() {
        let dialog = NSOpenPanel()

        dialog.message                 = "Choose the root Directory of your application"
        dialog.showsResizeIndicator    = true
        dialog.showsHiddenFiles        = false
        dialog.canChooseFiles          = false
        dialog.canChooseDirectories    = true
        dialog.canCreateDirectories = true
        dialog.allowsMultipleSelection = false

        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url
            if (result != nil) {
                let path: String = result!.path
                rootDirectory = path
            }
        } else {
            // User clicked on "Cancel"
            
        }
       
    }
}
