//
//  Created by Steven Boynes on 2/28/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

///  A struct representing Substrate type information.
///
struct TypeInfo {
    let path: Path
    let parameters: Vector<Parameter>
    let definition: Definition
    let docs: Vector<Text>
}


extension TypeInfo: PortableFormRepresentable {}

extension TypeInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case parameters = "params"
        case definition = "def"
        case docs = "docs"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        path = try container.decode(Path.self, forKey: .path)
        parameters = try container.decode(Vector<Parameter>.self, forKey: .parameters)
        definition = try container.decode(Definition.self, forKey: .definition)
        docs = try container.decode(Vector<Text>.self, forKey: .docs)
    }
}
