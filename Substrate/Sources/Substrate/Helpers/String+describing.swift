//
//  Created by Steven Boynes on 5/10/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension String {
    init(describingType type: Any.Type) {

        var string = String(describing: type)
        string = string.replacingOccurrences(of: "UInt8", with: "U8")
        string = string.replacingOccurrences(of: "UInt16", with: "U16")
        string = string.replacingOccurrences(of: "UInt32", with: "U32")
        string = string.replacingOccurrences(of: "UInt64", with: "U64")
        string = string.replacingOccurrences(of: "SUInt128", with: "U128")
        
        if string.contains("ElementArray") == false {
            string = string.replacingOccurrences(of: "Array", with: "Vec")
        }
        self.init(string)
    }
}

// Array
extension String {
    init(describing array: TypeInfo.Definition.Array) {
        self.init("\(String(count: Int(array.length)) )ElementArray")
    }
}

// Pallet
extension String {
    init(describing pallet: Metadata.Pallet) {
        if pallet.name.caseInsensitiveCompare("BABE") == .orderedSame {
            self.init("BABE")
        }
        else if pallet.name.caseInsensitiveCompare("GRANDPA") == .orderedSame {
            self.init("GRANDPA")
        }
        else {
            self.init(pallet.name)
        }
    }
}

// TypeInfo

extension String {
    ///  Construct a lossless, unambiguous, name string for a Portable Type.
    ///
    init(describing typeInfo: TypeInfo, separator: String = ".") {
        let name = SwiftCode.Path(typeInfo.path).joined(separator: separator)
        if typeInfo.isGenericType {
            self.init(name + "<" + typeInfo.parameters.map({ $0.name.uppercasingFirstLetter() }).joined(separator: ",") + ">")
        }
        else {
            self.init(name)
        }
    }
}


extension TypeInfo {
    var isGenericType: Bool {
        return (parameters.filter({ $0.type != nil }).count > .zero)
    }
}

// Composite Field

extension String {
    init(describing field: TypeInfo.Definition.Composite.Field, registry: TypeInfo.Registry) async throws {
        
        if let typeName = field.typeName, typeName.contains("pallet_") {
            print("string describing pallet= \(field.typeName)")
        }
        
        #warning("field type name")
        if let typeName = field.typeName, typeName.contains("::") {
            print("here field.typeName= \(field.typeName)")
        }
        
        if let typeName = field.typeName, typeName.contains("polkadot_") {
            print("string describing polkadot extension= \(field.typeName)")
        }
        
        guard let typeName = field.typeName?.uppercasingFirstLetter() else {
            guard let typeInfo = try registry.typeInfo(for: field.type) else {
                fatalError("\(field)")
            }
            let typeName = await String(describing: typeInfo, registry: registry)
            print("here typeName= \(typeName)")
            self.init(typeName)
            return
        }
        let components = typeName.split(separator: "<")
        
        if let first = components.first {
            let genericTypeName = String(first)
            print("genericTypeName= \(genericTypeName)")
            
            guard let typeInfo = try registry.typeInfo(for: field.type) else {
                fatalError("\(field.type) field=\(field) registry.count=\(registry.entries.count)")
            }
            let registryTypeName = await String(describing: typeInfo, registry: registry)
            
            print("registryTypeName= \(registryTypeName) typeInfo= \(typeInfo)")
            
            if registryTypeName.caseInsensitiveCompare( genericTypeName ) != .orderedSame {
                if let last = components.last, String(last).caseInsensitiveCompare( genericTypeName ) != .orderedSame {
                    let parameterNames = try await String.genericFieldParameterNames(for: field, registry: registry)

                    if parameterNames.isEmpty {
                        self.init("\(registryTypeName)")
                    }
                    else {
                        self.init("\(registryTypeName)<\(parameterNames)>")
                    }
                    return
                }
            }
        }
        
        let typeInfo = try registry.typeInfo(for: field.type)
        if typeInfo?.isTupleType == true, var tupleName = field.typeName {
            let tuple = try registry.typeInfo(for: field.type)
            switch tuple?.definition {
            case .tuple(let tuple):
                if tuple.typeIdentifiers.count > 1 {
                    if typeName.hasPrefix("(") && typeName.hasSuffix(")") {
                        tupleName = String(tupleName.dropFirst())
                        tupleName = String(tupleName.dropLast())
                    }
                    let typeNames = tupleName.components(separatedBy: ",").map({ $0.trimmingCharacters(in: .whitespaces).uppercasingFirstLetter() })
                
                    let typeName = String(count: typeNames.count) + "ElementTuple<\(typeNames.joined(separator: ","))>"
                    self.init(typeName)
                    return
                }
            default:
                break
            }
        }
        if typeInfo?.isFixedCapacityArray == true {
            let array = try registry.typeInfo(for: field.type)
            switch array?.definition {
            case .array(let array):
                let type = try registry.typeInfo(for: array.type)
                
                let parameterName: String
                if Mirror(reflecting: type as Any).displayStyle == .optional, let type = type {
                    parameterName = "\(await String(describing: type, registry: registry))?"
                }
                else {
                    parameterName = String(describing: type)
                }
                let typeName = String(describing: array) + "<\(parameterName)>"
                self.init(typeName)
                return
            default:
                break
            }
        }
        
        self.init(typeName)
    }
}


extension TypeInfo {
    var isTupleType: Bool {
        switch definition {
        case .tuple(_):
            return true
        default:
            return false
        }
    }
    
    var isFixedCapacityArray: Bool {
        switch definition {
        case .array(_):
            return true
        default:
            return false
        }
    }
}


fileprivate extension String {
    static func genericFieldParameterNames(for field: TypeInfo.Definition.Composite.Field, registry: TypeInfo.Registry) async throws -> String {
        let typeInfo = try registry.typeInfo(for: field.type)
        guard let parameters = typeInfo?.parameters else {
            return String.empty
        }
        var names = [String]()
        for parameter in parameters {
            guard let type = parameter.type, let typeInfo = try registry.typeInfo(for: type) else {
                continue
            }
            names.append( await String(describing: typeInfo, registry: registry) )
        }
        return names.joined(separator: ",")
    }
}


extension String {
    init(describing typeInfo: TypeInfo, registry: TypeInfo.Registry) async {
        var string: String?
        switch typeInfo.definition {
        case .array(let array):
            let typeInfo = try! registry.typeInfo(for: array.type)
            let typeName = await String(describing: typeInfo!, registry: registry)
            let capacityName = String(describing: array)
            string = capacityName + "<" + typeName + ">"
        
        case .bitSequence(_):
            string = "BitVector"
            
        case .composite(let composite):
            string = String(describingComposite: composite, typeInfo: typeInfo)
        case .primitive(let primitive):
            string = primitive.name.rawValue
            
        case .sequence(let sequence):
            let typeInfo = try! registry.typeInfo(for: sequence.type)
            string = "[\(await String(describing: typeInfo!, registry: registry))]"
        case .tuple(let tuple):
            var typeNames = [String]()
            for identifier in tuple.typeIdentifiers {
                let typeInfo = try! registry.typeInfo(for: identifier)
                let typeName = await String(describing: typeInfo!, registry: registry)
                typeNames.append(typeName)
            }
            string = String(count: typeNames.count) + "ElementTuple<\(typeNames.joined(separator: ","))>"
        case .variant(let variant):
            if variant.isOptionEnum {
                string = "Option"
            }
            else {
                guard let name = typeInfo.path.last?.uppercasingFirstLetter() else {
                    fatalError()
                }
                if typeInfo.parameters.isEmpty == true {
                    string = name
                }
                else {
#warning("TODO: Config protocol for parameters")
                    if typeInfo.parameters.count == 1, typeInfo.parameters.first?.name.caseInsensitiveCompare("T") == .orderedSame {
                        string = name + "<T: Config>"
                    }
                    else {
                        string = name + "<" + typeInfo.parameters.compactMap({ $0.name }).joined(separator: ",") + ">"
                    }
                }
            }
        case .compact(_):
            string = "Compact"

        }
        guard let string = string else {
            fatalError("\(String(describing: string))")
        }
        self.init(string)
    }
}

extension Authorship {
    typealias BlockNumber = Int
}

extension Authorship {
    enum UncleEntryItem<BlockNumber,Hash,Author> {
        case inclusionHeight(BlockNumber)
        case uncle(Hash,Option<Author>)
    }
}


fileprivate extension String {
    init(count index: Int) {
        guard let strings = try? JSONDecoder().decode([String].self, from: Data(contentsOf: .numberStrings)), strings.indices.contains(index) else {
            fatalError("\(index) not found.")
        }
        self.init(strings[index])
    }
}




// TODO: check for :: - containsPathQualifier
extension SwiftCodeFactory {
    func typeName(field: TypeInfo.Definition.Composite.Field, typeInfo: TypeInfo) -> Void {

        if let typeName = field.typeName, typeName.contains(String.rustNamespaceQualifier) {
            
            let segments = typeName.replacingOccurrences(of: String.rustNamespaceQualifier, with: String.separator).split(separator: .separator)
            let strings: [String] = segments.map({
                /*
                if $0.contains("pallet_"), let name = $0.split(separator: "_").last {
                    return String(name).uppercasingFirstLetter()
                }
                else if $0.contains("frame_"), let name = $0.split(separator: "_").last {
                    return String(name).uppercasingFirstLetter()
                }
                else {
                    return String($0)
                }
                 */
                if $0.contains("pallet_") {
                    
                    var components = $0.split(separator: "_")
                    components.removeFirst(1)
                    let name = components.map({ String($0).uppercasingFirstLetter() }).joined()
                    return String(name)
                }
                else if $0.contains("frame_"), let name = $0.split(separator: "_").last {
                    return String(name).uppercasingFirstLetter()
                }
                else {
                    return String($0)
                }
            })
            
            print("strings= \(strings)")
            /*
            var paths = [String]()
            
            if let firstSegment = segments.first, firstSegment.contains("pallet_") {
                if let name = firstSegment.split(separator: "_").last {
                    paths.append( String(name).uppercasingFirstLetter() )
                }
               
            }
        
            
            for segment in typeName.replacingOccurrences(of: String.rustNamespaceQualifier, with: String.separator).split(separator: .separator) {
                print("segment= \(segment)")
                
                let name = String(segment).camelCased(fromSeparator: "_").replacingUnallowedCharacters().uppercasingFirstLetter()
            }
             */
        }
    }
    
    func namespaceStruct() {
        
    }
}

fileprivate extension String {
    static let rustNamespaceQualifier = "::"
    static let separator = "|"
}

fileprivate extension Character {
    static let separator = Character(String.separator)
}

extension String {
    init(describingPallet path: TypeInfo.Path) {
        if let segment = path.first, segment.contains("pallet_"), let name = segment.split(separator: "_").last {
            self.init(name)
        }
        else {
            fatalError()
        }
    }
}

extension String {
    init(describingFRAME path: TypeInfo.Path) {
        if let segment = path.first, segment.contains("frame_"), let name = segment.split(separator: "_").last {
            let string = "FRAME." + String(name).uppercasingFirstLetter()
            self.init(string)
        }
        else {
            fatalError()
        }
    }
}

extension String {
    init(describingFinality path: TypeInfo.Path) {
        if let segment = path.first, segment.contains("finality_grandpa"), let name = segment.split(separator: "_").last {
            let string = "Finality." + String(name).uppercased()
            self.init(string)
        }
        else {
            fatalError()
        }
    }
}

