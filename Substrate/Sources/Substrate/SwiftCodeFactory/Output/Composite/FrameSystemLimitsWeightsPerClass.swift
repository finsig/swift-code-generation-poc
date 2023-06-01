//
//  Created by Swift Code Factory 2022-05-18 22:49:00 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
struct FrameSystemLimitsWeightsPerClass: CompositeType {
let baseExtrinsic: Weight
let maxExtrinsic: Option<Weight>
let maxTotal: Option<Weight>
let reserved: Option<Weight>
}
extension FrameSystemLimitsWeightsPerClass: SCALEDecodable {
init(from decoder: SCALE.Decoder) throws {
baseExtrinsic = try decoder.decode(Weight.self)
maxExtrinsic = try decoder.decode(Option<Weight>.self)
maxTotal = try decoder.decode(Option<Weight>.self)
reserved = try decoder.decode(Option<Weight>.self)
}
}
extension TypeInfo.Path {
static let frameSystemLimitsWeightsPerClass: TypeInfo.Path = ["frame_system", "limits", "WeightsPerClass"]
}