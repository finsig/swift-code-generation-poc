//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct PhragmenElection {
static var palletId: EightElementArray<U8> = {
return try! SCALEDecoder().decode(EightElementArray<U8>.self, from: SCALE("0x706872656c656374"))
}()
static var candidacyBond: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x0010a5d4e80000000000000000000000"))
}()
static var votingBondBase: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x007013b72e0000000000000000000000"))
}()
static var votingBondFactor: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00d01213000000000000000000000000"))
}()
static var desiredMembers: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x0d000000"))
}()
static var desiredRunnersUp: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x14000000"))
}()
static var termDuration: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0xc0890100"))
}()
}