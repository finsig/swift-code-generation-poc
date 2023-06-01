//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Proxy {
static var proxyDepositBase: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x0084b2952e0000000000000000000000"))
}()
static var proxyDepositFactor: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x8066ab13000000000000000000000000"))
}()
static var maxProxies: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x20000000"))
}()
static var maxPending: U32 = {
return try! SCALEDecoder().decode(U32.self, from: SCALE("0x20000000"))
}()
static var announcementDepositBase: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x0084b2952e0000000000000000000000"))
}()
static var announcementDepositFactor: U128 = {
return try! SCALEDecoder().decode(U128.self, from: SCALE("0x00cd5627000000000000000000000000"))
}()
}