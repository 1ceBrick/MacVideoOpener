//
//  PathAvailabilityChecker.swift
//  VideoOpener
//
//  Created by Stas Chmilenko on 19.03.2018.
//  Copyright © 2018 Stas Chmilenko. All rights reserved.
//

import AppKit

struct PathAvailabilityChecker: AvailabilityChecker {
    func isAvailable(_ player: Player) -> Bool {
        return NSWorkspace.shared.fullPath(forApplication: player.name) != nil
    }
}
