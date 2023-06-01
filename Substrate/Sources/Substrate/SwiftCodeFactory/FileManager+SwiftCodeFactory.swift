//
//  Created by Steven Boynes on 5/1/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension FileManager {
    
    var documentDirectory: URL {
        let paths = urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func write(output: SwiftCodeFactory.Output) throws {
        try write(outputs: [output])
    }
    
    func write(outputs: SwiftCodeFactory.Outputs) throws {
        for output in outputs {
            guard let directory = output.path?.rawValue else {
                continue
            }
            let url = documentDirectory.appendingPathComponent("Output/\(directory)", isDirectory: true)
            try createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            try write(code: output.code, directory: url)
        }
    }
    
    fileprivate func write(code: SwiftCode.Block, directory: URL) throws {
        let file = directory.appendingPathComponent("\(code.name).swift")
        var lines = Header(date: .now)
        lines.append(.foundationImport)
        lines.append(contentsOf: code.lines)
        try lines.joined(separator: "\n").write(to: file, atomically: true, encoding: String.Encoding.utf8)
    }
}

fileprivate typealias Header = SwiftCode.Lines

fileprivate extension Header {
    init(date: Date) {
        var code = ["//"]
        code.append("//  Created by Swift Code Factory \(date)")
        code.append("//  Copyright © 2023 Finsig LLC. All rights reserved.")
        code.append("//")
        self.init(array: code)
    }
}

fileprivate extension SwiftCode.Line {
    static var foundationImport: SwiftCode.Line {
        return "import Foundation"
    }
}
