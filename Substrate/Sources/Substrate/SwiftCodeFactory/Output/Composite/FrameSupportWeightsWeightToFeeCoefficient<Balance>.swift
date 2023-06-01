//
//  Created by Swift Code Factory 2022-05-18 22:49:00 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
struct FrameSupportWeightsWeightToFeeCoefficient<Balance>: CompositeType {
let coeffInteger: Balance
let coeffFrac: Perbill
let negative: Bool
let degree: U8
}
extension FrameSupportWeightsWeightToFeeCoefficient: SCALEDecodable where Balance: SCALEDecodable {
init(from decoder: SCALE.Decoder) throws {
coeffInteger = try decoder.decode(Balance.self)
coeffFrac = try decoder.decode(Perbill.self)
negative = try decoder.decode(Bool.self)
degree = try decoder.decode(U8.self)
}
}
extension TypeInfo.Path {
static let frameSupportWeightsWeightToFeeCoefficient: TypeInfo.Path = ["frame_support", "weights", "WeightToFeeCoefficient"]
}