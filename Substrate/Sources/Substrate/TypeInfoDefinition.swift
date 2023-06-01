//
//  Created by Steven Boynes on 3/1/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo {
    ///
    /// An enumeration of Substrate type definitions.
    ///
    /// - SeeAlso:
    /// - [Substrate Documentation](https://docs.substrate.io/rustdocs/latest/scale_info/enum.TypeDef.html)
    ///
    enum Definition {
        case array(Definition.Array)
        case bitSequence(Definition.BitSequence)
        case compact(Compact)
        case composite(Composite)
        case primitive(Primitive)
        case sequence(Definition.Sequence)
        case tuple(Tuple)
        case variant(Variant)
        // NOTE: This is specific to the implementation for pre-v14 metadata
        // compatibility (always keep this as the last entry in the enum)
        //HistoricMetaCompat: 'Type'
    }
}

extension TypeInfo.Definition: Equatable {
    static func == (lhs: TypeInfo.Definition, rhs: TypeInfo.Definition) -> Bool {

        if let lhsDefinition = lhs.rawValue as? Primitive, let rhsDefinition = rhs.rawValue as? Primitive {
            return (lhsDefinition.name == rhsDefinition.name)
        }
        else if let lhsDefinition = lhs.rawValue as? Compact, let rhsDefinition = rhs.rawValue as? Compact {
            return (lhsDefinition == rhsDefinition)
        }
        else {
            return false
        }
    }
}

extension TypeInfo.Definition {
    var rawValue: Any {
        switch self {
        case .array(let value):
            return value
        case .bitSequence(let value):
            return value
        case .compact(let value):
            return value
        case .composite(let value):
            return value
        case .primitive(let value):
            return value
        case .sequence(let value):
            return value
        case .tuple(let value):
            return value
        case .variant(let value):
            return value
        }
    }
}

extension TypeInfo.Definition: Decodable {
    internal typealias Definition = TypeInfo.Definition
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
       
        if let value = try? container.decode(Definition.Array.self) {
            self = .array(value)
        }
        else if let value = try? container.decode(Definition.BitSequence.self) {
            self = .bitSequence(value)
        }
        else if let value = try? container.decode(Definition.Compact.self) {
            self = .compact(value)
        }
        else if let value = try? container.decode(Definition.Composite.self) {
            self = .composite(value)
        }
        else if let value = try? container.decode(Definition.Primitive.self) {
            self = .primitive(value)
        }
        else if let value = try? container.decode(Definition.Sequence.self) {
            self = .sequence(value)
        }
        else if let value = try? container.decode(Definition.Tuple.self) {
            self = .tuple(value)
        }
        else if let value = try? container.decode(Definition.Variant.self) {
            self = .variant(value)
        }
        else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Unrecognized type definition dictionary key.")
        }
    }
}
