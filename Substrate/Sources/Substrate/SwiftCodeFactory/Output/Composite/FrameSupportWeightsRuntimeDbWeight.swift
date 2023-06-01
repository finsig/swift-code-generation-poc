//
//  Created by Swift Code Factory 2022-05-18 22:49:00 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
struct FrameSupportWeightsRuntimeDbWeight: CompositeType {
let read: Weight
let write: Weight
}
extension FrameSupportWeightsRuntimeDbWeight: SCALEDecodable {
init(from decoder: SCALE.Decoder) throws {
read = try decoder.decode(Weight.self)
write = try decoder.decode(Weight.self)
}
}
extension TypeInfo.Path {
static let frameSupportWeightsRuntimeDbWeight: TypeInfo.Path = ["frame_support", "weights", "RuntimeDbWeight"]
}