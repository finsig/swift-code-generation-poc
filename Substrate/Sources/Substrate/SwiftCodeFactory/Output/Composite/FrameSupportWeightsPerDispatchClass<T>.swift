//
//  Created by Swift Code Factory 2022-05-18 22:49:00 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
struct FrameSupportWeightsPerDispatchClass<T>: CompositeType {
let normal: T
let operational: T
let mandatory: T
}
extension FrameSupportWeightsPerDispatchClass: SCALEDecodable where T: SCALEDecodable {
init(from decoder: SCALE.Decoder) throws {
normal = try decoder.decode(T.self)
operational = try decoder.decode(T.self)
mandatory = try decoder.decode(T.self)
}
}
extension TypeInfo.Path {
static let frameSupportWeightsPerDispatchClass: TypeInfo.Path = ["frame_support", "weights", "PerDispatchClass"]
}