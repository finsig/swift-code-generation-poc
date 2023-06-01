//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct BABE {
static var epochDuration: U64 = {
return try! SCALEDecoder().decode(U64.self, from: SCALE("0x6009000000000000"))
}()
static var expectedBlockTime: U64 = {
return try! SCALEDecoder().decode(U64.self, from: SCALE("0x7017000000000000"))
}()
static var maxAuthorities: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0xa0860100"))
}()
}