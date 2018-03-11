//
//  PlayersProvider.swift
//  VideoOpener
//
//  Created by Stas Chmilenko on 30.08.17.
//  Copyright © 2017 Stas Chmilenko. All rights reserved.
//

import AppKit

class SystemPlayersProvider {
    private static let predefinedIds = ["com.apple.QuickTimePlayerX", "org.videolan.vlc"]

    static var avalibleSystemPlayers: [VideoPlayerOpener.Player] {
        return predefinedIds.map { VideoPlayerOpener.Player(appId: $0, name: findAppName(appId: $0)) }
    }
    
    static func findAppName(appId: String) -> String {
        guard let appPath = NSWorkspace.shared.absolutePathForApplication(withBundleIdentifier: appId)
            else { return appId }
        return ((appPath as NSString).lastPathComponent as NSString).deletingPathExtension
    }

    static var systemPlayerIds:[String] {
        return LSCopyAllRoleHandlersForContentType("public.movie" as CFString, .all)?
            .takeRetainedValue() as? [String] ?? []
    }
    
}
