//
//  Created by Swift Code Factory 2022-05-18 22:49:00 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
struct SpVersionRuntimeVersion: CompositeType {
let specName: RuntimeString
let implName: RuntimeString
let authoringVersion: U32
let specVersion: U32
let implVersion: U32
let apis: ApisVec
let transactionVersion: U32
let stateVersion: U8
}
extension SpVersionRuntimeVersion: SCALEDecodable {
init(from decoder: SCALE.Decoder) throws {
specName = try decoder.decode(RuntimeString.self)
implName = try decoder.decode(RuntimeString.self)
authoringVersion = try decoder.decode(U32.self)
specVersion = try decoder.decode(U32.self)
implVersion = try decoder.decode(U32.self)
apis = try decoder.decode(ApisVec.self)
transactionVersion = try decoder.decode(U32.self)
stateVersion = try decoder.decode(U8.self)
}
}
extension TypeInfo.Path {
static let spVersionRuntimeVersion: TypeInfo.Path = ["sp_version", "RuntimeVersion"]
}