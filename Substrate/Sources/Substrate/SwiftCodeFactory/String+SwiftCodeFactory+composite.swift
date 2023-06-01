//
//  Created by Steven Boynes on 2/3/23.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension String {
    init(describingComposite composite: TypeInfo.Definition.Composite, typeInfo: TypeInfo) {
        
        guard let name = typeInfo.path.last?.uppercasingFirstLetter() else {
            fatalError()
        }
        if typeInfo.parameters.isEmpty == true {
            self.init( name )
        }
        else {
#warning("TODO: Config protocol for parameters")
            if typeInfo.parameters.count == 1, typeInfo.parameters.first?.name.caseInsensitiveCompare("T") == .orderedSame {
                self.init( name + "<T: Config>" )
            }
            else {
                self.init( name + "<" + typeInfo.parameters.compactMap({ $0.name }).joined(separator: ",") + ">" )
            }
        }
    }
}
