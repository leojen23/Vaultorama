import SwiftUI
import SwiftData

@Model
class Vault: Identifiable {
    
    let id: String
    let url: URL
    
    
    init(url: URL) {
        self.id = UUID().uuidString
        self.url = url
    }
    
    var name: String {
        get { return url.fileName! }
    }
    
    var size: String {
        get { return url.fileSizeString }
    }
    
    var count: Int {
        get { return LocalFileManager.instance.getDirectoryItemCount(self.url) }
    }
    
}


