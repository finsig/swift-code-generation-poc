//
//  Created by Steven Boynes on 2/18/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/// An enumeration for hexadecimal string representation.
///
public enum Hexadecimal {
    case string(String) /// - Remark: String representation is used to overcome unsigned integer representation limits.
}

extension Hexadecimal {
    init(_ string: String) {
        guard string.isHexadecimal else {
            fatalError()
        }
        let digitsOnly = String( string.dropFirst(String.hexadecimalPrefix.count) )
        self = .string(digitsOnly)
    }
    
    public var string: String {
        switch self {
        case .string(let value):
            return value
        }
    }
    
    public var prefixedString: String {
        return String.hexadecimalPrefix + string
    }
}

extension Hexadecimal: Codable {
    public init(from decoder: Swift.Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        guard string.isHexadecimal else {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid hexadecimal string representation.")
            throw DecodingError.dataCorrupted(context)
        }
        self.init(string)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        }
    }
}

fileprivate extension String {
    static let hexadecimalPrefix = "0x"
    
    var isHexadecimal: Bool {
        return hasPrefix(.hexadecimalPrefix)
    }
}
