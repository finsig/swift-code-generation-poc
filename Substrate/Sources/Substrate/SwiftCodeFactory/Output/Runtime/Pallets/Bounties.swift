//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Bounties {
static var bountyDepositBase: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00e40b54020000000000000000000000"))
}()
static var bountyDepositPayoutDelay: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00c20100"))
}()
static var bountyUpdatePeriod: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x80c61300"))
}()
static var curatorDepositMultiplier: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x20a10700"))
}()
static var curatorDepositMax: Optional<U128> = {
return try! SCALEDecoder().decode(Optional<U128>.self, from: SCALE("0x0100204aa9d10100000000000000000000"))
}()
static var curatorDepositMin: Optional<U128> = {
return try! SCALEDecoder().decode(Optional<U128>.self, from: SCALE("0x0100e87648170000000000000000000000"))
}()
static var bountyValueMinimum: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00e87648170000000000000000000000"))
}()
static var dataDepositPerByte: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00e1f505000000000000000000000000"))
}()
static var maximumReasonLength: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00400000"))
}()
}