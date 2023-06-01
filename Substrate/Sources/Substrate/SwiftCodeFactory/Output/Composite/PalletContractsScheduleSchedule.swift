//
//  Created by Swift Code Factory 2022-05-18 22:49:00 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
struct PalletContractsScheduleSchedule: CompositeType {
let limits: Limits
let instructionWeights: PalletContractsScheduleInstructionWeights
let hostFnWeights: PalletContractsScheduleHostFnWeights
}
extension PalletContractsScheduleSchedule: SCALEDecodable {
init(from decoder: SCALE.Decoder) throws {
limits = try decoder.decode(Limits.self)
instructionWeights = try decoder.decode(PalletContractsScheduleInstructionWeights.self)
hostFnWeights = try decoder.decode(PalletContractsScheduleHostFnWeights.self)
}
}
extension TypeInfo.Path {
static let palletContractsScheduleSchedule: TypeInfo.Path = ["pallet_contracts", "schedule", "Schedule"]
}