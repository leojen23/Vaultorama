import SwiftUI
import SwiftData

@Model
class Vault: Identifiable {
    
    let id: String
    let url: URL
    var images: [URL]?
    
    init(url: URL, images: [URL]?) {
        self.id = UUID().uuidString
        self.url = url
        self.images = images ?? LocalFileManager.instance.getFiles(url)
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
    
    var files: [URL] {
        get { return LocalFileManager.instance.getFiles(url) }
    }
    
    func setFiles(_ files: [URL]) {
        self.images = files
    }
    
}

class FileItem {
    
    let id: String
    let url: URL
    
    init(url: URL) {
        self.id = UUID().uuidString
        self.url = url
    }
}


