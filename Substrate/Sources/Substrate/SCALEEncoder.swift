//
//  Created by Steven Boynes on 2/14/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation
import ScaleCodec

/// An object that decodes instances of a data type from the SCALE (Simple Concatenated Aggregate Little-Endian) data format.
///
/// - ATTENTION: This is a wrapper for the Tesseract implementation of the SCALE Codec.
///
/// - SeeAlso:
/// - [Substrate Documentation](https://docs.substrate.io/v3/advanced/scale-codec/#codec-definition)
/// - [Swift implementation](https://github.com/tesseract-one/swift-scale-codec) by Tesseract, on GitHub.
///
public final class SCALEEncoder {
    ///
    /// Encodes the given top-level value and returns its SCALE representation.
    ///
    /// - Parameter value: The value to encode.
    /// - Returns: A new `Data` value containing the encoded SCALE data.
    /// - Throws: `EncodingError.invalidValue` if a non-conforming floating-point value is encountered during encoding, and the encoding strategy is `.throw`.
    /// - Throws: An error if any value throws an error during encoding.
    ///
    public func encode<T: ScaleEncodable>(_ value: T) throws -> Data {
        return try ScaleCodec.SCALE.default.encode(value)
    }
}
