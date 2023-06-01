//
//  Created by Steven Boynes on 4/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

///  A factory class for creating Swift code from type information.
///
class SwiftCodeFactory {

    typealias Outputs = [Output]
    
    internal typealias Name = String
    internal var outputsDictionary: Dictionary<Name, Output>
    internal var registry: TypeInfo.Registry

    init(registry: TypeInfo.Registry) {
        self.registry = registry
        outputsDictionary = Dictionary<Name, Output>()
    }    
}


extension SwiftCodeFactory {
    struct Output {
        let code: SwiftCode.Block
        let path: Path?
        
        init(code: SwiftCode.Block, path: Path? = nil) {
            self.code = code
            self.path = path
        }
    }
}

extension SwiftCodeFactory.Output {
    enum Path: String {
        case array = "Array"
        case composite = "Composite"
        case `enum` = "Enum"
        case pallet = "Runtime/Pallets"
        case path = "Path"
        case `typealias` = "Typealias"
        
        init?(typeInfo: TypeInfo) {
            switch typeInfo.definition {
            case .array(_):
                self = .array
            case .composite(_):
                self = .composite
            case .variant(_):
                self = .enum
            default:
                return nil
            }
        }
    }
}

extension SwiftCodeFactory.Output: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(code.lines)
        hasher.combine(path)
    }
    
    static func == (lhs: SwiftCodeFactory.Output, rhs: SwiftCodeFactory.Output) -> Bool {
        return (lhs.code.lines == rhs.code.lines) && (lhs.path == rhs.path)
    }
}
