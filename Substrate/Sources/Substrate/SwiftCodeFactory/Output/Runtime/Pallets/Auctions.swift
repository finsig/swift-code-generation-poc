//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Auctions {
static var endingPeriod: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x40190100"))
}()
static var sampleLength: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x14000000"))
}()
static var slotRangeCount: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x24000000"))
}()
static var leasePeriodsPerSlot: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x08000000"))
}()
}