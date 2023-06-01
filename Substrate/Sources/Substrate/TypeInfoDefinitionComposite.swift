//
//  Created by Steven Boynes on 3/3/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Definition {
    ///
    /// Definition for a Composite type.
    ///
    /// - SeeAlso:
    /// - [Substrate Documentation](https://docs.substrate.io/rustdocs/latest/scale_info/struct.TypeDefComposite.html)
    ///
    struct Composite {
        static let key = "composite"
        var fields: Vector<Field>
    }
}


extension TypeInfo.Definition.Composite {
    var isCompositeTypealias: Bool {
        return ((fields.count == 1) && (fields.first?.name == nil))
    }
}

extension TypeInfo.Definition.Composite: Decodable {
    fileprivate typealias Definition = TypeInfo.Definition.Composite
    fileprivate typealias FieldsDictionary = Dictionary<String,Vector<Definition.Field>>
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        guard let dictionary = try? container.decode(Dictionary<String,FieldsDictionary>.self) else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid definition dictionary.")
        }
        guard let fieldsDictionary = dictionary[Definition.key] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid fields dictionary.")
        }
        guard let vector = fieldsDictionary[.fields] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid fields dictionary value.")
        }
        self = .init(fields: vector)
    }
}

fileprivate extension String {
    static let fields = "fields"
}

/*
 
 /** @name Si1TypeDefComposite */
 export interface Si1TypeDefComposite extends Struct {
   readonly fields: Vec<Si1Field>;
 }
 
 Si1Field: {
    name: 'Option<Text>',
    type: 'Si1LookupTypeId',
    typeName: 'Option<Text>',
    docs: 'Vec<Text>'
  }
 
 */
