//
//  Created by Steven Boynes on 3/2/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Definition {
    ///
    /// Definition for Primitive types.
    ///
    struct Primitive {
        static let key = "primitive"
        var name: Name
        
        enum Name: String, CaseIterable, Decodable {
            case bool = "Bool"
            case char = "Char"
            case string = "Str"
            case u8 = "U8"
            case u16 = "U16"
            case u32 = "U32"
            case u64 = "U64"
            case u128 = "U128"
            case u256 = "U256"
            case i8 = "I8"
            case i16 = "I16"
            case i32 = "I32"
            case i64 = "I64"
            case i128 = "I128"
            case i256 = "I256"
        }
    }
}


extension TypeInfo.Definition.Primitive: Decodable {
    fileprivate typealias Definition = TypeInfo.Definition.Primitive
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        guard let dictionary = try? container.decode(Dictionary<String,Name>.self) else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid definition dictionary.")
        }
        guard (dictionary.keys.first == Definition.key) else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid key.")
        }
        guard let name = dictionary.values.first, (Name.allCases.contains(name) == true) else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid name value.")
        }
        self = .init(name: name)
    }
}

extension Substrate {
    static func type(of primitive: TypeInfo.Definition.Primitive) -> Any.Type {
        switch primitive.name {
        case .bool:
            return Bool.self
        case .char:
            return Character.self
        case .string:
            return Str.self
        case .u8:
            return U8.self
        case .u16:
            return U16.self
        case .u32:
            return U32.self
        case .u64:
            return U64.self
        case .u128:
            return U128.self
        default:
            fatalError()
            /*
        case u256:
            return U256.self
        case i8:
            return I8.self
        case i16:
            return I6.self
        case i32:
            return I32.self
        case i64:
            return U16.self
        case i128:
            return U16.self
        case i256:
             */
        }
    }
}
