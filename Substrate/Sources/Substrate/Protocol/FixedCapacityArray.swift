//
//  Created by Steven Boynes on 3/3/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/// A protocol for a Substrate Array. In the Rust programming language Array capacity is specified at compile time.
///
/// - SeeAlso:
/// [Rust Documentation](https://doc.rust-lang.org/rust-by-example/primitives/array.html)
///
protocol FixedCapacityArray: PortableFormRepresentable {
    associatedtype T
    static var capacity: U32 { get }
    var value: [T] { get set }
}
