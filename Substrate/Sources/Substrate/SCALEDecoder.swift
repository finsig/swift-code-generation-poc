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
public final class SCALEDecoder {
    ///
    /// Returns a value of the type you specify, decoded from a SCALE object.
    ///
    /// - Parameter type: The type of the value to decode from the supplied SCALE object.
    /// - Parameter scale: The SCALE hexadecimal representation of the object to decode.
    /// - Returns: A value of the specified type, if the decoder can parse the data.
    /// - Throws: `DecodingError.dataCorrupted(_:)` if the data is corrupted, or if the given data is not SCALE encoded.
    ///
    public func decode<T: ScaleDecodable>(_ type: T.Type, from hexadecimal: SCALE) throws -> T {
        return try ScaleCodec.SCALE.default.decode(type, from: Data(scale: hexadecimal))
    }
    
    public func decode<T: ScaleDecodable>(_ type: T.Type, from data: Data) throws -> T {
        return try ScaleCodec.SCALE.default.decode(type, from: data)
    }
}
