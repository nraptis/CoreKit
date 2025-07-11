//
//  TimeLine.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 9/12/24.
//

import Foundation

public class TimeLine {
    
    public func getPointCountString(swatch: Swatch) -> String {
        getSelectedSwatch(swatch: swatch).getPointCountString()
    }
    
    public func getSelectedSwatch(swatch: Swatch) -> TimeLineSwatch {
        switch swatch {
        case .x:
            return swatchPositionX
        case .y:
            return swatchPositionY
        case .scale:
            return swatchScale
        case .rotation:
            return swatchRotation
        }
    }
    
    public static let minimumPointsPerChannel = 3
    public static let maximumPointsPerChannel = 5
    
    static let scale = Float(2048.0)
    
    var frameWidth = Float(0.0)
    var frameHeight = Float(0.0)
    
    var paddingH = Float(16.0)
    var paddingV = Float(8.0)
    
    public var minX = Float(0.0)
    public var maxX = Float(0.0)
    public var minY = Float(0.0)
    public var maxY = Float(0.0)
    public var rangeX = Float(0.0)
    public var rangeY = Float(0.0)
    
    public var animationDuration = AnimationConstants_Loop.duration.user_default
    
    public let swatchPositionX = TimeLineSwatch(swatch: .x,
                                                defaultType: .flat,
                                                frameOffset: AnimationConstants_Loop.frameOffset.user_quarter,
                                                isMirrorFlipChannel: true)
    public let swatchPositionY = TimeLineSwatch(swatch: .y,
                                                defaultType: .curve,
                                                frameOffset: AnimationConstants_Loop.frameOffset.user_lo,
                                                isMirrorFlipChannel: false)
    public let swatchScale = TimeLineSwatch(swatch: .scale,
                                            defaultType: .flat,
                                            frameOffset: AnimationConstants_Loop.frameOffset.user_lo,
                                            isMirrorFlipChannel: false)
    public let swatchRotation = TimeLineSwatch(swatch: .rotation,
                                               defaultType: .flat,
                                               frameOffset: AnimationConstants_Loop.frameOffset.user_lo,
                                               isMirrorFlipChannel: true)
    
    public func getSwatch(swatch: Swatch) -> TimeLineSwatch {
        switch swatch {
        case .x: return swatchPositionX
        case .y: return swatchPositionY
        case .scale: return swatchScale
        case .rotation: return swatchRotation
        }
    }
    
    init() {
        
    }
    
    public func refreshFrame(timeLineFrame: TimeLineFrame) {
        let minX = timeLineFrame.paddingH
        let maxX = timeLineFrame.width - timeLineFrame.paddingH
        let minY = timeLineFrame.paddingV
        let maxY = timeLineFrame.height - timeLineFrame.paddingV
        let rangeX = (maxX - minX)
        let rangeY = (maxY - minY)
        self.frameWidth = timeLineFrame.width
        self.frameHeight = timeLineFrame.height
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
        self.rangeX = rangeX
        self.rangeY = rangeY
    }
    
}
