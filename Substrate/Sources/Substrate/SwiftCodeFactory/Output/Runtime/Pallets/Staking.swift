//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Staking {
static var maxNominations: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x10000000"))
}()
static var sessionsPerEra: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x06000000"))
}()
static var bondingDuration: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x1c000000"))
}()
static var slashDeferDuration: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x1b000000"))
}()
static var maxNominatorRewardedPerValidator: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00010000"))
}()
static var maxUnlockingChunks: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x20000000"))
}()
}