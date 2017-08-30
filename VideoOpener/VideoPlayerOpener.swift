//
//  VideoPlayerOpener.swift
//  VideoOpener
//
//  Created by Stas Chmilenko on 02.07.17.
//  Copyright © 2017 Stas Chmilenko. All rights reserved.
//
import AppKit

class VideoPlayerOpener: OpenerHandler {
    
    var playerList : [Player]
    
    var selectedPlayer : Player?
    
    init() {
        playerList = ((LSCopyAllRoleHandlersForContentType("public.movie" as CFString, .all)?.takeRetainedValue() as? [String])?.map { Player(appId: $0) })!

        guard (playerList.isEmpty) else { return }
        selectedPlayer = playerList[0]
    }

    
    func request(for url: String, from: String) {

        guard let url = URL(string: url
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!),
            let selectedPlayer = selectedPlayer
            else {
                print("url is nil")
                return
            }

        
        AppKit.NSWorkspace.shared().open([url],
                                         withAppBundleIdentifier: selectedPlayer.appId,
                                         options: NSWorkspaceLaunchOptions.default,
                                         additionalEventParamDescriptor: nil,
                                         launchIdentifiers: nil)
    }
    

    
    class Player {
        let name : String
        let appId : String
        
        
        init(appId: String) {
            //todo claim name from appid
            self.name = appId
            self.appId = appId
        }
    }
}
