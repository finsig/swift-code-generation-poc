//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct ElectionProviderMultiPhase {
static var unsignedPhase: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x58020000"))
}()
static var signedPhase: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x58020000"))
}()
static var betterSignedThreshold: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00000000"))
}()
static var betterUnsignedThreshold: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x20a10700"))
}()
static var offchainRepeat: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x12000000"))
}()
static var minerTxPriority: U64 = {
return try! SCALEDecoder().decode(U64.self, from: SCALE("0x65666666666666e6"))
}()
static var minerMaxWeight: U64 = {
return try! SCALEDecoder().decode(U64.self, from: SCALE("0x48090b4b57010000"))
}()
static var signedMaxSubmissions: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x10000000"))
}()
static var signedMaxWeight: U64 = {
return try! SCALEDecoder().decode(U64.self, from: SCALE("0x48090b4b57010000"))
}()
static var signedMaxRefunds: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x04000000"))
}()
static var signedRewardBase: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00e40b54020000000000000000000000"))
}()
static var signedDepositBase: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00a0db215d0000000000000000000000"))
}()
static var signedDepositByte: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x787d0100000000000000000000000000"))
}()
static var signedDepositWeight: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00000000000000000000000000000000"))
}()
static var maxElectingVoters: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0xe4570000"))
}()
static var maxElectableTargets: U16 = {
return try! SCALEDecoder().decode(U16.self, from: SCALE("0xffff"))
}()
static var minerMaxLength: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00003600"))
}()
}