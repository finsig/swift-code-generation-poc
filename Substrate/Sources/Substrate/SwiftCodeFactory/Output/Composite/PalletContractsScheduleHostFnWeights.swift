//
//  Created by Swift Code Factory 2022-05-18 22:49:00 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
struct PalletContractsScheduleHostFnWeights: CompositeType {
let caller: Weight
let isContract: Weight
let callerIsOrigin: Weight
let address: Weight
let gasLeft: Weight
let balance: Weight
let valueTransferred: Weight
let minimumBalance: Weight
let blockNumber: Weight
let now: Weight
let weightToFee: Weight
let gas: Weight
let input: Weight
let inputPerByte: Weight
let r_hashtag_return: Weight
let returnPerByte: Weight
let terminate: Weight
let random: Weight
let depositEvent: Weight
let depositEventPerTopic: Weight
let depositEventPerByte: Weight
let debugMessage: Weight
let setStorage: Weight
let setStoragePerNewByte: Weight
let setStoragePerOldByte: Weight
let setCodeHash: Weight
let clearStorage: Weight
let clearStoragePerByte: Weight
let containsStorage: Weight
let containsStoragePerByte: Weight
let getStorage: Weight
let getStoragePerByte: Weight
let takeStorage: Weight
let takeStoragePerByte: Weight
let transfer: Weight
let call: Weight
let delegateCall: Weight
let callTransferSurcharge: Weight
let callPerClonedByte: Weight
let instantiate: Weight
let instantiateTransferSurcharge: Weight
let instantiatePerSaltByte: Weight
let hashSha2256: Weight
let hashSha2256PerByte: Weight
let hashKeccak256: Weight
let hashKeccak256PerByte: Weight
let hashBlake2256: Weight
let hashBlake2256PerByte: Weight
let hashBlake2128: Weight
let hashBlake2128PerByte: Weight
let ecdsaRecover: Weight
}
extension PalletContractsScheduleHostFnWeights: SCALEDecodable {
init(from decoder: SCALE.Decoder) throws {
caller = try decoder.decode(Weight.self)
isContract = try decoder.decode(Weight.self)
callerIsOrigin = try decoder.decode(Weight.self)
address = try decoder.decode(Weight.self)
gasLeft = try decoder.decode(Weight.self)
balance = try decoder.decode(Weight.self)
valueTransferred = try decoder.decode(Weight.self)
minimumBalance = try decoder.decode(Weight.self)
blockNumber = try decoder.decode(Weight.self)
now = try decoder.decode(Weight.self)
weightToFee = try decoder.decode(Weight.self)
gas = try decoder.decode(Weight.self)
input = try decoder.decode(Weight.self)
inputPerByte = try decoder.decode(Weight.self)
r_hashtag_return = try decoder.decode(Weight.self)
returnPerByte = try decoder.decode(Weight.self)
terminate = try decoder.decode(Weight.self)
random = try decoder.decode(Weight.self)
depositEvent = try decoder.decode(Weight.self)
depositEventPerTopic = try decoder.decode(Weight.self)
depositEventPerByte = try decoder.decode(Weight.self)
debugMessage = try decoder.decode(Weight.self)
setStorage = try decoder.decode(Weight.self)
setStoragePerNewByte = try decoder.decode(Weight.self)
setStoragePerOldByte = try decoder.decode(Weight.self)
setCodeHash = try decoder.decode(Weight.self)
clearStorage = try decoder.decode(Weight.self)
clearStoragePerByte = try decoder.decode(Weight.self)
containsStorage = try decoder.decode(Weight.self)
containsStoragePerByte = try decoder.decode(Weight.self)
getStorage = try decoder.decode(Weight.self)
getStoragePerByte = try decoder.decode(Weight.self)
takeStorage = try decoder.decode(Weight.self)
takeStoragePerByte = try decoder.decode(Weight.self)
transfer = try decoder.decode(Weight.self)
call = try decoder.decode(Weight.self)
delegateCall = try decoder.decode(Weight.self)
callTransferSurcharge = try decoder.decode(Weight.self)
callPerClonedByte = try decoder.decode(Weight.self)
instantiate = try decoder.decode(Weight.self)
instantiateTransferSurcharge = try decoder.decode(Weight.self)
instantiatePerSaltByte = try decoder.decode(Weight.self)
hashSha2256 = try decoder.decode(Weight.self)
hashSha2256PerByte = try decoder.decode(Weight.self)
hashKeccak256 = try decoder.decode(Weight.self)
hashKeccak256PerByte = try decoder.decode(Weight.self)
hashBlake2256 = try decoder.decode(Weight.self)
hashBlake2256PerByte = try decoder.decode(Weight.self)
hashBlake2128 = try decoder.decode(Weight.self)
hashBlake2128PerByte = try decoder.decode(Weight.self)
ecdsaRecover = try decoder.decode(Weight.self)
}
}
extension TypeInfo.Path {
static let palletContractsScheduleHostFnWeights: TypeInfo.Path = ["pallet_contracts", "schedule", "HostFnWeights"]
}