//
//  Created by Swift Code Factory 2022-05-18 22:49:00 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
struct FrameSystemLimitsBlockLength: CompositeType {
let max: FrameSupportWeightsPerDispatchClass<U32>
}
extension FrameSystemLimitsBlockLength: SCALEDecodable {
init(from decoder: SCALE.Decoder) throws {
max = try decoder.decode(FrameSupportWeightsPerDispatchClass<U32>.self)
}
}
extension TypeInfo.Path {
static let frameSystemLimitsBlockLength: TypeInfo.Path = ["frame_system", "limits", "BlockLength"]
}