//
//  Created by Steven Boynes on 3/7/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation
import ScaleCodec

/// A type that represents a Tuple.
///
extension Substrate {
    /// An enumeration representing a Substrate Sequence.
    ///
    struct Tuple {
        let elements: [PortableFormRepresentable]
    }
}


typealias TwoElementTuple<T1,T2> = STuple2<T1,T2>
typealias ThreeElementTuple<T1,T2,T3> = STuple3<T1,T2,T3>
typealias FourElementTuple<T1,T2,T3,T4> = STuple4<T1,T2,T3,T4>
typealias FiveElementTuple<T1,T2,T3,T4,T5> = STuple5<T1,T2,T3,T4,T5>
typealias SixElementTuple<T1,T2,T3,T4,T5,T6> = STuple6<T1,T2,T3,T4,T5,T6>
typealias SevenElementTuple<T1,T2,T3,T4,T5,T6,T7> = STuple7<T1,T2,T3,T4,T5,T6,T7>
typealias EightElementTuple<T1,T2,T3,T4,T5,T6,T7,T8> = STuple8<T1,T2,T3,T4,T5,T6,T7,T8>
typealias NineElementTuple<T1,T2,T3,T4,T5,T6,T7,T8,T9> = STuple9<T1,T2,T3,T4,T5,T6,T7,T8,T9>
typealias TenElementTuple<T1,T2,T3,T4,T5,T6,T7,T8,T9,T10> = STuple10<T1,T2,T3,T4,T5,T6,T7,T8,T9,T10>
