//
//  TimeLineSwatch.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 9/12/24.
//

import Foundation

@frozen public enum Swatch: UInt8 {
    case x
    case y
    case scale
    case rotation
}

public class TimeLineSwatch {
    
    public func incrementPointCount() {
        if selectedChannelIndex < (channelCount - 1) {
            selectedChannelIndex += 1
            selectedChannel = channels[selectedChannelIndex]
        }
    }
    
    public func decrementPointCount() {
        if selectedChannelIndex > 0 {
            selectedChannelIndex -= 1
            selectedChannel = channels[selectedChannelIndex]
        }
    }
    
    public func getPointCountString() -> String {
        return String(selectedChannelIndex + TimeLine.minimumPointsPerChannel)
    }
    
    public func getChannel(_ channelIndex: Int) -> TimeLineChannel? {
        for ____index in 0..<channelCount {
            let channel = channels[____index]
            if channel.channelIndex == channelIndex {
                return channel
            }
        }
        return nil
    }
    
    public let swatch: Swatch
    public let channels: [TimeLineChannel]
    public let channelCount: Int
    public var selectedChannel: TimeLineChannel
    public var selectedChannelIndex: Int
    public var frameOffset: Float
    public let sentinelChannel = TimeLineChannel(controlPointCount: 16, channelIndex: -1, swatch: .x, defaultType: .curve)
    init(swatch: Swatch,
         defaultType: TimeLineChannel.DefaultType,
         frameOffset: Float) {
        var _channelCount = 0
        var _channels = [TimeLineChannel]()
        var channelIndex = 0
        for controlPointCount in TimeLine.minimumPointsPerChannel...TimeLine.maximumPointsPerChannel {
            let channel = TimeLineChannel(controlPointCount: controlPointCount,
                                          channelIndex: channelIndex,
                                          swatch: swatch,
                                          defaultType: defaultType)
            _channels.append(channel)
            _channelCount += 1
            channelIndex += 1
        }
        self.swatch = swatch
        self.channelCount = _channelCount
        self.channels = _channels
        self.selectedChannel = _channels[0]
        self.frameOffset = frameOffset
        selectedChannelIndex = 0
    }
    
    
}
