//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Identity {
static var basicDeposit: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x007db52a2f0000000000000000000000"))
}()
static var fieldDeposit: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00cd5627000000000000000000000000"))
}()
static var subAccountDeposit: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x80f884b02e0000000000000000000000"))
}()
static var maxSubAccounts: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x64000000"))
}()
static var maxAdditionalFields: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x64000000"))
}()
static var maxRegistrars: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x14000000"))
}()
}