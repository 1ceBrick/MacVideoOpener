//
//  OpenerPrococols.swift
//  VideoOpener
//
//  Created by Stas Chmilenko on 12.11.2017.
//  Copyright © 2017 Stas Chmilenko. All rights reserved.
//

import Foundation

protocol OpenerHandler: class {
    func request(for url: String, from: String)
}

protocol ConnectionServer {
    func start()
    func stop()
}
