//
//  VideoPlayerOpener.swift
//  VideoOpener
//
//  Created by Stas Chmilenko on 02.07.17.
//  Copyright © 2017 Stas Chmilenko. All rights reserved.
//

class VideoPlayerOpener: OpenerHandler {
    var selectedPlayer = Player.QuckTime
    
    func request(for url: String, from: String) {
        print("need to open: \(url)")
        guard let task = selectedPlayer.task(for: url) else { return }
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.sync {
                task.launch()
            }
            task.waitUntilExit()
            print("task finished")
        }
    }
    
    enum Player {
        case VLC
        case QuckTime
        
        var name: String {
            switch self {
            case .QuckTime: return "QuckTime"
            case .VLC:      return "VLC"
            }
        }
        
        var launchPath: String {
            switch self {
            case .QuckTime: return "/usr/bin/osascript"
            case .VLC:      return "/Applications/VLC.app/Contents/MacOS/VLC"
            }
        }
        
        var idAvailible: Bool {
            return FileManager.default.fileExists(atPath: launchPath)
        }

        
        func task(for url: String) -> Process? {
            let valideUrl = url.trimmingCharacters(in: ["\n"])
            let arguments: [String]
            switch self {
            case .VLC: arguments = [valideUrl]
            case .QuckTime:
                guard let path = Bundle.main.path(forResource: "quicktime",ofType:"scpt") else {
                    print("Unable to locate quicktime")
                    return nil
                }
                arguments = [path, valideUrl]
            }
            let task = Process()
            task.launchPath = launchPath
            task.arguments = arguments
            return task
        }
    }
}
