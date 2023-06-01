//
//  Created by Swift Code Factory 2022-06-02 18:57:31 +0000
//  Copyright © 2022 Finsig LLC. All rights reserved.
//
import Foundation
public struct Claims {
static var prefix: Vec<U8> = {
return try! SCALEDecoder().decode(Vec<U8>.self, from: SCALE("0x8450617920444f547320746f2074686520506f6c6b61646f74206163636f756e743a"))
}()
}