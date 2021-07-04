//
//  SocketManager.swift
//  AirProximity
//
//  Created by Shaunak Jagtap on 05/07/21.
//

import Foundation

protocol AQDelegate: AnyObject {
    func didUpdateData(serverData: AirQuality)
}

final class SocketManager: WebSocketConnectionDelegate {
    static let shared = SocketManager()
    static weak var delegate:AQDelegate?
    private init(){}
    
    func onConnected(connection: WebSocketConnection) {
        print("Connected")
    }
    
    func onDisconnected(connection: WebSocketConnection, error: Error?) {
        if let error = error {
            print("Disconnected with error:\(error)")
        } else {
            print("Disconnected normally")
        }
    }
    
    func onError(connection: WebSocketConnection, error: Error) {
        print("Connection error:\(error)")
    }
    
    func onMessage(connection: WebSocketConnection, text: String) {
        if let airQualityData = try? AirQuality(text) {
            SocketManager.delegate?.didUpdateData(serverData: airQualityData)
        }
    }
    
    func onMessage(connection: WebSocketConnection, data: Data) {
        print("Data message: \(data)")
    }
    
    var webSocketConnection: WebSocketConnection!
    
    func connect() {
        webSocketConnection = WebSocketTaskConnection(url: URL(string: "ws://city-ws.herokuapp.com/")!)
        webSocketConnection.delegate = self
        webSocketConnection.connect()
    }
}
