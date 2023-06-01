//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Treasury {
static var proposalBond: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x50c30000"))
}()
static var proposalBondMinimum: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x0010a5d4e80000000000000000000000"))
}()
static var proposalBondMaximum: Optional<U128> = {
return try! SCALEDecoder().decode(Optional<U128>.self, from: SCALE("0x01005039278c0400000000000000000000"))
}()
static var spendPeriod: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x00460500"))
}()
static var burn: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x10270000"))
}()
static var palletId: EightElementArray<U8> = {
return try! SCALEDecoder().decode(EightElementArray<U8>.self, from: SCALE("0x70792f7472737279"))
}()
static var maxApprovals: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x64000000"))
}()
}