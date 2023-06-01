//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct System {
static var blockWeights: FrameSystemLimitsBlockWeights = {
return try! SCALEDecoder().decode(FrameSystemLimitsBlockWeights.self, from: SCALE("0x588bc0460100000000204aa9d1010000603b14050000000001a094cb9158010000010098f73e5d010000010000000000000000603b14050000000001a01c1efccc0100000100204aa9d1010000010088526a74000000603b140500000000000000"))
}()
static var blockLength: FrameSystemLimitsBlockLength = {
return try! SCALEDecoder().decode(FrameSystemLimitsBlockLength.self, from: SCALE("0x00003c000000500000005000"))
}()
static var blockHashCount: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x60090000"))
}()
static var dbWeight: FrameSupportWeightsRuntimeDbWeight = {
return try! SCALEDecoder().decode(FrameSupportWeightsRuntimeDbWeight.self, from: SCALE("0x38ca38010000000098aaf90400000000"))
}()
static var version: SpVersionRuntimeVersion = {
return try! SCALEDecoder().decode(SpVersionRuntimeVersion.self, from: SCALE("0x20706f6c6b61646f743c7061726974792d706f6c6b61646f7400000000f02300000000000038df6acb689907609b0400000037e397fc7c91f5e40100000040fe3ad401f8959a06000000d2bc9897eed08f1503000000f78b278be53f454c02000000af2c0297a23e6d3d0200000049eaaf1b548a0cb00100000091d5df18b0d2cf5801000000ed99c5acb25eedf503000000cbca25e39f14238702000000687ad44ad37f03c201000000ab3c0572291feb8b01000000bc9d89904f5b923f0100000037c8bb1350a9a2a8010000000c00000000"))
}()
static var sS58Prefix: U16 = {
return try! SCALEDecoder().decode(U16.self, from: SCALE("0x0000"))
}()
}