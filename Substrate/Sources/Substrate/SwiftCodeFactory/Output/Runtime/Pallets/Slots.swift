//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Slots {
static var leasePeriod: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00751200"))
}()
static var leaseOffset: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00100e00"))
}()
}