//
//  Created by Steven Boynes on 5/15/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/// An Operation to verify that Swift Code files exist for provided metadata type information.
///
///
class AuditSwiftCodeFactoryOutputOperation: Operation {
    
    private var registry: TypeInfo.Registry
    
    override init() {
        fatalError("TypeInfo URL required.")
    }
    
    init(url: URL) async {
        registry = await TypeInfo.Registry(url: url)
    }
    
    override func main() {
        for entry in registry.entries {
            if let type = try? SwiftCode.type(for: entry.typeInfo, registry: registry) {
                print("type= \(type)")
            }
            else {
                print("type= NOT FOUND identifier= \(entry.identifier)")
            }
        }
    }
}

fileprivate extension SwiftCode {
    
    static func type(for typeInfo: TypeInfo, registry: TypeInfo.Registry) throws -> Any.Type? {
        switch typeInfo.definition {
        case .primitive(let primitive):
            return Substrate.type(of: primitive)
        case .array(_):
            return try arrayType(typeInfo: typeInfo, registry: registry)
        case .composite(_):
            return try compositeType(typeInfo: typeInfo, registry: registry)
        case .sequence(_):
            return try sequenceType(typeInfo: typeInfo, registry: registry)
        case .variant(_):
            return try variantType(typeInfo: typeInfo, registry: registry)
        default:
            return nil
        }
    }
}

fileprivate extension SwiftCode {
    static func arrayType(typeInfo: TypeInfo, registry: TypeInfo.Registry) throws -> Any.Type? {
        switch typeInfo.definition {
        case .array(let array):
            guard let typeInfo = try registry.typeInfo(for: array.type) else {
                return nil
            }
            guard let type = try? SwiftCode.type(for: typeInfo, registry: registry) else {
                return nil
            }
            if (array.length == 8) && String(describingType: type).caseInsensitiveCompare("U8") == .orderedSame {
                return EightElementArray<U8>.self
            }
            return nil
        default:
            return nil
        }
    }
}

fileprivate extension SwiftCode {
    static func compositeType(typeInfo: TypeInfo, registry: TypeInfo.Registry) throws -> Any.Type? {
        switch typeInfo.definition {
        case .composite(let composite):
            if let field = composite.fields.last, composite.fields.count == 1 && field.name == nil {
                guard let typeInfo = try registry.typeInfo(for: field.type) else {
                    return nil
                }
                return try? SwiftCode.type(for: typeInfo, registry: registry)
            }
            else {
                return try SwiftCode.type(for: typeInfo.path, parameters: typeInfo.parameters, registry: registry)
            }
        default:
            return nil
        }
    }
}

fileprivate extension SwiftCode {
    static func sequenceType(typeInfo: TypeInfo, registry: TypeInfo.Registry) throws -> Any.Type? {
        switch typeInfo.definition {
        case .sequence(let sequence):
            guard let typeInfo = try registry.typeInfo(for: sequence.type) else {
                return nil
            }
            guard let type = try? type(for: typeInfo, registry: registry) else {
                return nil
            }
            if type is U8.Type {
                return Vector<U8>.self
            }
            if type is U64.Type {
                return Vector<U64>.self
            }
            /*
            if type is FrameSupportWeightsWeightToFeeCoefficient<U128>.Type {
                return Vector<FrameSupportWeightsWeightToFeeCoefficient<U128>>.self
            }
             */
            return nil

        default:
            return nil
        }
    }
}

fileprivate extension SwiftCode {
    static func variantType(typeInfo: TypeInfo, registry: TypeInfo.Registry) throws -> Any.Type? {
        switch typeInfo.definition {
        case .variant(let variant):
            if variant.isOptionEnum == true {
                guard let value = variant.variants.filter({ $0.name.caseInsensitiveCompare("some") == .orderedSame }).last else {
                    return nil
                }
                guard let field = value.fields.first else {
                    return nil
                }
                guard let typeInfo = try registry.typeInfo(for: field.type) else {
                    return nil
                }
                switch typeInfo.definition {
                case .primitive(let primitive):
                    switch primitive.name {
                    case .u128:
                        return Optional<U128>.self
                    case .u64:
                        return Optional<U64>.self
                    default:
                        return nil
                    }
                default:
                    return nil
                }
            }
        default:
            return nil
        }
        return nil
    }
}

extension SwiftCode {
    static func type(for path: TypeInfo.Path, parameters: [TypeInfo.Parameter], registry: TypeInfo.Registry) throws -> Any.Type? {
        /*
        if path == .palletContractsScheduleLimits {
            return PalletContractsScheduleLimits.self
        }
        if path == .palletContractsScheduleSchedule {
            return PalletContractsScheduleSchedule.self
        }
        if path == .palletContractsScheduleInstructionWeights {
            return PalletContractsScheduleInstructionWeights.self
        }
        if path == .palletContractsScheduleHostFnWeights {
            return PalletContractsScheduleHostFnWeights.self
        }
        
        if path == .frameSupportWeightsRuntimeDbWeight {
            return FrameSupportWeightsRuntimeDbWeight.self
        }
    
        if path == .frameSystemLimitsWeightsPerClass {
            return FrameSystemLimitsWeightsPerClass.self
        }
        
        if path == .frameSupportWeightsPerDispatchClass {
            for identifier in parameters.compactMap({ $0.type }) {
                if let typeInfo = try registry.typeInfo(for: identifier) {
                    guard let type = try SwiftCode.type(for: typeInfo, registry: registry) else {
                        return nil
                    }
                    if type is FrameSystemLimitsWeightsPerClass.Type {
                        return FrameSupportWeightsPerDispatchClass<FrameSystemLimitsWeightsPerClass>.self
                    }
                    if type is U32.Type {
                        return FrameSupportWeightsPerDispatchClass<U32>.self
                    }
                }
            }
        }
        
        if path == .frameSupportWeightsWeightToFeeCoefficient {
            for identifier in parameters.compactMap({ $0.type }) {
                if let typeInfo = try registry.typeInfo(for: identifier) {
                    if try SwiftCode.type(for: typeInfo, registry: registry) is U128.Type {
                        return FrameSupportWeightsWeightToFeeCoefficient<U128>.self
                    }
                }
            }
        }
    
        if path == .frameSystemLimitsBlockLength {
            return FrameSystemLimitsBlockLength.self
        }
     
        if path == .frameSystemLimitsBlockWeights {
            return FrameSystemLimitsBlockWeights.self
        }
        
        /*
        if path == .spArithmeticPerThingsPerbill {
            return Perbill.self
        }
        if path == .spArithmeticPerThingsPermill {
            return Permill.self
        }
        if path == .spArithmeticPerThingsPercent {
            return Percent.self
        }
        */
        if path == .spVersionRuntimeVersion {
            return SpVersionRuntimeVersion.self
        }
         */
        return nil
    }
}
