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
    
//    var name: String {
//        get { return url.lastPathComponent }
//    }
//    
//    var cover: String {
//        get { return url.description }
//    }
}

