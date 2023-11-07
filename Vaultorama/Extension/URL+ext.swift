
import SwiftUI

extension URL {
    
    var isDirectory: Bool {
        (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
    
    var isImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }
    
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }
    
    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }
    
    var fileSizeString: String {
        let emptyDirSize: Int = 64
        let size: Int64 = Int64(fileSize) - Int64(emptyDirSize)
        if(size == 0){
            return "Empty"
        }
        return ByteCountFormatter.string(fromByteCount: Int64(size), countStyle: .decimal)
    }
    
    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
    
    var fileName: String? {
        return self.lastPathComponent
    }
    
}
