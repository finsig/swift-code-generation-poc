//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct ImOnline {
static var unsignedPriority: U64 = {
return try! SCALEDecoder().decode(U64.self, from: SCALE("0xffffffffffffffff"))
}()
}