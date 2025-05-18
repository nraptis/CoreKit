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
    
    public var animationDuration = AnimationInstructionLoops.userLoopDurationDefault
    
    public let swatchPositionX = TimeLineSwatch(swatch: .x, defaultType: .flat, frameOffset: AnimationInstructionLoops.userLoopFrameOffsetQuarter)
    public let swatchPositionY = TimeLineSwatch(swatch: .y, defaultType: .curve, frameOffset: AnimationInstructionLoops.userLoopFrameOffsetZero)
    public let swatchScale = TimeLineSwatch(swatch: .scale, defaultType: .flat, frameOffset: AnimationInstructionLoops.userLoopFrameOffsetZero)
    public let swatchRotation = TimeLineSwatch(swatch: .rotation, defaultType: .flat, frameOffset: AnimationInstructionLoops.userLoopFrameOffsetZero)
    
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
    
    public func refreshFrame(frameWidth: Float,
                       frameHeight: Float,
                       paddingH: Float,
                       paddingV: Float) {
        
        let minX = paddingH
        let maxX = frameWidth - paddingH
        let minY = paddingV
        let maxY = frameHeight - paddingV
        let rangeX = (maxX - minX)
        let rangeY = (maxY - minY)
        
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
        
        self.rangeX = rangeX
        self.rangeY = rangeY
    }
    
    
    
}
