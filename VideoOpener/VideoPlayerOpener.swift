//
//  VideoPlayerOpener.swift
//  VideoOpener
//
//  Created by Stas Chmilenko on 02.07.17.
//  Copyright © 2017 Stas Chmilenko. All rights reserved.
//
import AppKit

class VideoPlayerOpener: OpenerHandler {
    struct Player: Equatable {
        let appId : String
        let name : String
        public static func ==(lhs: Player, rhs: Player) -> Bool {
            return lhs.appId == rhs.appId
        }
    }
    
    var playerList : [Player]
    
    var selectedPlayer : Player?
    
    init(players: [Player]) {
        playerList = players
        selectedPlayer = playerList.first
    }

    func request(for url: String, from: String) {
        guard let safeUrl = url
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
            let url = URL(string: safeUrl),
            let selectedPlayer = selectedPlayer
            else { print("url is nil"); return }
        NSWorkspace.shared().open([url], withAppBundleIdentifier: selectedPlayer.appId,
                                         options: NSWorkspaceLaunchOptions.default,
                                         additionalEventParamDescriptor: nil,
                                         launchIdentifiers: nil)
    }
}
