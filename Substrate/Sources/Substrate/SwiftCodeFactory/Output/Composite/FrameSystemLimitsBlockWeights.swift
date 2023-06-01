//
//  Created by Swift Code Factory 2022-05-18 22:49:00 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
struct FrameSystemLimitsBlockWeights: CompositeType {
let baseBlock: Weight
let maxBlock: Weight
let perClass: FrameSupportWeightsPerDispatchClass<FrameSystemLimitsWeightsPerClass>
}
extension FrameSystemLimitsBlockWeights: SCALEDecodable {
init(from decoder: SCALE.Decoder) throws {
baseBlock = try decoder.decode(Weight.self)
maxBlock = try decoder.decode(Weight.self)
perClass = try decoder.decode(FrameSupportWeightsPerDispatchClass<FrameSystemLimitsWeightsPerClass>.self)
}
}
extension TypeInfo.Path {
static let frameSystemLimitsBlockWeights: TypeInfo.Path = ["frame_system", "limits", "BlockWeights"]
}