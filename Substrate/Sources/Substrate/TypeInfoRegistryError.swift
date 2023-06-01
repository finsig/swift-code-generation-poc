//
//  Created by Steven Boynes on 5/14/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo {
    public enum RegistryError: Error {
        case pathNotFound(description: String)
        case unexpected(code: Int)
        //case description(String)
    }
}


extension TypeInfo.RegistryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .pathNotFound(let description):
            return NSLocalizedString("Path not found. \(description)", comment: "Path not found")
        case .unexpected(_):
            return NSLocalizedString("An unexpected error occurred.", comment: "Unexpected error")
        }
    }
}
