//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Scheduler {
static var maximumWeight: U64 = {
return try! SCALEDecoder().decode(U64.self, from: SCALE("0x00806e8774010000"))
}()
static var maxScheduledPerBlock: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x32000000"))
}()
}