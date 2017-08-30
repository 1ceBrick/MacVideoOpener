//
//  ViewController.swift
//  VideoOpener
//
//  Created by Stas Chmilenko on 01.07.17.
//  Copyright © 2017 Stas Chmilenko. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    let appName = "Opener"

    @IBOutlet weak var appMnenu: NSMenu!
    var statusItem: NSStatusItem!
    
    @IBOutlet weak var currentIpMenuItem: NSMenuItem!
    @IBOutlet weak var startServerMenuItem: NSMenuItem!
<<<<<<< HEAD
    @IBOutlet weak var playerListMenu: NSMenu!
    
=======
    @IBOutlet weak var quickTimeMenuItem: NSMenuItem!
    @IBOutlet weak var vlcMenuItem: NSMenuItem!
>>>>>>> working version
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func awakeFromNib() {
        initStatusItem()
        initPlayerList()
        iniCurrentIp()
        updateMenuItemsforSelectedPlayer()
        serverIsOn = true
    }
    
    func initStatusItem() {
        statusItem = NSStatusBar.system()
            .statusItem(withLength: NSVariableStatusItemLength)
        statusItem.highlightMode = true
        statusItem.menu = appMnenu
        
<<<<<<< HEAD
        statusItem.image = NSImage(imageLiteralResourceName: "NSSlideshowTemplate")
        statusItem.image?.isTemplate = true
//        statusItem.title = appName
    }
    
    func initPlayerList() {
        videoOpener.playerList.map {
            let item = NSMenuItem()
            item.title = $0.name
            return item
        }.forEach {
            playerListMenu.addItem($0)
        }
=======
        statusItem.title = appName
        statusItem.image = NSImage(imageLiteralResourceName: "NSSlideshowTemplate")
        statusItem.image?.isTemplate = true
        statusItem.title = appName
    }
    
    func initPlayerList() {
        vlcMenuItem.isEnabled = VideoPlayerOpener.Player.VLC.idAvailible
        quickTimeMenuItem.isEnabled = VideoPlayerOpener.Player.QuckTime.idAvailible
>>>>>>> working version
    }
    
    func iniCurrentIp() {
        let currentIp = IPAddres.localIPAddress().first ?? ""
        currentIpMenuItem.title = currentIp
    }
    
    @IBAction func startMenuItemClick(_ sender: Any) {
        serverIsOn = !serverIsOn
    }
    
    @IBAction func quit(_ sender: Any) {
        server.stop()
        NSApplication.shared().terminate(self)
    }
    
    @IBAction func playerSelected(_ sender: NSMenuItem) {
        switch sender {
<<<<<<< HEAD
=======
        case vlcMenuItem: videoOpener.selectedPlayer = .VLC
        case quickTimeMenuItem: videoOpener.selectedPlayer = .QuckTime
>>>>>>> working version
        default: break
        }
        updateMenuItemsforSelectedPlayer()
    }
    
    func updateMenuItemsforSelectedPlayer() {
<<<<<<< HEAD
=======
        quickTimeMenuItem.state = videoOpener.selectedPlayer == .QuckTime ? NSOnState : NSOffState
        vlcMenuItem.state = videoOpener.selectedPlayer == .VLC ? NSOnState : NSOffState
>>>>>>> working version
    }
    
    var serverIsOn = false {
        didSet {
            startServerMenuItem.title = serverIsOn ? "Stop Server" : "Start Server"
            let statusIconName = serverIsOn ? "NSStatusUnavailable" : "NSStatusAvailable"
            startServerMenuItem.image = NSImage(imageLiteralResourceName: statusIconName)
            if serverIsOn {
                server.start()
            } else {
                server.stop()
            }
        }
    }
    
    lazy var videoOpener = VideoPlayerOpener()
    lazy var server: OpenerServer = OpenerServer(port: 4000, handler: self.videoOpener)

}
