//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Crowdloan {
static var palletId: EightElementArray<U8> = {
return try! SCALEDecoder().decode(EightElementArray<U8>.self, from: SCALE("0x70792f6366756e64"))
}()
static var minContribution: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00743ba40b0000000000000000000000"))
}()
static var removeKeysLimit: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0xe8030000"))
}()
}