//
//  Created by Swift Code Factory 2022-05-18 22:49:00 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
struct PalletContractsScheduleLimits: CompositeType {
let eventTopics: U32
let stackHeight: U32
let globals: U32
let parameters: U32
let memoryPages: U32
let tableSize: U32
let brTableSize: U32
let subjectLen: U32
let callDepth: U32
let payloadLen: U32
let codeLen: U32
}
extension PalletContractsScheduleLimits: SCALEDecodable {
init(from decoder: SCALE.Decoder) throws {
eventTopics = try decoder.decode(U32.self)
stackHeight = try decoder.decode(U32.self)
globals = try decoder.decode(U32.self)
parameters = try decoder.decode(U32.self)
memoryPages = try decoder.decode(U32.self)
tableSize = try decoder.decode(U32.self)
brTableSize = try decoder.decode(U32.self)
subjectLen = try decoder.decode(U32.self)
callDepth = try decoder.decode(U32.self)
payloadLen = try decoder.decode(U32.self)
codeLen = try decoder.decode(U32.self)
}
}
extension TypeInfo.Path {
static let palletContractsScheduleLimits: TypeInfo.Path = ["pallet_contracts", "schedule", "Limits"]
}