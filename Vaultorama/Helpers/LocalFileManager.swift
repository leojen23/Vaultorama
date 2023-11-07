
import SwiftUI
import SwiftData


class LocalFileManager {
    
    static let instance = LocalFileManager()
    private let dialog: NSOpenPanel = NSOpenPanel()
    private let fm: FileManager = FileManager.default
    
    @AppStorage("rootDirURL") private var rootDirURL: URL?
    @Environment(\.modelContext) private var modelContext
    @Query(animation: .snappy) private var vaults: [Vault]
    var isDirectory: ObjCBool = false
   
    
    func getDirectoryItemCount(_ dirURL: URL) -> Int {
        do {
            let count: Int = try fm.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil).filter {$0.isImage}.count
            return count
        } catch {
            print(error.localizedDescription)
        }
        return 0
    }
    
    func setRootDirectory(){
      
        let pictureDirectory: URL = try! fm.url(for: .picturesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let rootDirectoryURL: URL = pictureDirectory.appendingPathComponent("Vaultorama")
        
        guard fm.fileExists(atPath: rootDirectoryURL.path, isDirectory: &isDirectory) && isDirectory.boolValue else {
            
            do {
                try fm.createDirectory(at: rootDirectoryURL, withIntermediateDirectories: true)
                rootDirURL = rootDirectoryURL
            } catch {
                print("An error occurred: \(error)")
            }
            return
        }
        return
    }
    
    func createDirectory(_ dirName: String) {
        do {
            guard let rootDirectoryURL = rootDirURL else {
                return
            }
            try fm.createDirectory(at: rootDirectoryURL.appendingPathComponent(dirName), withIntermediateDirectories: false)
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
    func getDirectory(_ dirName: String) -> URL {
        return rootDirURL!.appendingPathComponent(dirName)
    }
    
    func getAllDirectories() -> [URL]{
        do {
            let vaultResourceKeys: [URLResourceKey] = [.nameKey, .fileSizeKey, .creationDateKey, .pathKey, .volumeURLKey]
            let directories: [URL] = try fm.contentsOfDirectory(at: rootDirURL!, includingPropertiesForKeys: vaultResourceKeys).filter { $0.isDirectory}
            return directories
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func getFiles(_ dirURL: URL) -> [URL] {
        do{
            return try fm.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil).filter {$0.isImage}
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
}

