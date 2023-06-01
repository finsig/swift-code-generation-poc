//
//  Created by Steven Boynes on 5/17/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/// An Operation to write Swift Code files for provided metadata pallet information.
///
///
class WriteSwiftPalletsOperation: Operation {
    
    private var fileManager: FileManager!
    private var factory: SwiftCodeFactory!
    private var registry: TypeInfo.Registry
    private var metadataURL: URL!
    
    override init() {
        fatalError()
    }
    
    init(metadata metadataURL: URL, registry registryURL: URL, fileManager: FileManager) async {
        self.metadataURL = metadataURL
        self.fileManager = fileManager
        registry = await TypeInfo.Registry(url: registryURL)
        factory = SwiftCodeFactory(registry: registry)
    }
    
    override func main() {
        Task {
            let (data, _) = try! await URLSession.shared.data(from: metadataURL)
            let metadata = try! JSONDecoder().decode(Metadata.self, from: data)
            let palletMetadata: [Metadata.Pallet] = metadata.version[.version]!.pallets
            
            for metadata in palletMetadata {
                let output = try await factory.makePallet(metadata: metadata)
                try fileManager.write(output: output)
            }
        }
    }
}

fileprivate extension Metadata.Version.Key {
    static let version: Metadata.Version.Key = .v14
}
