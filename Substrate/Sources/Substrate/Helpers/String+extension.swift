//
//  Created by Steven Boynes on 3/5/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension String {
    func lowercasingFirstLetter() -> String {
      return prefix(1).lowercased() + self.dropFirst()
    }

    mutating func lowercaseFirstLetter() {
      self = self.lowercasingFirstLetter()
    }
}

extension String {
    func uppercasingFirstLetter() -> String {
      return prefix(1).uppercased() + self.dropFirst()
    }

    mutating func uppercaseFirstLetter() {
      self = self.uppercasingFirstLetter()
    }
}

extension String {
    func removingParameters() -> String {
        return components(separatedBy: "<").first!
    }
    
    mutating func removeParameters() {
        self = self.removingParameters()
    }
}

extension String {
    func replacingUnallowedCharacters() -> String {
        return replacingOccurrences(of: "#", with: "_hashtag_")
    }
    
    mutating func replaceUnallowedCharacters() {
        self = self.replacingUnallowedCharacters()
    }
}

extension String {
    static var empty: String { return "" }
}

extension String {
    static var newline: String { return "\n" }
}

extension String {
    func camelCased(fromSeparator separator: Character) -> String {
        return self
            .split(separator: separator)
            .enumerated()
            .map { $0.offset > 0 ? $0.element.capitalized : String($0.element) }
            .joined()
    }
}
