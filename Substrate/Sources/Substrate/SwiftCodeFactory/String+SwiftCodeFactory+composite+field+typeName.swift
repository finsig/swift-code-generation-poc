//
//  Created by Steven Boynes on 2/3/23.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension String {
    init(describingTypeName field: TypeInfo.Definition.Composite.Field, registry: TypeInfo.Registry) async throws {
        //
        //
        //  TODO: Fix BagsList.List.Node<T,I> let prev: AccountId>
        //
        // "grandpa::Equivocation<AuthorityId, grandpa::Prevote<H, N>,\nAuthoritySignature>"
        // "grandpa::Equivocation<AuthorityId, grandpa::Prevote<H, N>,AuthoritySignature>"
        //
        // grandpa::Equivocation  <  AuthorityId, grandpa::Prevote<H, N>, AuthoritySignature   >
        // AuthorityId, grandpa::Prevote<H, N>, AuthoritySignature
        //
        
        /*
        {
            "name": "prev",
            "type": 232,
            "typeName": "Option<T::AccountId>",
            "docs": []
        },
         */
        
        guard var typeName = field.typeName else {
            let typeInfo = try registry.typeInfo(for: field.type)!
            self.init( await String(describing: typeInfo, registry: registry) )
            return
        }
        
        typeName = typeName.replacingOccurrences(of: String.newline, with: String.empty)
        typeName = typeName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        /*
        let typeInfo = try registry.typeInfo(for: field.type)!
        let nonGenericParameters = typeInfo.parameters.filter({ $0.type != nil && $0.name.count > 1})
        if nonGenericParameters.isEmpty == false { // if parameters are non-generic
      
            if let subString = String.matches(for: "<(.*)>", in: typeName).first?.dropFirst().dropLast() {
                let commaSeparatedValues = String(subString).split(separator: ",").map({ String($0) })
               
                if commaSeparatedValues.count == nonGenericParameters.count {
                    // all good
                    print("ngp: commaSeparatedValues= \(commaSeparatedValues)")
                }
                else {
                    // need to do more
                    let parameterTypes = nonGenericParameters.map({ $0.type })
                    var parameterCounts = [Int]()
                    for type in parameterTypes {
                        guard let type = type, let typeInfo = try registry.typeInfo(for: type) else {
                            continue
                        }
                        parameterCounts.append(typeInfo.parameters.count)
                        
                    }
                    
                    if typeName.contains("Box") == true {
                        throw SwiftCodeFactoryError(code: 1, message: "Rust Box<T> pointer type.")
                    }
                    if typeName.contains("StaticLookup") == true {
                        throw SwiftCodeFactoryError(code: 2, message: "StaticLookup type.")
                    }
                    
                   
                    print("typeName= \(typeName) commaSeparatedValues= \(commaSeparatedValues) csvCount= \(commaSeparatedValues.count) ngpCount= \( nonGenericParameters.count ) parameterCounts= \(parameterCounts) typeID= \(field.type.value)")
                    
                    let fieldTypeInfo = try registry.typeInfo(for: field.type)!
                    let fieldParameterTypes = fieldTypeInfo.parameters.compactMap({ $0.type?.value })
                    print("ngpCount fieldParameterTypes= \(fieldParameterTypes)")
                   
                }
            }
        }
        */
        /*
        if typeName.contains("Box") == true {
            throw SwiftCodeFactoryError(code: 1, message: "Rust Box<T> pointer type.")
        }
        if typeName.contains("StaticLookup") == true {
            throw SwiftCodeFactoryError(code: 2, message: "StaticLookup type.")
        }
        */
        if typeName.contains(String.pathSeparator) {
            print("ngp: pathSeparator \(typeName)")
            let components = typeName.split(separator: String.pathSeparator)
            if let substring = components.first, String(substring).count == 1, components.count == 2 { // generic
                let typeName = typeName.replacingOccurrences(of: String.pathSeparator, with: ".")
                print("ngp: typeName= \(typeName)")
                self.init( typeName )
                return
            }
        }
        
        // ^Option<.*>$   replace Option<> with 
        
        
        self.init( typeName )
    }
}

fileprivate extension String {
    static func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            return results.map {
                String( text[Range($0.range, in: text)!] )
            }
        }
        catch {
            return []
        }
    }
}
