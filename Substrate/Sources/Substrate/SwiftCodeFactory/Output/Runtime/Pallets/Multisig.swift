//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Multisig {
static var depositBase: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x008c61c52e0000000000000000000000"))
}()
static var depositFactor: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00d01213000000000000000000000000"))
}()
static var maxSignatories: U16 = {
return try! SCALEDecoder().decode(U16.self, from: SCALE("0x6400"))
}()
}