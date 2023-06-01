//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Democracy {
static var enactmentPeriod: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00270600"))
}()
static var launchPeriod: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00270600"))
}()
static var votingPeriod: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00270600"))
}()
static var voteLockingPeriod: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00270600"))
}()
static var minimumDeposit: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x0010a5d4e80000000000000000000000"))
}()
static var instantAllowed: Bool = {
return try! SCALEDecoder().decode(Bool.self, from: SCALE("0x01"))
}()
static var fastTrackVotingPeriod: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x08070000"))
}()
static var cooloffPeriod: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0xc0890100"))
}()
static var preimageByteDeposit: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x80969800000000000000000000000000"))
}()
static var maxVotes: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x64000000"))
}()
static var maxProposals: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x64000000"))
}()
}