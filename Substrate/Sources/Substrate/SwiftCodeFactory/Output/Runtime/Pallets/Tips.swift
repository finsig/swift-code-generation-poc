//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Tips {
static var maximumReasonLength: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00400000"))
}()
static var dataDepositPerByte: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00e1f505000000000000000000000000"))
}()
static var tipCountdown: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x40380000"))
}()
static var tipFindersFee: U8 = {
return try! SCALEDecoder().decode(U8.self, from: SCALE("0x14"))
}()
static var tipReportDepositBase: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00e40b54020000000000000000000000"))
}()
}