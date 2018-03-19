//
//  Player.swift
//  VideoOpener
//
//  Created by Stas Chmilenko on 19.03.2018.
//  Copyright © 2018 Stas Chmilenko. All rights reserved.
//

protocol AvailabilityChecker {
    func isAvailable(_ player: Player) -> Bool
}

protocol OpenUrlHandler {
    func open(url: URL)
}

struct Player: OpenUrlHandler {
    let name: String
    private let availabilityChecker: AvailabilityChecker
    private let openUrlHandler: OpenUrlHandler
    
    init(name: String, availabilityChecker: AvailabilityChecker, openUrlHandler: OpenUrlHandler) {
        self.name = name
        self.availabilityChecker = availabilityChecker
        self.openUrlHandler = openUrlHandler
    }
    
    var isAvailable: Bool {
        return availabilityChecker.isAvailable(self)
    }
    
    func open(url: URL) {
        openUrlHandler.open(url: url)
    }
}

extension Player: Equatable {
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}
