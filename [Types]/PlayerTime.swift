//
//  PlayerTime.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/23/25.
//

import Foundation

public struct PlayerTime {
    
    static let frameIncrement = Int(2)
    
    public let minutes: Int
    public let seconds: Int
    public let tenths: Int
    public init(timeInterval: TimeInterval) {
        let _minutes = Int(timeInterval / 60.0)
        let _seconds = Int(timeInterval) % 60
        let _tenths = Int(timeInterval * 10.0) % 10
        minutes = _minutes
        seconds = _seconds
        tenths = _tenths
    }
    
    public init(tenths: Int, seconds: Int, minutes: Int) {
        self.tenths = tenths
        self.seconds = seconds
        self.minutes = minutes
    }
    
    public func getMMSST() -> String {
        var _minutes = minutes
        if _minutes < 0 { _minutes = 0 }
        if _minutes > 99 { _minutes = 99 }
        var _seconds = seconds
        if _seconds < 0 { _seconds = 0 }
        if _seconds > 99 { _seconds = 99 }
        var _tenths = tenths
        if _tenths < 0 { _tenths = 0 }
        if _tenths > 9 { _tenths = 9 }
        let minuteString: String
        if _minutes > 9 {
            minuteString = "\(_minutes)"
        } else {
            minuteString = "0\(_minutes)"
        }
        let secondString: String
        if _seconds > 9 {
            secondString = "\(_seconds)"
        } else {
            secondString = "0\(_seconds)"
        }
        let tenthString = "\(_tenths)"
        return "\(minuteString):\(secondString):\(tenthString)"
    }
    
}
