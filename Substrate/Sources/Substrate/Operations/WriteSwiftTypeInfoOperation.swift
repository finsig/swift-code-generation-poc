//
//  Created by Steven Boynes on 5/17/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/// An Operation to write Swift Code files for provided metadata type information.
///
///
class WriteSwiftTypeInfoOperation: Operation {
    
    private var fileManager: FileManager!
    private var factory: SwiftCodeFactory!
    private var registry: TypeInfo.Registry
    
    override init() {
        fatalError("TypeInfo URL required.")
    }
    
    init(url: URL, fileManager: FileManager) async {
        self.fileManager = fileManager
        registry = await TypeInfo.Registry(url: url)
        factory = SwiftCodeFactory(registry: registry)
    }
    
    override func main() {
        Task {
            for entry in registry.entries {
                guard let outputs = try await factory.makeOutputs(typeInfo: entry.typeInfo) else {
                    continue
                }
                try fileManager.write(outputs: outputs)
            }
        }
    }
}

fileprivate extension SwiftCodeFactory {
    func makeOutputs(typeInfo: TypeInfo) async throws -> Outputs? {
        switch typeInfo.definition {
        case .array(_):
            let output = await makeArray(typeInfo: typeInfo)
            return [output]
        case .composite(_):
            return try await makeComposite(typeInfo: typeInfo)
        case .variant(_):
            return try await makeEnum(typeInfo: typeInfo)
        default:
            return nil
        }
    }
}
