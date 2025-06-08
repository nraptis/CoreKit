//
//  LoopAttributeDataTimeLineChannel.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct LoopAttributeDataTimeLineChannel: Equatable {
    public let defaultType: TimeLineChannel.DefaultType
    public let normalizedTanDirection: [Float]
    public let normalizedTanMagnitudeIn: [Float]
    public let normalizedTanMagnitudeOut: [Float]
    public let normalizedX: [Float]
    public let normalizedY: [Float]
    public let isManualPositionEnabled: [Bool]
    public let isManualTanHandleEnabled: [Bool]
    public init(timeLineChannel: TimeLineChannel) {
        let controlPointCount = timeLineChannel.controlPointCount
        var _normalizedTanDirection = [Float](repeating: 0, count: controlPointCount)
        var _normalizedTanMagnitudeIn = [Float](repeating: 0, count: controlPointCount)
        var _normalizedTanMagnitudeOut = [Float](repeating: 0, count: controlPointCount)
        var _normalizedX = [Float](repeating: 0, count: controlPointCount)
        var _normalizedY = [Float](repeating: 0, count: controlPointCount)
        var _isManualPositionEnabled = [Bool](repeating: false, count: controlPointCount)
        var _isManualTanHandleEnabled = [Bool](repeating: false, count: controlPointCount)
        for controlPointIndex in 0..<controlPointCount {
            let controlPoint = timeLineChannel.controlPoints[controlPointIndex]
            _normalizedTanDirection[controlPointIndex] = controlPoint.normalizedTanDirection
            _normalizedTanMagnitudeIn[controlPointIndex] = controlPoint.normalizedTanMagnitudeIn
            _normalizedTanMagnitudeOut[controlPointIndex] = controlPoint.normalizedTanMagnitudeOut
            _normalizedX[controlPointIndex] = controlPoint.normalizedX
            _normalizedY[controlPointIndex] = controlPoint.normalizedY
            _isManualPositionEnabled[controlPointIndex] = controlPoint.isManualPositionEnabled
            _isManualTanHandleEnabled[controlPointIndex] = controlPoint.isManualTanHandleEnabled
        }
        defaultType = timeLineChannel.defaultType
        normalizedTanDirection = _normalizedTanDirection
        normalizedTanMagnitudeIn = _normalizedTanMagnitudeIn
        normalizedTanMagnitudeOut = _normalizedTanMagnitudeOut
        normalizedX = _normalizedX
        normalizedY = _normalizedY
        isManualPositionEnabled = _isManualPositionEnabled
        isManualTanHandleEnabled = _isManualTanHandleEnabled
    }
}

