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
    
    var selectedPlayer : Player
    
    init(players: [Player]) {
        playerList = players
        guard let firstPlayer = playerList.first else {
            fatalError("no player provided to VideoPlayerOpener")
        }
        selectedPlayer = firstPlayer
    }

    func request(for url: String, from: String) {
        guard let safeUrl = prepareUrl(from: url),
            let streamUrl = URL(string: safeUrl)
            else { print("url is nil"); return }
        selectedPlayer.open(url: streamUrl)
    }
    
    private func prepareUrl(from urlString:String) -> String? {
        return urlString.trimmingCharacters(in: .whitespacesAndNewlines)
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
