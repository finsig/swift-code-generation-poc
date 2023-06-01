//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Vesting {
static var minVestedTransfer: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00e40b54020000000000000000000000"))
}()
static var maxVestingSchedules: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x1c000000"))
}()
}