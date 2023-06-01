//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct GRANDPA {
static var maxAuthorities: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0xa0860100"))
}()
}