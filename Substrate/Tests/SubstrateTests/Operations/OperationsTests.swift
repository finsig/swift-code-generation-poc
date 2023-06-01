//
//  Created by Steven Boynes on 5/16/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class OperationTests: XCTestCase {
    
    //private var typeInfo: TypeInfo!
    //private var registry: TypeInfo.Registry!
    //private var factory: SwiftCodeFactory!
    
    override func setUp() async throws {
        //typeInfo = try JSONDecoder().decode(TypeInfo.self, from: .typeInfo)
        //registry = TypeInfo.Registry(json: .registry)
        //factory = SwiftCodeFactory(registry: registry)
    }
    
    func testOperation() async throws {
        //let url = Bundle.module.url(forResource: "portable-type-definitions", withExtension: "json")!
        //let url = Bundle.module.url(forResource: "polkadot-pallet-constant-type-info", withExtension: "json")!
        //let operation = await AuditSwiftCodeFactoryOutputOperation(url: url)
        //let operation = await AuditSwiftCodeFactoryOutputOperation(url: .registry)
        let operation = await WriteSwiftTypeInfoOperation(url: Substrate.runtime.typeInfoURL, fileManager: .default)
        OperationQueue().addOperations([operation], waitUntilFinished: true)
        
        /*
        let operation2 = await WriteSwiftPalletsOperation(metadata: Substrate.runtime.metadataURL, registry: Substrate.runtime.typeInfoURL, fileManager: .default)
        OperationQueue().addOperations([operation2], waitUntilFinished: true)
        */
        
        let operation3 = await WriteSwiftTypeInfoOperation(url: Polkadot().typeInfoURL, fileManager: .default)
        OperationQueue().addOperations([operation3], waitUntilFinished: true)
        
        let operation4 = await WriteSwiftPalletsOperation(metadata: Polkadot().metadataURL, registry: Substrate.runtime.typeInfoURL, fileManager: .default)
        OperationQueue().addOperations([operation4], waitUntilFinished: true)
    }
}
