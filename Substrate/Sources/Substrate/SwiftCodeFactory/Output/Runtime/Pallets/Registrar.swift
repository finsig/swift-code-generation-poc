//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Registrar {
static var paraDeposit: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x0010a5d4e80000000000000000000000"))
}()
static var dataDepositPerByte: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x80969800000000000000000000000000"))
}()
}