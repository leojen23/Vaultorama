import SwiftUI
import SwiftData

@Model
class Vault: Identifiable {
    
    let id: String
    let name: String
    let url: URL
    
    
    init(name: String, url: URL) {
        self.id = UUID().uuidString
        self.name = name
        self.url = url
      
    }
    
    var nameString: String {
        get { return url.lastPathComponent }
    }

//
//    var cover: String {
//        get { return url.description }
//    }
    
}


class VaultAttributes {
    
    let values:[String]
    
    init(values: [String]) {
        self.values = values
    }
}

