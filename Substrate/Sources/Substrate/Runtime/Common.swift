//
//  File.swift
//  
//
//  Created by Steven Boynes on 6/25/22.
//

import Foundation

struct Arithmetic {}
struct Babe {}
struct Collective {}
struct ConsensusBabe {}
struct ElectionsPhragmen {}
//struct Finality {}
//struct FRAME {} --> FRAME.swift
struct FinalityGrandpa {}
struct FrameSupport {}
struct FrameSystem {}
struct Grandpa {}
struct List {}
struct Membership {}
struct Phase {}
struct Phragmen {}
struct PolkadotCorePrimitives {}
struct PolkadotPrimitives {}
struct PolkadotRuntime {}
struct PolkadotRuntimeCommon {}
struct PolkadotRuntimeParachains {}
struct Version {}
struct Xcm {}

/*
struct SpArithmetic {}
struct SpConsensusBabe {}
struct SpCore {}
struct SpFinalityGrandpa {}
struct SpRuntime {}
struct SpVersion {}
*/


//struct Core {}



extension Arithmetic {
    struct FixedPoint {}
    struct PerThings {}
}

extension Babe {
    struct Pallet {}
}

extension Democracy {
    struct Pallet {}
    struct Types {}
}


extension Identity {
    struct Types {}
}

extension List {
    struct List {}
}

extension Phase: SCALEDecodable {
    init(from decoder: SCALE.Decoder) throws { fatalError() }
}

extension Polkadot {
    struct Runtime {}
}

extension PolkadotCorePrimitives {
    struct OutboundHrmpMessage {}
}

extension Xcm {
    struct V0 {}
    struct V1 {}
    struct V2 {}
}

extension Xcm.V0 {
    struct Junction {}
    struct Multiasset {}
    struct MultiAsset {}
    struct Order {}
}

extension Xcm.V1 {
    struct Junction {}
    struct Multiasset {}
    struct MultiAsset {}
    struct Multilocation {}
    struct Order {}
}
