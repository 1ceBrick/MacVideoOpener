//
//  OpenerServer.swift
//  VideoOpener
//
//  Created by Stas Chmilenko on 02.07.17.
//  Copyright © 2017 Stas Chmilenko. All rights reserved.
//

import Foundation
import SwiftSocket

class OpenerServer: ConnectionServer {
    private static let readSize = 1024*10
    
    private var server: TCPServer?
    private var isRunning = false
    
    let port: Int32
    weak var handler: OpenerHandler?
    
    init(port: Int, handler: OpenerHandler? = nil) {
        self.port = Int32(port)
        self.handler = handler
    }
    
    func start() {
        guard !isRunning else {
            print("server already running")
            return
        }
        DispatchQueue.global(qos: .background).async { [unowned self] in
            self.runServer()
        }
    }
    
    func stop() {
        self.isRunning = false
        server?.close()
    }
    
    private func runServer() {
        let localIp = IPAddres.localIPAddress().first ?? ""
        let server = TCPServer(address: localIp, port: port)
        self.server = server
        isRunning = true
        switch server.listen() {
        case .success:
            while isRunning {
                accept(client: server.accept())
            }
        case .failure(let error):
            isRunning = false
            print("Server error: \(error)")
        }
    }
    
    private func accept(client: TCPClient?) {
        guard let client = client else {
            print("No client to accept")
            return
        }
        print("Newclient from:\(client.address)[\(client.port)]")
        DispatchQueue.global(qos: .background).async { [unowned self] in
            self.handle(client: client)
            client.close()
        }
    }
    
    private func handle(client: TCPClient) {
        guard let data = client.read(OpenerServer.readSize) else { return }
        if let response = String(bytes: data, encoding: .utf8) {
            handler?.request(for: response, from: "\(client.address)[\(client.port)]")
        } else {
            print("parsong data error")
        }

    }
}
