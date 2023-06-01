//
//  Created by Steven Boynes on 3/11/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo {
    ///
    ///  A registry of Substrate type information.
    ///
    class Registry {
        var entries: [Entry]
        
        init(json: Data) {
            entries = [Entry]()
            do {
                self.entries = try JSONDecoder().decode([Entry].self, from: json)
            }
            catch{
                logger.fault("Failed to initialize registry from JSON data: \(error.localizedDescription)")
            }
        }
        
        public func typeInfo(for identifier: Entry.Identifier) throws -> TypeInfo? {
            return entries.filter({
                $0.identifier == identifier
            }).last?.typeInfo
        }
        
        public func path(for identifier: Entry.Identifier) throws -> Path {
            return try typeInfo(for: identifier)?.path ?? Path()
        }
    }
}

extension TypeInfo.Registry {
    convenience init(url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.init(json: data)
        }
        catch{
            fatalError("Failed to initialize registry from url: \(error.localizedDescription)")
        }
    }
}
