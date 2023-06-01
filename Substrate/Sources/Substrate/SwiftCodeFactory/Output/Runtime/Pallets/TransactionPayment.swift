//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct TransactionPayment {
static var operationalFeeMultiplier: U8 = {
return try! SCALEDecoder().decode(U8.self, from: SCALE("0x05"))
}()
static var weightToFee: Vec<FrameSupportWeightsWeightToFeeCoefficient<U128>> = {
return try! SCALEDecoder().decode(Vec<FrameSupportWeightsWeightToFeeCoefficient<U128>>.self, from: SCALE("0x04000000000000000000000000000000007baffe060001"))
}()
static var lengthToFee: Vec<FrameSupportWeightsWeightToFeeCoefficient<U128>> = {
return try! SCALEDecoder().decode(Vec<FrameSupportWeightsWeightToFeeCoefficient<U128>>.self, from: SCALE("0x0440420f00000000000000000000000000000000000001"))
}()
}