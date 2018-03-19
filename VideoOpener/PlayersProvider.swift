//
//  PlayersProvider.swift
//  VideoOpener
//
//  Created by Stas Chmilenko on 30.08.17.
//  Copyright © 2017 Stas Chmilenko. All rights reserved.
//

import AppKit

class SystemPlayersProvider {
    private static let pathChecker = PathAvailabilityChecker()
    static let vlc = Player(name: "VLC",
                            availabilityChecker: pathChecker,
                            openUrlHandler: ProcessOpenUrlHandler(launchPath: "/usr/bin/open",
                                                                  defaultArguments: ["-a", "vlc"]))
    static let quickTime = Player(name: "QuickTime Player",
                                  availabilityChecker: pathChecker,
                                  openUrlHandler: ProcessOpenUrlHandler(launchPath: "/usr/bin/open",
                                                                        defaultArguments: ["-a", "quickTime player"]))
    static let iina = Player(name: "IINA",
                             availabilityChecker: pathChecker,
                             openUrlHandler: ProcessOpenUrlHandler(launchPath: "/Applications/IINA.app/Contents/MacOS/IINA",
                                                                   defaultArguments: []))
    static let predefinedPlayers: [Player] = [vlc, quickTime, iina]
    
    static var avalibleSystemPlayers: [Player] {
        return predefinedPlayers.filter { $0.isAvailable }
    }
//    static func findAppName(appId: String) -> String {
//        guard let appPath = NSWorkspace.shared.absolutePathForApplication(withBundleIdentifier: appId)
//            else { return appId }
//        return ((appPath as NSString).lastPathComponent as NSString).deletingPathExtension
//    }

//    static func isAvailible(_ player: Player) -> Bool {
//        return NSWorkspace.shared.fullPath(forApplication: player.name) != nil
//    }
}
