//
//  Created by Steven Boynes on 2/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/// A type that represents a Swift Optional.
///
/// A swift Optional is a type that represents either a wrapped value or nil, the absence of value.
///
/// - SeeAlso:
/// [Swift Documentation](https://developer.apple.com/documentation/swift/optional)
///
typealias Option = Optional


extension Option: PortableFormRepresentable {}
