//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Indices {
static var deposit: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00e87648170000000000000000000000"))
}()
}