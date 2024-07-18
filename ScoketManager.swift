//
//  ScoketManager.swift
//  sockt
//
//  Created by Vipin Sharma on 18/07/24.
//

import Foundation
import SocketIO


class SocketHandler: NSObject {
    static var shared = SocketHandler()
    
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    
    
    
    private override init() {
        super.init()
        setupSocket()
    }
    
    
    //MARK: setup socket
    private func setupSocket(){
        let socketURL = URL(string: "https://test-rn-social-sockets.herokuapp.com")!
        manager = SocketManager(socketURL: socketURL, config: [.log(true), .reconnects(true), .reconnectAttempts(5), .reconnectWait(2),.compress])
        socket = manager?.defaultSocket
        addEventHandlers()
    }
    
    
    
    func addEventHandlers(){
        
       // Add common socket handlers
       socket?.on(clientEvent: .connect) {data, ack in
           print("Socket connected")
       }

       
       socket?.on(clientEvent: .disconnect) {data, ack in
           print("Socket disconnected")
       }
       
        
       socket?.on(clientEvent: .reconnect, callback: { _, _ in
           print("socket trying to reconnect...")
       })
        
        
       socket?.on(clientEvent: .error, callback: { data, _ in
            print("soket connection error:: \(data.first)")
       })
        
    }
    
    
    //MARK: Connect
    func connect() {
        socket?.connect()
    }
    
    
    //MARK: Dis Connect
    func disconnect() {
        socket?.disconnect()
    }
    
    
    func isConnected() -> Bool {
        return socket?.status == .connected
    }
    
}
