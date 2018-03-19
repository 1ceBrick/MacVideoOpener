//
//  ProcessOpenUrlHandler.swift
//  VideoOpener
//
//  Created by Stas Chmilenko on 19.03.2018.
//  Copyright © 2018 Stas Chmilenko. All rights reserved.
//

import Foundation

struct ProcessOpenUrlHandler: OpenUrlHandler {
    let launchPath: String
    let defaultArguments: [String]
    func open(url: URL) {
        let process = Process()
        process.launchPath = launchPath
        process.arguments = defaultArguments + [url.absoluteString]
        process.launch()
    }
}
