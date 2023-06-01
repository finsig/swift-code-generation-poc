//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Utility {
static var batched_calls_limit: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0xaa2a0000"))
}()
}