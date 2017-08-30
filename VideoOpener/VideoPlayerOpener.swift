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
        let name : String
        let appId : String
        
        init(appId: String) {
            //todo claim name from appid
            self.name = appId
            self.appId = appId
        }
        
        public static func ==(lhs: Player, rhs: Player) -> Bool {
            return lhs.appId == rhs.appId
        }
    }
    
    var playerList : [Player]
    
    var selectedPlayer : Player?
    
    init() {
        playerList = VideoPlayerOpener.avalibleSystemPlayers
        selectedPlayer = playerList.first
    }

    func request(for url: String, from: String) {
        guard let url = URL(string: url
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!),
            let selectedPlayer = selectedPlayer
            else { print("url is nil"); return }
        AppKit.NSWorkspace.shared().open([url], withAppBundleIdentifier: selectedPlayer.appId,
                                                options: NSWorkspaceLaunchOptions.default,
                                                additionalEventParamDescriptor: nil,
                                                launchIdentifiers: nil)
    }
    
    private static var avalibleSystemPlayers: [Player] {
        let playersIds = LSCopyAllRoleHandlersForContentType("public.movie" as CFString, .all)?.takeRetainedValue() as? [String]
        return playersIds?.map(Player.init(appId:)) ?? []
    }
}
