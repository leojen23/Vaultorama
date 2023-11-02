//
//  Vault.swift
//  Vaultorama
//
//  Created by Olivier Guillemot on 30/10/2023.
//

import SwiftUI
import SwiftData

@Model
class Vault: Identifiable {
    
    let id: String
    let name: String
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
    
//    var name: String {
//        get { return url.lastPathComponent }
//    }
//    
//    var cover: String {
//        get { return url.description }
//    }
}

