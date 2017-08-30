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
    @IBOutlet weak var playerListMenu: NSMenu!
    
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
        default: break
        }
        updateMenuItemsforSelectedPlayer()
    }
    
    func updateMenuItemsforSelectedPlayer() {
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
