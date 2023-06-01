//
//  Created by Swift Code Factory 2022-06-02 18:57:32 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
struct FourteenElementArray<T: SCALEDecodable>: FixedCapacityArray {
static var capacity: U32 { return .capacity }
var value: [T] = [T]()
}
extension FourteenElementArray: SCALEDecodable {
init(from decoder: SCALE.Decoder) throws {
let capacity = UInt(FourteenElementArray.capacity)
value = try decoder.decode( .fixed(capacity) ) as [T]
}
}
fileprivate extension U32 {
static let capacity = U32(14)
}